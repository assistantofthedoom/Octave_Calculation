################################
########### variables ##########
################################

clear all;
close all;

antenna_csv_filename = ["Gain_lin_simulation.csv"];

presicion_fourrier = 20;

phi_to_work_on = 0;
theta_to_work_on = 1;

phi_angle_position = 0;
theta_angle_position = 0;

phi_max = 180;
phi_min = -180;
phi_step = 2;

theta_max = 180;
theta_min = 0;
theta_step = 2;

phi_column = 1;
theta_column = 2;
gain_column = 3;

################################
######### get csv data #########
################################

antenna_csv_data = csvread(antenna_csv_filename);

antenna_csv_data = antenna_csv_data(2:end,:);

################################
###### manipulate csv data #####
################################

number_phi = (phi_max - phi_min) / phi_step + 1;
number_theta = (theta_max - theta_min) / theta_step + 1;

phi_increment = (phi_angle_position - phi_min) / phi_step;
theta_increment = (theta_angle_position - theta_min) / theta_step;

if (phi_to_work_on == 1 && theta_to_work_on == 0)
	for i=1:number_phi
		antenna_reduced_data(i,1) = antenna_csv_data(i + theta_increment * number_phi,phi_column);	
		antenna_reduced_data(i,2) = antenna_csv_data(i + theta_increment * number_phi,gain_column);
	endfor
endif

if (phi_to_work_on == 0 && theta_to_work_on == 1)
	for i=1:number_theta
		antenna_reduced_data(i,1) = antenna_csv_data(phi_increment + (i-1) * number_phi + 1,theta_column);	
		antenna_reduced_data(i,2) = antenna_csv_data(phi_increment + (i-1) * number_phi + 1,gain_column);

		antenna_reduced_data(2*number_theta-i,1) = 360 - antenna_csv_data(phi_increment + (i-1) * number_phi + 1,theta_column);	
		antenna_reduced_data(2*number_theta-i,2) = antenna_csv_data(phi_increment + (i-1) * number_phi + 1,gain_column);
	endfor
endif

################################
######## linearize gain ########
################################

length_of_data = rows(antenna_reduced_data);

for i=1:length_of_data
	antenna_linear_data(i,1) = pi * antenna_reduced_data(i,1) / 180;
	antenna_linear_data(i,2) = 10 ^ (antenna_reduced_data(i,2) / 10);
endfor

################################
######## normalize gain ########
################################

max_gain = max(antenna_linear_data(:,2));
min_gain = min(antenna_linear_data(:,2));

m = max_gain - min_gain;
b = min_gain;

antenna_nomalized_data = (antenna_linear_data(:,2) - b) / m;

fourier_data = fft(antenna_nomalized_data);

real_fourier_data = 2 * real(fourier_data) / length_of_data;
imag_fourier_data = 2 * imag(fourier_data) / length_of_data;

for j=1:length_of_data
	reconstruct_function(j,1) = real_fourier_data(1) / 2;
endfor

for i=1:presicion_fourrier
	for j=1:length_of_data
		reconstruct_function(j,1) = reconstruct_function(j,1) + real_fourier_data(i+1) * cos(i*antenna_linear_data(j,1)) + imag_fourier_data(i+1) * sin(i*antenna_linear_data(j,1));
	endfor
endfor

figure(1);
hold on;
polar(antenna_linear_data(:,1),antenna_nomalized_data(:,1));
polar(antenna_linear_data(:,1),reconstruct_function(:,1));
hold off;

figure(2);
hold on;
plot(antenna_linear_data(:,1),antenna_nomalized_data(:,1));
plot(antenna_linear_data(:,1),reconstruct_function(:,1));
hold off;

fourier_coefficient(1,1) = real_fourier_data(1) / 2;
fourier_coefficient(1,2) = imag_fourier_data(1) / 2;

for i=2:presicion_fourrier
	fourier_coefficient(i,1) = real_fourier_data(i);
	fourier_coefficient(i,2) = imag_fourier_data(i);
endfor

csvwrite("fourier_coefficient_antenna.csv",fourier_coefficient);

############################################
# name of the groups and of the connexions #
############################################

close all;
clear all;

% Time in seconds for each plot in the GIF
DelayTime = 0.1; 

startx = 150;
starty = 150;
width = 1062;
height = 980;

antenna_fourier_filename = [ "fourier_coefficient_antenna.csv" ];

omnidirectionnal_directory_1 = [ "CSV" ];
omnidirectionnal_directory_2 = [ "_data_" ];
omnidirectionnal_directory_3 = [ "0-50" ];
omnidirectionnal_directory_4 = [ "_lambda" ];

omnidirectionnal_filename_1 = [ "antenna_" ];
omnidirectionnal_filename_2 = [ "fixed|moving" ];
omnidirectionnal_filename_3 = [ "|" ];
omnidirectionnal_filename_4 = [ ".csv" ];

destination_directory = ["CSV_linear"];

antenna_1_angle = 15+90;
antenna_2_angle = -15+90;

antenna_1_signal_moving = 0;
antenna_2_signal_moving = 1;

signal_angle_start = 0;
signal_angle_stop = 360;
signal_angle_step = 5;

############################
# plot as polar to compare #
############################

number_signal_angle = (signal_angle_stop - signal_angle_start) / signal_angle_step;

space_angle = antenna_1_angle - antenna_2_angle;

fourier_coefficient = csvread(antenna_fourier_filename);

number_coefficient = rows(fourier_coefficient);

for n=1:number_signal_angle

	omnidirectionnal_angle_1 = antenna_1_signal_moving * signal_angle_step * (n - 1);
	omnidirectionnal_angle_2 = antenna_2_signal_moving * signal_angle_step * (n - 1);

	omnidirectionnal_filename = strcat(omnidirectionnal_filename_1,omnidirectionnal_filename_2,"_",num2str(omnidirectionnal_angle_1),omnidirectionnal_filename_3,num2str(omnidirectionnal_angle_2),omnidirectionnal_filename_4);

	directory = [ omnidirectionnal_directory_1 , omnidirectionnal_directory_2 , omnidirectionnal_directory_3 , omnidirectionnal_directory_4 ];

	cd (omnidirectionnal_directory_1) ;
	cd (directory) ;

	omnidirectionnal_data = csvread(omnidirectionnal_filename);

	cd .. ;
	cd .. ;

	length_of_data = rows(omnidirectionnal_data);

	antenna_1_angle_radian = antenna_1_angle * pi / 180;
	antenna_2_angle_radian = antenna_2_angle * pi / 180;

	antenna_1_angular_table = omnidirectionnal_data(:,1) + pi + antenna_1_angle_radian;
	antenna_2_angular_table = omnidirectionnal_data(:,1) + pi + antenna_2_angle_radian;
	antenna_radiation = omnidirectionnal_data(:,2);

	for i=1:length_of_data
		antenna_value_1(i,1) = fourier_coefficient(1,1);
		antenna_value_2(i,1) = fourier_coefficient(1,1);
	endfor

	for i=1:length_of_data
		for j=2:number_coefficient
			antenna_value_1(i,1) = antenna_value_1(i,1) + fourier_coefficient(j,1) * cos((j-1) * antenna_1_angular_table(i,1)) + fourier_coefficient(j,2) * sin((j-1) * antenna_1_angular_table(i,1));
			antenna_value_2(i,1) = antenna_value_2(i,1) + fourier_coefficient(j,1) * cos((j-1) * antenna_2_angular_table(i,1)) + fourier_coefficient(j,2) * sin((j-1) * antenna_2_angular_table(i,1));
		endfor
	endfor

	antenna_value = (antenna_value_1 + antenna_value_2) / 2;

	for i=1:length_of_data
		radiation_pattern(i,1) = antenna_radiation(i,1) * antenna_value(i,1);
	endfor

	temp_csv(:,1) = omnidirectionnal_data(:,1);
	temp_csv(:,2) = radiation_pattern;

	if (exist((destination_directory),"dir") == 7)
		cd (destination_directory) ;
	else
		mkdir (destination_directory);
		cd (destination_directory) ;
	endif

	if (exist(omnidirectionnal_directory_3,"dir") == 7)
		cd (omnidirectionnal_directory_3) ;
	else
		mkdir (omnidirectionnal_directory_3);
		cd (omnidirectionnal_directory_3) ;
	endif

	filename = [ omnidirectionnal_filename_1 , "combined_" , num2str(space_angle) , "_" , num2str(omnidirectionnal_angle_1) , omnidirectionnal_filename_3 , num2str(omnidirectionnal_angle_2) , omnidirectionnal_filename_4 ];

	csvwrite(filename,temp_csv);

	cd .. ;
	cd .. ;

	clear("omnidirectionnal_data");
	clear("antenna_1_angular_table");
	clear("antenna_2_angular_table");
	clear("antenna_radiation");
	clear("antenna_value_1");
	clear("antenna_value_2");
	clear("antenna_value");
	clear("radiation_pattern");
	close all;

endfor

##############################
########## variables #########
##############################

close all;
clear all;

antenna_fourier_filename = [ "fourier_coefficient_antenna.csv" ];

omnidirectionnal_directory = [ "omnidirectionnal_csv" ];

omnidirectionnal_filename_1 = [ "antenna_" ];
omnidirectionnal_filename_2 = [ "fixed|moving" ];

omnidirectionnal_angle_1 = 0;
omnidirectionnal_filename_3 = [ "|" ];
omnidirectionnal_angle_2 = 120;

omnidirectionnal_filename_4 = [ ".csv" ];

antenna_1_angle = 0+90;
antenna_2_angle = -0+90;

##############################
######## #import data ########
##############################

omnidirectionnal_filename = strcat(omnidirectionnal_filename_1,omnidirectionnal_filename_2,"_",num2str(omnidirectionnal_angle_1),omnidirectionnal_filename_3,num2str(omnidirectionnal_angle_2),omnidirectionnal_filename_4);

fourier_coefficient = csvread(antenna_fourier_filename);

cd (omnidirectionnal_directory) ;

omnidirectionnal_data = csvread(omnidirectionnal_filename);

cd .. ;

length_of_data = rows(omnidirectionnal_data);

number_coefficient = rows(fourier_coefficient);

##############################
######## prepare data ########
##############################

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

[max_power_value , max_power_pos] = max(radiation_pattern);

max_power_radian = omnidirectionnal_data(max_power_pos,1);

##############################
###### plot the figures ######
##############################

space_angle = antenna_1_angle - antenna_2_angle;

title_1 = ["omnidirectionnal pattern - ",num2str(omnidirectionnal_angle_1),omnidirectionnal_filename_3,num2str(omnidirectionnal_angle_2)];
title_2 = "antenna pattern";
title_3 = ["combined pattern - ",num2str(space_angle)," - ",num2str(omnidirectionnal_angle_1),omnidirectionnal_filename_3,num2str(omnidirectionnal_angle_2)];

if(omnidirectionnal_angle_1 > 180)
	omni_angle_1 = 360 - omnidirectionnal_angle_1;
	signed = -1;
else
	omni_angle_1 = omnidirectionnal_angle_1;
	signed = 1;
endif

if(omnidirectionnal_angle_2 > 180)
	omni_angle_2 = 360 - omnidirectionnal_angle_2;
	signed = -1;
else
	omni_angle_2 = omnidirectionnal_angle_2;
	signed = 1;
endif

angle_of_emision = pi/2+asin((omni_angle_1 - omni_angle_2) / 180);

antenna_omnidirectionnal_line_x = signed * cos(angle_of_emision);
antenna_omnidirectionnal_line_y = sin(angle_of_emision);

antenna_1_line_x = cos(antenna_1_angle_radian);
antenna_1_line_y = sin(antenna_1_angle_radian);

antenna_2_line_x = cos(antenna_2_angle_radian);
antenna_2_line_y = sin(antenna_2_angle_radian);

antenna_conbined_max_x = max_power_value * cos(max_power_radian);
antenna_conbined_max_y = max_power_value * sin(max_power_radian);

angle_difference = (max_power_radian - angle_of_emision) * 180

figure(1);
polar(omnidirectionnal_data(:,1),antenna_radiation);
RTicks = [ 0 : 0.5 : 1 ];
set( gca, 'rtick', RTicks );
title(title_1);
line([0,antenna_omnidirectionnal_line_x],[0,antenna_omnidirectionnal_line_y]);
line([0,antenna_omnidirectionnal_line_x],[0,-antenna_omnidirectionnal_line_y]);

figure(2);
polar(omnidirectionnal_data(:,1),antenna_value);
RTicks = [ 0 : 0.5 : 1 ];
set( gca, 'rtick', RTicks );
title(title_2);
line([0,antenna_1_line_x],[0,antenna_1_line_y]);
line([0,antenna_2_line_x],[0,antenna_2_line_y]);

figure(3);
polar(omnidirectionnal_data(:,1),radiation_pattern);
RTicks = [ 0 : 0.5 : 1 ];
set( gca, 'rtick', RTicks );
title(title_3);
line([0,antenna_omnidirectionnal_line_x],[0,antenna_omnidirectionnal_line_y]);
line([0,antenna_conbined_max_x],[0,antenna_conbined_max_y]);

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
omnidirectionnal_directory_2 = [ "omnidirectionnal_csv_" ];
omnidirectionnal_directory_3 = [ "075" ];

omnidirectionnal_filename_1 = [ "antenna_" ];
omnidirectionnal_filename_2 = [ "fixed|moving" ];
omnidirectionnal_filename_3 = [ "|" ];
omnidirectionnal_filename_4 = [ ".csv" ];

antenna_1_angle = 22.5+90;
antenna_2_angle = -22.5+90;

antenna_1_signal_moving = 0;
antenna_2_signal_moving = 1;

signal_angle_start = 0;
signal_angle_stop = 355;
signal_angle_step = 5;

############################
# plot as polar to compare #
############################

number_signal_angle = (signal_angle_stop - signal_angle_start) / signal_angle_step;

space_angle = antenna_1_angle - antenna_2_angle;

fourier_coefficient = csvread(antenna_fourier_filename);

number_coefficient = rows(fourier_coefficient);

filename = [ omnidirectionnal_filename_1 , "combined_" , num2str(space_angle) , "_" , omnidirectionnal_filename_2 , ".gif"];

for n=1:number_signal_angle

	omnidirectionnal_angle_1 = antenna_1_signal_moving * signal_angle_step * n;
	omnidirectionnal_angle_2 = antenna_2_signal_moving * signal_angle_step * n;

	omnidirectionnal_filename = strcat(omnidirectionnal_filename_1,omnidirectionnal_filename_2,"_",num2str(omnidirectionnal_angle_1),omnidirectionnal_filename_3,num2str(omnidirectionnal_angle_2),omnidirectionnal_filename_4);

	directory = [omnidirectionnal_directory_2 omnidirectionnal_directory_3];

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

	[max_power_value , max_power_pos] = max(radiation_pattern);

	max_power_radian = omnidirectionnal_data(max_power_pos,1);

	text_title = ["combined pattern - ",num2str(space_angle)," - ",num2str(omnidirectionnal_angle_1),omnidirectionnal_filename_3,num2str(omnidirectionnal_angle_2)];

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

	antenna_conbined_max_x = max_power_value * cos(max_power_radian);
	antenna_conbined_max_y = max_power_value * sin(max_power_radian);

	angle_difference = (max_power_radian - angle_of_emision);

	max_value_at_angle_difference = 2 * fourier_coefficient(1,1);
	for i=2:number_coefficient
		max_value_at_angle_difference = max_value_at_angle_difference + fourier_coefficient(i,1) * cos((i-1) * (antenna_1_angle_radian + angle_difference)) + fourier_coefficient(i,2) * sin((i-1) * (antenna_1_angle_radian + angle_difference));;
		max_value_at_angle_difference = max_value_at_angle_difference + fourier_coefficient(i,1) * cos((i-1) * (antenna_2_angle_radian + angle_difference)) + fourier_coefficient(i,2) * sin((i-1) * (antenna_2_angle_radian + angle_difference));;
	endfor


	log_history(n,1) = n;
	log_history(n,2) = n * signal_angle_step;
	log_history(n,3) = max_power_value;
	log_history(n,4) = max_power_radian * 180 / pi;
	log_history(n,5) = angle_of_emision * 180 / pi;
	log_history(n,6) = max_value_at_angle_difference / 2;

	f = figure(1);

	polar(omnidirectionnal_data(:,1),radiation_pattern);

	pause(0.5);

	set(gcf,'position',[startx,starty,width,height]);

	pause(0.5);
	RTicks = [ 0 : 0.5 : 1 ];
	set(gca, 'rtick', RTicks );
	title(text_title);
	set(gca, "fontsize", 24);
	line([0,antenna_omnidirectionnal_line_x],[0,antenna_omnidirectionnal_line_y]);
	line([0,antenna_conbined_max_x],[0,antenna_conbined_max_y]);

	pause(0.5);

	if (exist("Gif","dir") == 7)
		cd Gif ;
	else
		mkdir Gif;
		cd Gif ;
	endif

	if (exist(omnidirectionnal_directory_3,"dir") == 7)
		cd (omnidirectionnal_directory_3) ;
	else
		mkdir (omnidirectionnal_directory_3);
		cd (omnidirectionnal_directory_3) ;
	endif

	% Image Processing
	% Assign plot to a frame
	frame = getframe(f);
	% Convert frame to RGB image (3 dimensional) 
	im = frame2im(frame);
	% Transform RGB samples to 1 dimension with a color map "cm". 
	[imind,cm] = rgb2ind(im); 
	if (n == 1)
		% Create GIF file
		imwrite(imind,cm,filename,'gif','DelayTime', DelayTime , 'Compression' , 'lzw');
	else
		% Add each new plot to GIF
		imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime', DelayTime , 'Compression' , 'lzw');
	endif

	cd .. ;
	cd .. ;

	#pause(0.5);

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

cd Gif ;
cd (omnidirectionnal_directory_3) ;

csvwrite(["log_history_combined_antenna_" , num2str(space_angle) , "_" , omnidirectionnal_filename_2 ,".csv"],log_history);

cd .. ;
cd .. ;

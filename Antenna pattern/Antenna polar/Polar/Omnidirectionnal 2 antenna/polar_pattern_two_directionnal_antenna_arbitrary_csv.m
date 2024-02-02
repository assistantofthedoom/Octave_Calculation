#########################################
####### variables for the picture #######
#########################################

clear all;
close all;

phase_step = 5;
phase_start = 0;
phase_end = 360;

########################################
####### variables for the figure #######
########################################

radius_size = 180;
angle_step = 720;

reference_x_pos = 0;
reference_y_pos = 0;

antenna_1_x_pos = -40;
antenna_1_y_pos = 0;
	antenna_1_enable = 1;
	antenna_1_enable_phase = 0;

antenna_2_x_pos = 40;
antenna_2_y_pos = 0;
	antenna_2_enable = 1;
	antenna_2_enable_phase = 1;

wave_length = 40;

remove_value_radius = 100;

########################################


frequency = (2 * pi) / wave_length;

space_reference_r = linspace(1,radius_size,radius_size) ;
space_reference_t = linspace(1,angle_step,angle_step) ;

convert_to_radian = (2*pi) / angle_step ;
convert_to_degre = 360 / angle_step ;

for i=space_reference_t
	for j=space_reference_r
		reference_x(j,i) = j * cos(i * convert_to_radian);
		reference_y(j,i) = j * sin(i * convert_to_radian);

		antenna_1_x(j,i) = reference_x(j,i) - (reference_x_pos - antenna_1_x_pos);
		antenna_1_y(j,i) = reference_y(j,i) - (reference_y_pos - antenna_1_y_pos);

		antenna_2_x(j,i) = reference_x(j,i) - (reference_x_pos - antenna_2_x_pos);
		antenna_2_y(j,i) = reference_y(j,i) - (reference_y_pos - antenna_2_y_pos);
	endfor
endfor

for i=space_reference_t
	for j=space_reference_r
		distance_antenna_1(j,i) = sqrt(antenna_1_x(j,i) * antenna_1_x(j,i) + antenna_1_y(j,i) * antenna_1_y(j,i));
		distance_antenna_2(j,i) = sqrt(antenna_2_x(j,i) * antenna_2_x(j,i) + antenna_2_y(j,i) * antenna_2_y(j,i));
	endfor
endfor

space_reference_t_degre = space_reference_t * convert_to_degre;
space_reference_t_radian = space_reference_t * convert_to_radian;


##################################
######### edit title name ########
##################################

phase_final = phase_end - phase_step;
number_step = (phase_end - phase_start) / phase_step;

if (antenna_1_enable == 1)
	angle_offset_1 = 0;
	text_1 = ["fixed|"];
	if (antenna_1_enable_phase == 1)
		angle_offset_1 = linspace(phase_start,phase_final,number_step);
		text_1 = ["moving|"];
	endif
else
	angle_offset_1 = 0;
	text_1 = ["-|"];
endif

if (antenna_2_enable == 1)
	angle_offset_2 = 0;
	text_2 = ["fixed|"];
	if (antenna_2_enable_phase == 1)
		angle_offset_2 = linspace(phase_start,phase_final,number_step);
		text_2 = ["moving"];
	endif
else
	angle_offset_2 = 0;
	text_2 = ["-"];
endif



name_1 = [text_1 , text_2];
filename = ["antenna_" , name_1];
extension = [".csv"];
directory = ["CSV_data_" , strrep(sprintf("%3.2f",(antenna_2_x_pos - antenna_1_x_pos) / wave_length),".","-") , "_lambda"];

n = 1;

log_history = zeros(columns(angle_offset_1)*columns(angle_offset_2),5);

for i = angle_offset_1
	for j = angle_offset_2

		radian_offset_1 = i * pi / 180;
		radian_offset_2 = j * pi / 180;

		if (antenna_1_enable == 1)
			text_3 = [num2str(i) , "|"];
		else
			text_3 = ["-|"];
		endif

		if (antenna_2_enable == 1)
			text_4 = [num2str(j)];
		else
			text_4 = ["-"];
		endif

		text_title = [text_3 , text_4];

		##################################
		####### create the picture #######
		##################################

		% Generate the function and plot it

		mesh_antenna_1_value = cos(frequency*distance_antenna_1 - radian_offset_1);
		mesh_antenna_2_value = cos(frequency*distance_antenna_2 - radian_offset_2);

		mesh_antenna_value = mesh_antenna_1_value + mesh_antenna_2_value;

		for j=1:remove_value_radius
			mesh_antenna_value(j,:) = 0;
		endfor

		maximum_value_space = max(mesh_antenna_value);

		maximum_value_normalized = maximum_value_space / 2;

		temp_csv = zeros(angle_step,2);

		temp_csv(:,1) = space_reference_t_radian;
		temp_csv(:,2) = maximum_value_normalized;

		% register as csv

		if (exist((directory),"dir") == 7)
		    cd (directory) ;
		else
		    mkdir (directory);
		    cd (directory) ;
		endif

		if (exist((filename),"dir") == 7)
		    cd (filename) ;
		else
		    mkdir (filename);
		    cd (filename) ;
		endif

		csvwrite([filename,"_",text_title,extension],temp_csv);

		cd ..;
		cd ..;

		% Function update loop
		n = n + 1;

	endfor
endfor

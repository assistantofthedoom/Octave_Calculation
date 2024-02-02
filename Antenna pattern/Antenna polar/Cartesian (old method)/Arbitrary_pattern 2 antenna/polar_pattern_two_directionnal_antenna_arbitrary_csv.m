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

pattern = [ 0 2*pi/25 4*pi/25 6*pi/25 8*pi/25 10*pi/25 12*pi/25 14*pi/25 16*pi/25 18*pi/25 20*pi/25 22*pi/25 24*pi/25 26*pi/25 28*pi/25 30*pi/25 32*pi/25 34*pi/25 36*pi/25 38*pi/25 40*pi/25 42*pi/25 44*pi/25 46*pi/25 48*pi/25 50*pi/25 ;
            0.1667 0.0833 0.1667 0.25 0.3333 0.4167 0.5 0.5833 0.7 0.8 0.9 0.95 1 0.95 0.9 0.8 0.7 0.5833 0.5 0.4167 0.3333 0.25 0.1667 0.0833 0.1667 0.1667 ];

matrix_size = 90;
number_of_points = 2 * matrix_size + 1;

reference_x_pos = 0;
reference_y_pos = 0;

antenna_1_x_pos = -10;
antenna_1_y_pos = 0;
antenna_1_angle = -90+90;
	antenna_1_enable = 1;
	antenna_1_enable_phase = 0;

antenna_2_x_pos = 10;
antenna_2_y_pos = 0;
antenna_2_angle = 90+90;
	antenna_2_enable = 1;
	antenna_2_enable_phase = 1;

wave_length = 40;

remove_value_radius = 60;

########################################

frequency = (2 * pi) / wave_length;

space_reference_x = linspace(-matrix_size-reference_x_pos,matrix_size-reference_x_pos,number_of_points) ;
space_reference_y = linspace(-matrix_size-reference_y_pos,matrix_size-reference_y_pos,number_of_points) ;

space_antenna_1_x = linspace(-matrix_size-antenna_1_x_pos,matrix_size-antenna_1_x_pos,number_of_points) ;
space_antenna_1_y = linspace(-matrix_size-antenna_1_y_pos,matrix_size-antenna_1_y_pos,number_of_points) ;

space_antenna_2_x = linspace(-matrix_size-antenna_2_x_pos,matrix_size-antenna_2_x_pos,number_of_points) ;
space_antenna_2_y = linspace(-matrix_size-antenna_2_y_pos,matrix_size-antenna_2_y_pos,number_of_points) ;

mesh_antenna_1_value = zeros(number_of_points,number_of_points);
mesh_antenna_2_value = zeros(number_of_points,number_of_points);

[antenna_1_x,antenna_1_y] = meshgrid(space_antenna_1_x,space_antenna_1_y);
[antenna_2_x,antenna_2_y] = meshgrid(space_antenna_2_x,space_antenna_2_y);

########################################

antenna_1_angle_radian = antenna_1_angle * pi / 180;
antenna_2_angle_radian = antenna_2_angle * pi / 180;

distance_antenna_1_value = sqrt(antenna_1_x.*antenna_1_x + antenna_1_y.*antenna_1_y);
distance_antenna_2_value = sqrt(antenna_2_x.*antenna_2_x + antenna_2_y.*antenna_2_y);

hypothetical_antenna_x_pos = (antenna_1_x_pos + antenna_2_x_pos) / 2;
hypothetical_antenna_y_pos = (antenna_1_y_pos + antenna_2_y_pos) / 2;

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
name_2 = [num2str(antenna_1_angle-90),"|",num2str(antenna_2_angle-90)];
filename = ["antenna_" , name_1 , "_" , name_2];
extension = [".csv"];

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

		mesh_antenna_1_emission = test_emission_arbitrary_pattern(number_of_points, antenna_1_angle_radian, antenna_1_x_pos, antenna_1_y_pos, matrix_size, pattern);
		mesh_antenna_2_emission = test_emission_arbitrary_pattern(number_of_points, antenna_2_angle_radian, antenna_2_x_pos, antenna_2_y_pos, matrix_size, pattern);

		% Generate the function and plot it
		mesh_antenna_value = zeros(number_of_points,number_of_points);

		mesh_antenna_1_value = cos(frequency*distance_antenna_1_value + radian_offset_1);
		mesh_antenna_2_value = cos(frequency*distance_antenna_2_value + radian_offset_2);

		mesh_antenna_1_directionnal_value = mesh_antenna_1_emission .* mesh_antenna_1_value;
		mesh_antenna_2_directionnal_value = mesh_antenna_2_emission .* mesh_antenna_2_value;

		mesh_antenna_directionnal_value = mesh_antenna_1_directionnal_value + mesh_antenna_2_directionnal_value;

		for o=1:2 * remove_value_radius + 1
			temp_value = floor(sqrt(remove_value_radius * remove_value_radius - (remove_value_radius + 1 - o) * (remove_value_radius + 1 - o)));
			for p=1:2 * temp_value + 1
				mesh_antenna_directionnal_value(matrix_size - temp_value + p,matrix_size - remove_value_radius + o) = 0;
			endfor
		endfor

		test_mesh_antenna_directionnal_value = mesh_antenna_directionnal_value;

		iteration = 0;

		do
			[max_matrix_value_y , max_matrix_pos_y] = max(test_mesh_antenna_directionnal_value);
			[max_matrix_value , max_matrix_pos_x] = max(max_matrix_value_y);

			radius = round(sqrt(((hypothetical_antenna_y_pos + matrix_size + 1) - max_matrix_pos_y(max_matrix_pos_x)) ^ 2 + ((hypothetical_antenna_x_pos + matrix_size + 1) - max_matrix_pos_x) ^ 2));
			test_mesh_antenna_directionnal_value(max_matrix_pos_y(max_matrix_pos_x),max_matrix_pos_x) = 0;
			iteration = iteration + 1;
		until(radius < matrix_size)

		for k=1:2*radius+1
			for l=1:2
				if(l==1)
					x_pos = radius + 1 - k;
					y_pos = floor(sqrt(radius * radius - x_pos * x_pos));
					angle_xy(k+2*radius+1) = atan2(y_pos , x_pos);
					value(k+2*radius+1) = abs(mesh_antenna_directionnal_value(matrix_size + 1 + hypothetical_antenna_y_pos + y_pos,matrix_size + 1 + hypothetical_antenna_x_pos + x_pos)) / 2;
				else
					x_pos = k - radius - 1;
					y_pos = -floor(sqrt(radius * radius - x_pos * x_pos));
					angle_xy(k) = atan2(y_pos , x_pos);
					value(k) = abs(mesh_antenna_directionnal_value(matrix_size + 1 + hypothetical_antenna_y_pos + y_pos,matrix_size + 1 + hypothetical_antenna_x_pos + x_pos)) / 2;
				endif
			endfor
		endfor

		log_history(n,1) = n;
		log_history(n,2) = i;
		log_history(n,3) = j;
		log_history(n,4) = iteration;
		log_history(n,5) = radius;

		temp_csv = zeros(2*(2*radius+1),2);

		
		temp_csv(:,1) = angle_xy;
		temp_csv(:,2) = value;

		% register as csv

		if (exist("Arranged","dir") == 7)
		    cd Arranged ;
		else
		    mkdir Arranged;
		    cd Arranged ;
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

		clear('value');
		clear('angle_xy');

		% Function update loop
		n = n + 1;

	endfor
endfor

if (exist("Arranged","dir") == 7)
    cd Arranged ;
else
    mkdir Arranged;
    cd Arranged ;
endif

if (exist((filename),"dir") == 7)
    cd (filename) ;
else
    mkdir (filename);
    cd (filename) ;
endif

csvwrite(["log_history_",name_1 , "_" , name_2,".csv"],log_history);

cd ..;
cd ..;

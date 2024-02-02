#############################
######### variables #########
#############################

clear all;
close all;

pattern = [ 0 2*pi/25 4*pi/25 6*pi/25 8*pi/25 10*pi/25 12*pi/25 14*pi/25 16*pi/25 18*pi/25 20*pi/25 22*pi/25 24*pi/25 26*pi/25 28*pi/25 30*pi/25 32*pi/25 34*pi/25 36*pi/25 38*pi/25 40*pi/25 42*pi/25 44*pi/25 46*pi/25 48*pi/25 50*pi/25 ;
            0.1667 0.0833 0.1667 0.25 0.3333 0.4167 0.5 0.5833 0.7 0.8 0.9 0.95 1 0.95 0.9 0.8 0.7 0.5833 0.5 0.4167 0.3333 0.25 0.1667 0.0833 0.1667 0.1667 ];

matrix_size = 90;
number_of_points = 2 * matrix_size + 1;

reference_x_pos = 0;
reference_y_pos = 0;

antenna_1_x_pos = -10;
antenna_1_y_pos = 0;
antenna_1_angle = -15+90;

antenna_2_x_pos = 10;
antenna_2_y_pos = 0;
antenna_2_angle = 15+90;

wave_length = 40;

angle_offset = 0;

remove_value_radius = 60;

#############################
###### create the mesh ######
#############################

frequency = (2 * pi) / wave_length;
radian_offset = angle_offset * pi / 180;

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

#############################
### create emission mesh ####
#############################

antenna_1_angle_radian = antenna_1_angle * pi / 180;
antenna_2_angle_radian = antenna_2_angle * pi / 180;

mesh_antenna_1_emission = test_emission_arbitrary_pattern(number_of_points, antenna_1_angle_radian, antenna_1_x_pos, antenna_1_y_pos, matrix_size, pattern);
mesh_antenna_2_emission = test_emission_arbitrary_pattern(number_of_points, antenna_2_angle_radian, antenna_2_x_pos, antenna_2_y_pos, matrix_size, pattern);

mesh_antenna_general_emission = mesh_antenna_1_emission + mesh_antenna_2_emission;

#############################
#### calculate the values ###
#############################

distance_antenna_1_value = sqrt(antenna_1_x.*antenna_1_x + antenna_1_y.*antenna_1_y);
distance_antenna_2_value = sqrt(antenna_2_x.*antenna_2_x + antenna_2_y.*antenna_2_y);

mesh_antenna_1_value = cos(frequency*distance_antenna_1_value);
mesh_antenna_2_value = cos(frequency*distance_antenna_2_value + radian_offset);

mesh_antenna_1_directionnal_value = mesh_antenna_1_emission .* mesh_antenna_1_value;
mesh_antenna_2_directionnal_value = mesh_antenna_2_emission .* mesh_antenna_2_value;

mesh_antenna_directionnal_value = mesh_antenna_1_directionnal_value + mesh_antenna_2_directionnal_value;

#############################
####### plot the mesh #######
#############################

#{
figure(1) ;
mesh(space_reference_x,space_reference_y,mesh_antenna_directionnal_value) ;
title("waves emitted from antenna on plan XY");
xlabel("x axis");
ylabel("y axis");

figure(11) ;
surface(space_reference_x,space_reference_y,mesh_antenna_directionnal_value) ;
title("waves emitted from antenna on plan XY");
xlabel("x axis");
ylabel("y axis");
#}

for o=1:2 * remove_value_radius + 1
	temp_value = floor(sqrt(remove_value_radius * remove_value_radius - (remove_value_radius + 1 - o) * (remove_value_radius + 1 - o)));
	for p=1:2 * temp_value + 1
		mesh_antenna_directionnal_value(matrix_size - temp_value + p,matrix_size - remove_value_radius + o) = 0;
	endfor
endfor

#############################
## find the radius for max ##
#############################

hypothetical_antenna_x_pos = (antenna_1_x_pos + antenna_2_x_pos) / 2;
hypothetical_antenna_y_pos = (antenna_1_y_pos + antenna_2_y_pos) / 2;

test_mesh_antenna_directionnal_value = mesh_antenna_directionnal_value;

iteration = 0;

do
	[max_matrix_value_y , max_matrix_pos_y] = max(test_mesh_antenna_directionnal_value);
	[max_matrix_value , max_matrix_pos_x] = max(max_matrix_value_y);

	radius = round(sqrt(((hypothetical_antenna_y_pos + matrix_size + 1) - max_matrix_pos_y(max_matrix_pos_x)) ^ 2 + ((hypothetical_antenna_x_pos + matrix_size + 1) - max_matrix_pos_x) ^ 2));
	test_mesh_antenna_directionnal_value(max_matrix_pos_y(max_matrix_pos_x),max_matrix_pos_x) = 0;
	iteration = iteration + 1;
until(radius < matrix_size)

iteration

radius

#############################
##### get value at max ######
#############################

#{

for i=1:2*radius+1
	for j=1:2
		if(j==1)
			x_pos = radius + 1 - i;
			y_pos = floor(sqrt(radius * radius - x_pos * x_pos));
			angle_xy(i+2*radius+1) = atan2(y_pos , x_pos);
			value(i+2*radius+1) = abs(mesh_antenna_directionnal_value(matrix_size + 1 + hypothetical_antenna_y_pos + y_pos,matrix_size + 1 + hypothetical_antenna_x_pos + x_pos))/2;
		else
			x_pos = i - radius - 1;
			y_pos = -floor(sqrt(radius * radius - x_pos * x_pos));
			angle_xy(i) = atan2(y_pos , x_pos);
			value(i) = abs(mesh_antenna_directionnal_value(matrix_size + 1 + hypothetical_antenna_y_pos + y_pos,matrix_size + 1 + hypothetical_antenna_x_pos + x_pos))/2;
		endif
	endfor
endfor

#############################
####### plot pattern ########
#############################

figure(111) ;
polar(angle_xy,value);

figure(112) ;
plot(angle_xy*180/pi,value);

#}

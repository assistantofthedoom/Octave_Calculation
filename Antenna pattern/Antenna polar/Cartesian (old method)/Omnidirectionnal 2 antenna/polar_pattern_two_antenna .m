#############################
######### variables #########
#############################

clear all;
close all;

matrix_size = 100;
number_of_points = 2 * matrix_size + 1;

reference_x_pos = 0;
reference_y_pos = 0;

antenna_1_x_pos = -10;
antenna_1_y_pos = 0;

antenna_2_x_pos = 10;
antenna_2_y_pos = 0;

wave_length = 40;

angle_offset = 30;

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
#### calculate the values ###
#############################

distance_antenna_1_value = sqrt(antenna_1_x.*antenna_1_x + antenna_1_y.*antenna_1_y);
distance_antenna_2_value = sqrt(antenna_2_x.*antenna_2_x + antenna_2_y.*antenna_2_y);

mesh_antenna_1_value = cos(frequency*distance_antenna_1_value);
mesh_antenna_2_value = cos(frequency*distance_antenna_2_value + radian_offset);

mesh_antenna_value = mesh_antenna_1_value + mesh_antenna_2_value;

#############################
####### plot the mesh #######
#############################

figure(1) ;
mesh(space_reference_x,space_reference_y,mesh_antenna_value) ;
title("waves emitted from antenna on plan XY");
xlabel("x axis");
ylabel("y axis");

figure(11) ;
surface(space_reference_x,space_reference_y,mesh_antenna_value) ;
title("waves emitted from antenna on plan XY");
xlabel("x axis");
ylabel("y axis");

#############################
## find the radius for max ##
#############################

hypothetical_antenna_x_pos = (antenna_1_x_pos + antenna_2_x_pos) / 2;
hypothetical_antenna_y_pos = (antenna_1_y_pos + antenna_2_y_pos) / 2;

[max_matrix_value_y , max_matrix_pos_y] = max(mesh_antenna_value);
[max_matrix_value , max_matrix_pos_x] = max(max_matrix_value_y);

radius = round(sqrt(((hypothetical_antenna_y_pos + matrix_size + 1) - max_matrix_pos_y(max_matrix_pos_x)) ^ 2 + ((hypothetical_antenna_x_pos + matrix_size + 1) - max_matrix_pos_x) ^ 2));

#############################
##### get value at max ######
#############################

for i=1:2*radius+1
	for j=1:2
		if(j==1)
			x_pos = radius + 1 - i;
			y_pos = floor(sqrt(radius * radius - x_pos * x_pos));
			angle_xy(i+2*radius+1) = atan2(y_pos , x_pos);
			value(i+2*radius+1) = abs(mesh_antenna_value(matrix_size + 1 + hypothetical_antenna_y_pos + y_pos,matrix_size + 1 + hypothetical_antenna_x_pos + x_pos)) / max_matrix_value;
		else
			x_pos = i - radius - 1;
			y_pos = -floor(sqrt(radius * radius - x_pos * x_pos));
			angle_xy(i) = atan2(y_pos , x_pos);
			value(i) = abs(mesh_antenna_value(matrix_size + 1 + hypothetical_antenna_y_pos + y_pos,matrix_size + 1 + hypothetical_antenna_x_pos + x_pos)) / max_matrix_value;
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


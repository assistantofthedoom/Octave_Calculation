#############################
######### variables #########
#############################

clear all;
close all;

radius_size = 60;
angle_step = 720;

reference_x_pos = 0;
reference_y_pos = 0;

antenna_1_x_pos = -10;
antenna_1_y_pos = 0;

antenna_2_x_pos = 10;
antenna_2_y_pos = 0;

wave_length = 40;

angle_offset = 300;

remove_value_radius = 20;

#############################
###### create the mesh ######
#############################

frequency = (2 * pi) / wave_length;
radian_offset = angle_offset * pi / 180;

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

#{
	figure(1);
	mesh(space_reference_t,space_reference_r,reference_x);

	figure(2);
	mesh(space_reference_t,space_reference_r,reference_y);

	figure(3);
	mesh(space_reference_t,space_reference_r,antenna_1_x);

	figure(4);
	mesh(space_reference_t,space_reference_r,antenna_1_y);

	figure(5);
	mesh(space_reference_t,space_reference_r,antenna_2_x);

	figure(6);
	mesh(space_reference_t,space_reference_r,antenna_2_y);
#}

#############################
#### calculate the values ###
#############################

for i=space_reference_t
	for j=space_reference_r
		distance_antenna_1(j,i) = sqrt(antenna_1_x(j,i) * antenna_1_x(j,i) + antenna_1_y(j,i) * antenna_1_y(j,i));
		distance_antenna_2(j,i) = sqrt(antenna_2_x(j,i) * antenna_2_x(j,i) + antenna_2_y(j,i) * antenna_2_y(j,i));
	endfor
endfor

#{
	figure(13);
	mesh(space_reference_t,space_reference_r,distance_antenna_1);

	figure(15);
	mesh(space_reference_t,space_reference_r,distance_antenna_2);
#}

mesh_antenna_1_value = cos(frequency*distance_antenna_1);
mesh_antenna_2_value = cos(frequency*distance_antenna_2 + radian_offset);

mesh_antenna_value = mesh_antenna_1_value + mesh_antenna_2_value;

#############################
####### plot the mesh #######
#############################

#{
	figure(1) ;
	mesh(space_reference_t,space_reference_r,mesh_antenna_value) ;
	title("waves emitted from antenna on plan XY");
	xlabel("x axis");
	ylabel("y axis");

	figure(11) ;
	surface(space_reference_t,space_reference_r,mesh_antenna_value) ;
	title("waves emitted from antenna on plan XY");
	xlabel("x axis");
	ylabel("y axis");
#}

#############################
##### get value at max ######
#############################

for j=1:remove_value_radius
	mesh_antenna_value(j,:) = 0;
endfor

maximum_value_space = max(mesh_antenna_value);

maximum_value_normalized = maximum_value_space / 2;

#############################
####### plot pattern ########
#############################

space_reference_t_degre = space_reference_t * convert_to_degre;
space_reference_t_radian = space_reference_t * convert_to_radian;

figure(111) ;
polar(space_reference_t_radian,maximum_value_normalized);

figure(112) ;
plot(space_reference_t_degre,maximum_value_normalized);


#############################
######### variables #########
#############################

clear all;
close all;

FFT_coefficient_filename = [ "fourier_coefficient_antenna.csv" ];

matrix_size = 100;
number_of_points = 2 * matrix_size + 1;

minimum_value = 0.6;
minimum_value_global = 1.2;

minimum_value_lobe = 0.5;

reference_x_pos = 0;
reference_y_pos = 0;

antenna_1_x_pos = 10;
antenna_1_y_pos = -0;
antenna_1_angle = -30+90;

antenna_2_x_pos = -10;
antenna_2_y_pos = -0;
antenna_2_angle = 30+90;

wave_length = 40;

angle_offset = 0;

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

mesh_antenna_1_emission = test_emission_FFT_pattern(number_of_points, antenna_1_angle_radian, antenna_1_x_pos, antenna_1_y_pos, matrix_size, FFT_coefficient_filename);
mesh_antenna_2_emission = test_emission_FFT_pattern(number_of_points, antenna_2_angle_radian, antenna_2_x_pos, antenna_2_y_pos, matrix_size, FFT_coefficient_filename);

mesh_antenna_general_emission = mesh_antenna_1_emission + mesh_antenna_2_emission;

figure(31) ;
mesh(space_reference_x,space_reference_y,mesh_antenna_1_emission) ;
title("emission intensity of the antenna 1 in plan XY");

figure(34) ;
mesh(space_reference_x,space_reference_y,mesh_antenna_2_emission) ;
title("emission intensity of the antenna 2 in plan XY");

figure(37) ;
mesh(space_reference_x,space_reference_y,mesh_antenna_general_emission) ;
title("emission intensity of the two antennas in plan XY");

#############################
#### calculate the values ###
#############################

distance_antenna_1_value = sqrt(antenna_1_x.*antenna_1_x + antenna_1_y.*antenna_1_y);
distance_antenna_2_value = sqrt(antenna_2_x.*antenna_2_x + antenna_2_y.*antenna_2_y);

mesh_antenna_1_value = cos(frequency*distance_antenna_1_value);
mesh_antenna_2_value = cos(frequency*distance_antenna_2_value + radian_offset);

mesh_antenna_1_directionnal_value = mesh_antenna_1_emission .* mesh_antenna_1_value;
mesh_antenna_2_directionnal_value = mesh_antenna_2_emission .* mesh_antenna_2_value;

#{
figure(21) ;
surface(space_reference_x,space_reference_y,mesh_antenna_1_value) ;

figure(24) ;
surface(space_reference_x,space_reference_y,mesh_antenna_2_value) ;

figure(31) ;
surface(space_reference_x,space_reference_y,mesh_antenna_1_directionnal_value) ;

figure(34) ;
surface(space_reference_x,space_reference_y,mesh_antenna_2_directionnal_value) ;
#}

mesh_antenna_directionnal_value = mesh_antenna_1_directionnal_value + mesh_antenna_2_directionnal_value;

mesh_antenna_1_boolean = zeros(number_of_points,number_of_points);
mesh_antenna_2_boolean = zeros(number_of_points,number_of_points);

mesh_antenna_directionnal_boolean = zeros(number_of_points,number_of_points);

for i=1:number_of_points
    for j=1:number_of_points
        if (mesh_antenna_1_directionnal_value(i,j) > minimum_value)
            mesh_antenna_1_directionnal_boolean(i,j) = 1;
        endif
        if (mesh_antenna_1_directionnal_value(i,j) < -minimum_value)
            mesh_antenna_1_directionnal_boolean(i,j) = -1;
        endif
        if (mesh_antenna_2_directionnal_value(i,j) > minimum_value)
            mesh_antenna_2_directionnal_boolean(i,j) = 1;
        endif
        if (mesh_antenna_2_directionnal_value(i,j) < -minimum_value)
            mesh_antenna_2_directionnal_boolean(i,j) = -1;
        endif
    endfor
endfor

mesh_antenna_1_directionnal_boolean(number_of_points-matrix_size+antenna_1_y_pos,number_of_points-matrix_size+antenna_1_x_pos) = 3;
mesh_antenna_2_directionnal_boolean(number_of_points-matrix_size+antenna_2_y_pos,number_of_points-matrix_size+antenna_2_x_pos) = 3;

#mesh_antenna_boolean = mesh_antenna_1_boolean + mesh_antenna_2_boolean;

mesh_antenna_directionnal_boolean(number_of_points-matrix_size+antenna_1_y_pos,number_of_points-matrix_size+antenna_1_x_pos) = 3;
mesh_antenna_directionnal_boolean(number_of_points-matrix_size+antenna_2_y_pos,number_of_points-matrix_size+antenna_2_x_pos) = 3;

for i=1:number_of_points
	for j=1:number_of_points
		if (mesh_antenna_directionnal_value(i,j) > minimum_value_lobe)
		    	mesh_antenna_directionnal_boolean(i,j) = 0.5;
			if (mesh_antenna_directionnal_value(i,j) > minimum_value_global)
		    		mesh_antenna_directionnal_boolean(i,j) = 1;
			endif
		endif

		if (mesh_antenna_directionnal_value(i,j) < -minimum_value_lobe)
		    	mesh_antenna_directionnal_boolean(i,j) = -0.5;
			if (mesh_antenna_directionnal_value(i,j) < -minimum_value_global)
		    		mesh_antenna_directionnal_boolean(i,j) = -1;
			endif
		endif
	endfor
endfor

mesh_antenna_directionnal_boolean(number_of_points-matrix_size+antenna_1_y_pos,number_of_points-matrix_size+antenna_1_x_pos) = 3;
mesh_antenna_directionnal_boolean(number_of_points-matrix_size+antenna_2_y_pos,number_of_points-matrix_size+antenna_2_x_pos) = 3;

#############################
####### plot the mesh #######
#############################

#{
figure(2) ;
mesh(space_antenna_1_x,space_antenna_1_y,mesh_antenna_1_value) ;

figure(3) ;
mesh(space_antenna_1_x,space_antenna_1_y,mesh_antenna_2_value) ;

figure(2) ;
mesh(space_antenna_1_x,space_antenna_1_y,mesh_antenna_1_boolean) ;

figure(3) ;
mesh(space_antenna_1_x,space_antenna_1_y,mesh_antenna_2_boolean) ;
#}

figure(1) ;
mesh(space_reference_x,space_reference_y,mesh_antenna_directionnal_value) ;
title("waves emitted from antenna on plan XY");
xlabel("x axis");
ylabel("y axis");

figure(4) ;
mesh(space_reference_x,space_reference_y,mesh_antenna_directionnal_boolean) ;
title("boolean waves emitted from antenna on plan XY");
xlabel("x axis");
ylabel("y axis");

figure(11) ;
surface(space_reference_x,space_reference_y,mesh_antenna_directionnal_value) ;
title("waves emitted from antenna on plan XY");
xlabel("x axis");
ylabel("y axis");

figure(14) ;
surface(space_reference_x,space_reference_y,mesh_antenna_directionnal_boolean) ;
title("boolean waves emitted from antenna on plan XY");
xlabel("x axis");
ylabel("y axis");

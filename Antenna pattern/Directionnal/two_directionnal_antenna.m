#############################
######### variables #########
#############################

clear all;
close all;

matrix_size = 200;
number_of_points = 2 * matrix_size + 1;

minimum_value = 0.8;
minimum_value_global = 1.6;

reference_x_pos = 0;
reference_y_pos = 0;

antenna_1_x_pos = 13;
antenna_1_y_pos = -150;
antenna_1_angle = -15 + 90;

antenna_2_x_pos = -12;
antenna_2_y_pos = -150;
antenna_2_angle = 15 + 90;

wave_length = 50;

angle_offset = 60;

angle_emission = 90;

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

antenna_1_angle_1 = antenna_1_angle + angle_emission / 2;
antenna_1_angle_2 = antenna_1_angle - angle_emission / 2;

antenna_2_angle_1 = antenna_2_angle + angle_emission / 2;
antenna_2_angle_2 = antenna_2_angle - angle_emission / 2;

if (antenna_1_angle_1 < 0 || antenna_1_angle_1 >= 360)
	antenna_1_angle_1 =mod(antenna_1_angle_1,360);
endif
if (antenna_1_angle_2 < 0 || antenna_1_angle_2 >= 360)
	antenna_1_angle_2 =mod(antenna_1_angle_2,360);
endif
if (antenna_2_angle_1 < 0 || antenna_2_angle_1 >= 360)
	antenna_2_angle_1 =mod(antenna_2_angle_1,360);
endif
if (antenna_2_angle_2 < 0 || antenna_2_angle_2 >= 360)
	antenna_2_angle_2 =mod(antenna_2_angle_2,360);
endif

mesh_antenna_1_emission = test_emission(number_of_points, antenna_1_angle_1, antenna_1_angle_2, antenna_1_x_pos, antenna_1_y_pos, matrix_size, angle_emission);
mesh_antenna_2_emission = test_emission(number_of_points, antenna_2_angle_1, antenna_2_angle_2, antenna_2_x_pos, antenna_2_y_pos, matrix_size, angle_emission);

#{
figure(21) ;
surface(space_reference_x,space_reference_y,mesh_antenna_1_emission) ;

figure(24) ;
surface(space_reference_x,space_reference_y,mesh_antenna_2_emission) ;
#}

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
        if (mesh_antenna_directionnal_value(i,j) > minimum_value_global)
            mesh_antenna_directionnal_boolean(i,j) = 1;
        endif
        if (mesh_antenna_directionnal_value(i,j) < -minimum_value_global)
            mesh_antenna_directionnal_boolean(i,j) = -1;
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

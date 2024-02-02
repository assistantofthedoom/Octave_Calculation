#############################
######### variables #########
#############################

clear all;
close all;

minimum_value = 0.9;
minimum_value_global = 1.8;

matrix_size = 200;
number_of_points = 2 * matrix_size + 1;

reference_x_pos = 0;
reference_y_pos = 0;

antenna_1_x_pos = 0;
antenna_1_y_pos = 0;

antenna_2_x_pos = 25;
antenna_2_y_pos = 0;

antenna_3_x_pos = -25;
antenna_3_y_pos = 0;

antenna_4_x_pos = 50;
antenna_4_y_pos = 0;

antenna_5_x_pos = -50;
antenna_5_y_pos = 0;

antenna_6_x_pos = 75;
antenna_6_y_pos = 0;

antenna_7_x_pos = -75;
antenna_7_y_pos = 0;

wave_length = 50;

angle_offset = 90;

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

space_antenna_3_x = linspace(-matrix_size-antenna_3_x_pos,matrix_size-antenna_3_x_pos,number_of_points) ;
space_antenna_3_y = linspace(-matrix_size-antenna_3_y_pos,matrix_size-antenna_3_y_pos,number_of_points) ;

space_antenna_4_x = linspace(-matrix_size-antenna_4_x_pos,matrix_size-antenna_4_x_pos,number_of_points) ;
space_antenna_4_y = linspace(-matrix_size-antenna_4_y_pos,matrix_size-antenna_4_y_pos,number_of_points) ;

space_antenna_5_x = linspace(-matrix_size-antenna_5_x_pos,matrix_size-antenna_5_x_pos,number_of_points) ;
space_antenna_5_y = linspace(-matrix_size-antenna_5_y_pos,matrix_size-antenna_5_y_pos,number_of_points) ;

space_antenna_6_x = linspace(-matrix_size-antenna_6_x_pos,matrix_size-antenna_6_x_pos,number_of_points) ;
space_antenna_6_y = linspace(-matrix_size-antenna_6_y_pos,matrix_size-antenna_6_y_pos,number_of_points) ;

space_antenna_7_x = linspace(-matrix_size-antenna_7_x_pos,matrix_size-antenna_7_x_pos,number_of_points) ;
space_antenna_7_y = linspace(-matrix_size-antenna_7_y_pos,matrix_size-antenna_7_y_pos,number_of_points) ;

mesh_antenna_1_value = zeros(number_of_points,number_of_points);
mesh_antenna_2_value = zeros(number_of_points,number_of_points);
mesh_antenna_3_value = zeros(number_of_points,number_of_points);
mesh_antenna_4_value = zeros(number_of_points,number_of_points);
mesh_antenna_5_value = zeros(number_of_points,number_of_points);
mesh_antenna_6_value = zeros(number_of_points,number_of_points);
mesh_antenna_7_value = zeros(number_of_points,number_of_points);

[antenna_1_x,antenna_1_y] = meshgrid(space_antenna_1_x,space_antenna_1_y);
[antenna_2_x,antenna_2_y] = meshgrid(space_antenna_2_x,space_antenna_2_y);
[antenna_3_x,antenna_3_y] = meshgrid(space_antenna_3_x,space_antenna_3_y);
[antenna_4_x,antenna_4_y] = meshgrid(space_antenna_4_x,space_antenna_4_y);
[antenna_5_x,antenna_5_y] = meshgrid(space_antenna_5_x,space_antenna_5_y);
[antenna_6_x,antenna_6_y] = meshgrid(space_antenna_6_x,space_antenna_6_y);
[antenna_7_x,antenna_7_y] = meshgrid(space_antenna_7_x,space_antenna_7_y);

#############################
#### calculate the values ###
#############################

distance_antenna_1_value = sqrt(antenna_1_x.*antenna_1_x + antenna_1_y.*antenna_1_y);
distance_antenna_2_value = sqrt(antenna_2_x.*antenna_2_x + antenna_2_y.*antenna_2_y);
distance_antenna_3_value = sqrt(antenna_3_x.*antenna_3_x + antenna_3_y.*antenna_3_y);
distance_antenna_4_value = sqrt(antenna_4_x.*antenna_4_x + antenna_4_y.*antenna_4_y);
distance_antenna_5_value = sqrt(antenna_5_x.*antenna_5_x + antenna_5_y.*antenna_5_y);
distance_antenna_6_value = sqrt(antenna_6_x.*antenna_6_x + antenna_6_y.*antenna_6_y);
distance_antenna_7_value = sqrt(antenna_7_x.*antenna_7_x + antenna_7_y.*antenna_7_y);

mesh_antenna_1_value = cos(frequency*distance_antenna_1_value);
mesh_antenna_2_value = cos(frequency*distance_antenna_2_value + radian_offset);
mesh_antenna_3_value = cos(frequency*distance_antenna_3_value - radian_offset);
mesh_antenna_4_value = cos(frequency*distance_antenna_4_value + (2 * radian_offset));
mesh_antenna_5_value = cos(frequency*distance_antenna_5_value - (2 * radian_offset));
mesh_antenna_6_value = cos(frequency*distance_antenna_6_value + (3 * radian_offset));
mesh_antenna_7_value = cos(frequency*distance_antenna_7_value - (3 * radian_offset));

mesh_antenna_value = mesh_antenna_1_value + mesh_antenna_2_value + mesh_antenna_3_value + mesh_antenna_4_value + mesh_antenna_5_value + mesh_antenna_6_value + mesh_antenna_7_value;

mesh_antenna_1_boolean = zeros(number_of_points,number_of_points);
mesh_antenna_2_boolean = zeros(number_of_points,number_of_points);
mesh_antenna_3_boolean = zeros(number_of_points,number_of_points);
mesh_antenna_4_boolean = zeros(number_of_points,number_of_points);
mesh_antenna_5_boolean = zeros(number_of_points,number_of_points);
mesh_antenna_6_boolean = zeros(number_of_points,number_of_points);
mesh_antenna_7_boolean = zeros(number_of_points,number_of_points);

mesh_antenna_boolean = zeros(number_of_points,number_of_points);

for i=1:number_of_points
    for j=1:number_of_points
        if (mesh_antenna_1_value(i,j) > minimum_value)
            mesh_antenna_1_boolean(i,j) = 1;
        endif
        if (mesh_antenna_1_value(i,j) < -minimum_value)
            mesh_antenna_1_boolean(i,j) = -1;
        endif
        if (mesh_antenna_2_value(i,j) > minimum_value)
            mesh_antenna_2_boolean(i,j) = 1;
        endif
        if (mesh_antenna_2_value(i,j) < -minimum_value)
            mesh_antenna_2_boolean(i,j) = -1;
        endif
        if (mesh_antenna_3_value(i,j) > minimum_value)
            mesh_antenna_3_boolean(i,j) = 1;
        endif
        if (mesh_antenna_3_value(i,j) < -minimum_value)
            mesh_antenna_3_boolean(i,j) = -1;
        endif
        if (mesh_antenna_4_value(i,j) > minimum_value)
            mesh_antenna_4_boolean(i,j) = 1;
        endif
        if (mesh_antenna_4_value(i,j) < -minimum_value)
            mesh_antenna_4_boolean(i,j) = -1;
        endif
        if (mesh_antenna_5_value(i,j) > minimum_value)
            mesh_antenna_5_boolean(i,j) = 1;
        endif
        if (mesh_antenna_5_value(i,j) < -minimum_value)
            mesh_antenna_5_boolean(i,j) = -1;
        endif
        if (mesh_antenna_6_value(i,j) > minimum_value)
            mesh_antenna_6_boolean(i,j) = 1;
        endif
        if (mesh_antenna_6_value(i,j) < -minimum_value)
            mesh_antenna_6_boolean(i,j) = -1;
        endif
        if (mesh_antenna_7_value(i,j) > minimum_value)
            mesh_antenna_7_boolean(i,j) = 1;
        endif
        if (mesh_antenna_7_value(i,j) < -minimum_value)
            mesh_antenna_7_boolean(i,j) = -1;
        endif
    endfor
endfor

mesh_antenna_1_boolean(number_of_points-matrix_size+antenna_1_y_pos,number_of_points-matrix_size+antenna_1_x_pos) = 3;
mesh_antenna_2_boolean(number_of_points-matrix_size+antenna_2_y_pos,number_of_points-matrix_size+antenna_2_x_pos) = 3;
mesh_antenna_3_boolean(number_of_points-matrix_size+antenna_3_y_pos,number_of_points-matrix_size+antenna_3_x_pos) = 3;
mesh_antenna_4_boolean(number_of_points-matrix_size+antenna_4_y_pos,number_of_points-matrix_size+antenna_4_x_pos) = 3;
mesh_antenna_5_boolean(number_of_points-matrix_size+antenna_5_y_pos,number_of_points-matrix_size+antenna_5_x_pos) = 3;
mesh_antenna_6_boolean(number_of_points-matrix_size+antenna_6_y_pos,number_of_points-matrix_size+antenna_6_x_pos) = 3;
mesh_antenna_7_boolean(number_of_points-matrix_size+antenna_7_y_pos,number_of_points-matrix_size+antenna_7_x_pos) = 3;

#mesh_antenna_boolean = mesh_antenna_1_boolean + mesh_antenna_2_boolean + mesh_antenna_3_boolean + mesh_antenna_4_boolean + mesh_antenna_5_boolean + mesh_antenna_6_boolean + mesh_antenna_7_boolean;

for i=1:number_of_points
    for j=1:number_of_points
        if (mesh_antenna_value(i,j) > minimum_value_global)
            mesh_antenna_boolean(i,j) = 1;
        endif
        if (mesh_antenna_value(i,j) < -minimum_value_global)
            mesh_antenna_boolean(i,j) = -1;
        endif
    endfor
endfor

mesh_antenna_boolean(number_of_points-matrix_size+antenna_1_y_pos,number_of_points-matrix_size+antenna_1_x_pos) = 3;
mesh_antenna_boolean(number_of_points-matrix_size+antenna_2_y_pos,number_of_points-matrix_size+antenna_2_x_pos) = 3;
mesh_antenna_boolean(number_of_points-matrix_size+antenna_3_y_pos,number_of_points-matrix_size+antenna_3_x_pos) = 3;
mesh_antenna_boolean(number_of_points-matrix_size+antenna_4_y_pos,number_of_points-matrix_size+antenna_4_x_pos) = 3;
mesh_antenna_boolean(number_of_points-matrix_size+antenna_5_y_pos,number_of_points-matrix_size+antenna_5_x_pos) = 3;
mesh_antenna_boolean(number_of_points-matrix_size+antenna_6_y_pos,number_of_points-matrix_size+antenna_6_x_pos) = 3;
mesh_antenna_boolean(number_of_points-matrix_size+antenna_7_y_pos,number_of_points-matrix_size+antenna_7_x_pos) = 3;

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

figure(4) ;
mesh(space_antenna_1_x,space_antenna_1_y,mesh_antenna_3_boolean) ;

figure(5) ;
mesh(space_antenna_1_x,space_antenna_1_y,mesh_antenna_4_boolean) ;

figure(6) ;
mesh(space_antenna_1_x,space_antenna_1_y,mesh_antenna_5_boolean) ;
#}

figure(1) ;
mesh(space_reference_x,space_reference_y,mesh_antenna_value) ;

figure(7) ;
mesh(space_reference_x,space_reference_y,mesh_antenna_boolean) ;

figure(11) ;
surface(space_reference_x,space_reference_y,mesh_antenna_value) ;

figure(17) ;
surface(space_reference_x,space_reference_y,mesh_antenna_boolean) ;

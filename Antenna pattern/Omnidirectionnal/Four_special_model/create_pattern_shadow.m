#########################################
####### variables for the picture #######
#########################################

clear all;
close all;

% Time in seconds for each plot in the GIF
DelayTime = 0.1; 

startx = 150;
starty = 150;
width = 1062;
height = 980;

minimum_value = 1.8;
maximum_value = 0.2;

########################################
####### variables for the figure #######
########################################

matrix_size = 200;
number_of_points = 2 * matrix_size + 1;

reference_x_pos = 0;
reference_y_pos = 0;

antenna_1_x_pos = -12;
antenna_1_y_pos = 0;
	antenna_1_enable = 1;
	angle_offset_1 = 0;

antenna_2_x_pos = 13;
antenna_2_y_pos = 0;
	antenna_2_enable = 1;
	angle_offset_2 = 0;

antenna_3_x_pos = -33;
antenna_3_y_pos = -13;
	antenna_3_enable = 1;
	angle_offset_3 = 200;

antenna_4_x_pos = 34;
antenna_4_y_pos = -13;
	antenna_4_enable = 0;
	angle_offset_4 = 0;

wave_length = 50;

########################################

frequency = (2 * pi) / wave_length;
radian_offset_1 = angle_offset_1 * pi / 180;
radian_offset_2 = angle_offset_2 * pi / 180;
radian_offset_3 = angle_offset_3 * pi / 180;
radian_offset_4 = angle_offset_4 * pi / 180;

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

mesh_antenna_1_value = zeros(number_of_points,number_of_points);
mesh_antenna_2_value = zeros(number_of_points,number_of_points);
mesh_antenna_3_value = zeros(number_of_points,number_of_points);
mesh_antenna_4_value = zeros(number_of_points,number_of_points);

[antenna_1_x,antenna_1_y] = meshgrid(space_antenna_1_x,space_antenna_1_y);
[antenna_2_x,antenna_2_y] = meshgrid(space_antenna_2_x,space_antenna_2_y);
[antenna_3_x,antenna_3_y] = meshgrid(space_antenna_3_x,space_antenna_3_y);
[antenna_4_x,antenna_4_y] = meshgrid(space_antenna_4_x,space_antenna_4_y);

########################################

distance_antenna_1_value = sqrt(antenna_1_x.*antenna_1_x + antenna_1_y.*antenna_1_y);
distance_antenna_2_value = sqrt(antenna_2_x.*antenna_2_x + antenna_2_y.*antenna_2_y);
distance_antenna_3_value = sqrt(antenna_3_x.*antenna_3_x + antenna_3_y.*antenna_3_y);
distance_antenna_4_value = sqrt(antenna_4_x.*antenna_4_x + antenna_4_y.*antenna_4_y);

##################################
######### edit title name ########
##################################

if (antenna_1_enable == 1)
	text_1 = [num2str(angle_offset_1) , "|"];
else
	text_1 = ["-|"];
endif

if (antenna_2_enable == 1)
	text_2 = [num2str(angle_offset_2) , "|"];
else
	text_2 = ["-|"];
endif

if (antenna_3_enable == 1)
	text_3 = [num2str(angle_offset_3) , "|"];
else
	text_3 = ["-|"];
endif

if (antenna_4_enable == 1)
	text_4 = [num2str(angle_offset_4)];
else
	text_4 = ["-"];
endif

text_title = [text_3 , text_1 , text_2 , text_4];
filename = ["antenna_" , text_title , ".gif"];

##################################
####### create the picture #######
##################################

% Generate the function and plot it
mesh_antenna_value = zeros(number_of_points,number_of_points);

mesh_antenna_1_value = antenna_1_enable * cos(frequency*distance_antenna_1_value + radian_offset_1);
mesh_antenna_2_value = antenna_2_enable * cos(frequency*distance_antenna_2_value + radian_offset_2);
mesh_antenna_3_value = antenna_3_enable * cos(frequency*distance_antenna_3_value + radian_offset_3);
mesh_antenna_4_value = antenna_4_enable * cos(frequency*distance_antenna_4_value + radian_offset_4);

mesh_antenna_value = mesh_antenna_1_value + mesh_antenna_2_value + mesh_antenna_3_value + mesh_antenna_4_value;

mesh_antenna_value(number_of_points-matrix_size+antenna_1_y_pos,number_of_points-matrix_size+antenna_1_x_pos) = 3;
mesh_antenna_value(number_of_points-matrix_size+antenna_2_y_pos,number_of_points-matrix_size+antenna_2_x_pos) = 3;
mesh_antenna_value(number_of_points-matrix_size+antenna_3_y_pos,number_of_points-matrix_size+antenna_3_x_pos) = 3;
mesh_antenna_value(number_of_points-matrix_size+antenna_4_y_pos,number_of_points-matrix_size+antenna_4_x_pos) = 3;

mesh_antenna_boolean = zeros(number_of_points,number_of_points);

for i2=1:number_of_points
    for j2=1:number_of_points
	if (abs(mesh_antenna_value(i2,j2)) > minimum_value)
	    mesh_antenna_boolean(i2,j2) = 1;
	endif
	if (abs(mesh_antenna_value(i2,j2)) < maximum_value)
	    mesh_antenna_boolean(i2,j2) = -1;
	endif
    endfor
endfor

mesh_antenna_boolean(number_of_points-matrix_size+antenna_1_y_pos,number_of_points-matrix_size+antenna_1_x_pos) = 3;
mesh_antenna_boolean(number_of_points-matrix_size+antenna_2_y_pos,number_of_points-matrix_size+antenna_2_x_pos) = 3;
mesh_antenna_boolean(number_of_points-matrix_size+antenna_3_y_pos,number_of_points-matrix_size+antenna_3_x_pos) = 3;
mesh_antenna_boolean(number_of_points-matrix_size+antenna_4_y_pos,number_of_points-matrix_size+antenna_4_x_pos) = 3;

% Create empty figure and assign number
f = figure('position',[startx,starty,width,height]);

pause(0.1);

surface(space_reference_x,space_reference_y,mesh_antenna_boolean) ;
title(text_title);
set(gca, "fontsize", 24);
xlim([-matrix_size,matrix_size]);
drawnow

pause(0.1);

% Image Processing
% Assign plot to a frame
frame = getframe(f);
% Convert frame to RGB image (3 dimensional) 
im = frame2im(frame);
% Transform RGB samples to 1 dimension with a color map "cm". 
[imind,cm] = rgb2ind(im); 
% Create GIF file
imwrite(imind,cm,filename,'gif','DelayTime', DelayTime , 'Compression' , 'lzw');


pause(0.1);

close all;

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

########################################
####### variables for the figure #######
########################################

matrix_size = 200;
number_of_points = 2 * matrix_size + 1;

reference_x_pos = 0;
reference_y_pos = 0;

antenna_1_x_pos = -60;
antenna_1_y_pos = 0;
	antenna_1_enable = 1;
	angle_offset_1 = 0;

antenna_2_x_pos = -40;
antenna_2_y_pos = 0;
	antenna_2_enable = 1;
	angle_offset_2 = 30;

antenna_3_x_pos = -20;
antenna_3_y_pos = 0;
	antenna_3_enable = 1;
	angle_offset_3 = 2 * angle_offset_2;

antenna_4_x_pos = 0;
antenna_4_y_pos = 0;
	antenna_4_enable = 1;
	angle_offset_4 = 3 * angle_offset_2;

antenna_5_x_pos = 20;
antenna_5_y_pos = 0;
	antenna_5_enable = 1;
	angle_offset_5 = 4 * angle_offset_2;

antenna_6_x_pos = 40;
antenna_6_y_pos = 0;
	antenna_6_enable = 1;
	angle_offset_6 = 5 * angle_offset_2;

antenna_7_x_pos = 60;
antenna_7_y_pos = 0;
	antenna_7_enable = 1;
	angle_offset_7 = 6 * angle_offset_2;

wave_length = 40;

########################################

frequency = (2 * pi) / wave_length;
radian_offset_1 = angle_offset_1 * pi / 180;
radian_offset_2 = angle_offset_2 * pi / 180;
radian_offset_3 = angle_offset_3 * pi / 180;
radian_offset_4 = angle_offset_4 * pi / 180;
radian_offset_5 = angle_offset_5 * pi / 180;
radian_offset_6 = angle_offset_6 * pi / 180;
radian_offset_7 = angle_offset_7 * pi / 180;

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

########################################

distance_antenna_1_value = sqrt(antenna_1_x.*antenna_1_x + antenna_1_y.*antenna_1_y);
distance_antenna_2_value = sqrt(antenna_2_x.*antenna_2_x + antenna_2_y.*antenna_2_y);
distance_antenna_3_value = sqrt(antenna_3_x.*antenna_3_x + antenna_3_y.*antenna_3_y);
distance_antenna_4_value = sqrt(antenna_4_x.*antenna_4_x + antenna_4_y.*antenna_4_y);
distance_antenna_5_value = sqrt(antenna_5_x.*antenna_5_x + antenna_5_y.*antenna_5_y);
distance_antenna_6_value = sqrt(antenna_6_x.*antenna_6_x + antenna_6_y.*antenna_6_y);
distance_antenna_7_value = sqrt(antenna_7_x.*antenna_7_x + antenna_7_y.*antenna_7_y);

##################################
####### create the picture #######
##################################

number_of_step = 36;
divider = number_of_step / 2;

multi = 360 / number_of_step;

filename = ["mesh_antenna" , "-" , num2str(angle_offset_1) , "-" , num2str(angle_offset_2) , "-" , num2str(angle_offset_3) , "-" , num2str(angle_offset_4) , "-" , num2str(angle_offset_5) , "-" , num2str(angle_offset_6) , "-" , num2str(angle_offset_7) , ".gif"];

% Function and GIF file update loop
for n = 1:number_of_step

	% Generate the function and plot it
	mesh_antenna_value = zeros(number_of_points,number_of_points);

	mesh_antenna_1_value = antenna_1_enable * cos(frequency*distance_antenna_1_value + radian_offset_1 - n * pi / divider);
	mesh_antenna_2_value = antenna_2_enable * cos(frequency*distance_antenna_2_value + radian_offset_2 - n * pi / divider);
	mesh_antenna_3_value = antenna_3_enable * cos(frequency*distance_antenna_3_value + radian_offset_3 - n * pi / divider);
	mesh_antenna_4_value = antenna_4_enable * cos(frequency*distance_antenna_4_value + radian_offset_4 - n * pi / divider);
	mesh_antenna_5_value = antenna_5_enable * cos(frequency*distance_antenna_5_value + radian_offset_5 - n * pi / divider);
	mesh_antenna_6_value = antenna_6_enable * cos(frequency*distance_antenna_6_value + radian_offset_6 - n * pi / divider);
	mesh_antenna_7_value = antenna_7_enable * cos(frequency*distance_antenna_7_value + radian_offset_7 - n * pi / divider);

	mesh_antenna_value = mesh_antenna_1_value + mesh_antenna_2_value + mesh_antenna_3_value + mesh_antenna_4_value + mesh_antenna_5_value + mesh_antenna_6_value + mesh_antenna_7_value;

	mesh_antenna_value(number_of_points-matrix_size+antenna_1_y_pos,number_of_points-matrix_size+antenna_1_x_pos) = 3;
	mesh_antenna_value(number_of_points-matrix_size+antenna_2_y_pos,number_of_points-matrix_size+antenna_2_x_pos) = 3;
	mesh_antenna_value(number_of_points-matrix_size+antenna_3_y_pos,number_of_points-matrix_size+antenna_3_x_pos) = 3;
	mesh_antenna_value(number_of_points-matrix_size+antenna_4_y_pos,number_of_points-matrix_size+antenna_4_x_pos) = 3;
	mesh_antenna_value(number_of_points-matrix_size+antenna_5_y_pos,number_of_points-matrix_size+antenna_5_x_pos) = 3;
	mesh_antenna_value(number_of_points-matrix_size+antenna_6_y_pos,number_of_points-matrix_size+antenna_6_x_pos) = 3;
	mesh_antenna_value(number_of_points-matrix_size+antenna_7_y_pos,number_of_points-matrix_size+antenna_7_x_pos) = 3;

	text_title = ["angle-" , num2str(n * multi) , "-" , num2str(angle_offset_1) , "-" , num2str(angle_offset_2) , "-" , num2str(angle_offset_3) , "-" , num2str(angle_offset_4) , "-" , num2str(angle_offset_5) , "-" , num2str(angle_offset_6) , "-" , num2str(angle_offset_7) ];

	% Create empty figure and assign number
	f = figure(1);

	pause(0.3);

	mesh(space_reference_x,space_reference_y,mesh_antenna_value) ;
	set(gcf,'position',[startx,starty,width,height]);
	title(text_title);
	set(gca, "fontsize", 24);
	xlim([-matrix_size,matrix_size]);
	zlim([-10,10]);
	drawnow

	pause(0.3);

	% Image Processing
	% Assign plot to a frame
	frame = getframe(f);
	% Convert frame to RGB image (3 dimensional) 
	im = frame2im(frame);
	% Transform RGB samples to 1 dimension with a color map "cm". 
	[imind,cm] = rgb2ind(im); 
	if n == 1;
		% Create GIF file
		imwrite(imind,cm,filename,'gif','DelayTime', DelayTime , 'Compression' , 'lzw');
	else
		% Add each new plot to GIF
		imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime', DelayTime , 'Compression' , 'lzw');
	end

	pause(0.3);

	close all;
end
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

phase_step = 5;
phase_start = 0;
phase_end = 360;

########################################
####### variables for the figure #######
########################################

matrix_size = 50;
number_of_points = 2 * matrix_size + 1;

reference_x_pos = 0;
reference_y_pos = 0;

antenna_1_x_pos = -10;
antenna_1_y_pos = 0;
	antenna_1_enable = 1;
	antenna_1_enable_phase = 0;

antenna_2_x_pos = 10;
antenna_2_y_pos = 0;
	antenna_2_enable = 1;
	antenna_2_enable_phase = 1;

wave_length = 40;

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

name = [text_1 , text_2];
filename = ["antenna_" , name , ".gif"];

n = 1;

for i = angle_offset_1
	for j = angle_offset_2

		radian_offset_1 = i * pi / 180;
		radian_offset_2 = j * pi / 180;

		if (antenna_1_enable == 1)
			text_1 = [num2str(i) , "|"];
		else
			text_1 = ["-|"];
		endif

		if (antenna_2_enable == 1)
			text_2 = [num2str(j)];
		else
			text_2 = ["-"];
		endif

		text_title = [text_1 , text_2];

		##################################
		####### create the picture #######
		##################################

		% Generate the function and plot it
		mesh_antenna_value = zeros(number_of_points,number_of_points);

		mesh_antenna_1_value = antenna_1_enable * cos(frequency*distance_antenna_1_value + radian_offset_1);
		mesh_antenna_2_value = antenna_2_enable * cos(frequency*distance_antenna_2_value + radian_offset_2);

		mesh_antenna_value = mesh_antenna_1_value + mesh_antenna_2_value;

		[max_matrix_value_y , max_matrix_pos_y] = max(mesh_antenna_value);
		[max_matrix_value , max_matrix_pos_x] = max(max_matrix_value_y);

		radius = round(sqrt(((hypothetical_antenna_y_pos + matrix_size + 1) - max_matrix_pos_y(max_matrix_pos_x)) ^ 2 + ((hypothetical_antenna_x_pos + matrix_size + 1) - max_matrix_pos_x) ^ 2));


		for k=1:2*radius+1
			for l=1:2
				if(l==1)
					x_pos = radius + 1 - k;
					y_pos = floor(sqrt(radius * radius - x_pos * x_pos));
					angle_xy(k+2*radius+1) = atan2(y_pos , x_pos);
					value(k+2*radius+1) = abs(mesh_antenna_value(matrix_size + 1 + hypothetical_antenna_y_pos + y_pos,matrix_size + 1 + hypothetical_antenna_x_pos + x_pos)) / max_matrix_value;
				else
					x_pos = k - radius - 1;
					y_pos = -floor(sqrt(radius * radius - x_pos * x_pos));
					angle_xy(k) = atan2(y_pos , x_pos);
					value(k) = abs(mesh_antenna_value(matrix_size + 1 + hypothetical_antenna_y_pos + y_pos,matrix_size + 1 + hypothetical_antenna_x_pos + x_pos)) / max_matrix_value;
				endif
			endfor
		endfor


		% Create empty figure and assign number
		f = figure(1);

		pause(0.3);

		polar(angle_xy,value);
		set(gcf,'position',[startx,starty,width,height]);
		title(text_title);
		set(gca, "fontsize", 24);
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
		endif

		#pause(0.5);

		close all;
		clear('value');
		clear('angle_xy');

		% Function and GIF file update loop
		n = n + 1;

	endfor
endfor

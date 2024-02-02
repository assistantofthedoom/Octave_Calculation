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

radius_size = 100;
angle_step = 720;

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

remove_value_radius = 20;

########################################

frequency = (2 * pi) / wave_length;

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

for i=space_reference_t
	for j=space_reference_r
		distance_antenna_1(j,i) = sqrt(antenna_1_x(j,i) * antenna_1_x(j,i) + antenna_1_y(j,i) * antenna_1_y(j,i));
		distance_antenna_2(j,i) = sqrt(antenna_2_x(j,i) * antenna_2_x(j,i) + antenna_2_y(j,i) * antenna_2_y(j,i));
	endfor
endfor

space_reference_t_degre = space_reference_t * convert_to_degre;
space_reference_t_radian = space_reference_t * convert_to_radian;

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

		mesh_antenna_1_value = cos(frequency*distance_antenna_1 - radian_offset_1);
		mesh_antenna_2_value = cos(frequency*distance_antenna_2 - radian_offset_2);

		mesh_antenna_value = mesh_antenna_1_value + mesh_antenna_2_value;

		for j=1:remove_value_radius
			mesh_antenna_value(j,:) = 0;
		endfor

		maximum_value_space = max(mesh_antenna_value);

		maximum_value_normalized = maximum_value_space / 2;

		% Create empty figure and assign number
		f = figure(1);

		pause(0.3);

		polar(space_reference_t_radian,maximum_value_normalized);
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

		% Function and GIF file update loop
		n = n + 1;

	endfor
endfor

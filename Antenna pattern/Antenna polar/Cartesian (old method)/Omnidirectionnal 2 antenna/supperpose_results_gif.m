############################################
# name of the groups and of the connexions #
############################################

close all;
clear all;

% Time in seconds for each plot in the GIF
DelayTime = 0.1; 

startx = 150;
starty = 150;
width = 1062;
height = 980;

base_name_1 = char([ "antenna_" ]);

antenna_1_signal_moving = 0;
antenna_2_signal_moving = 1;

signal_angle_start = 0;
signal_angle_stop = 355;
signal_angle_step = 5;

extension = char([ '.csv' ]);

#####################
# name of the angle #
#####################

number_signal_angle = (signal_angle_stop - signal_angle_start) / signal_angle_step + 1;

string_length = 8;

signal_angle_name = char(zeros(number_signal_angle,string_length));

if(antenna_1_signal_moving == 0 && antenna_2_signal_moving == 1)
	base_name_2 = char([ "fixed|moving" ]);

	for k=1:number_signal_angle
		temp = [num2str(signal_angle_start),"|",num2str(signal_angle_start + (k-1) * signal_angle_step),"      "];
		for l=1:string_length
			signal_angle_name(k,l) = char(temp(1,l));
		endfor
	endfor
endif

if(antenna_1_signal_moving == 1 && antenna_2_signal_moving == 0)
	base_name_2 = char([ "moving|fixed" ]);

	for k=1:number_signal_angle
		temp = [num2str(signal_angle_start + (k-1) * signal_angle_step),"|",num2str(signal_angle_start),"      "];
		for l=1:string_length
			signal_angle_name(k,l) = char(temp(1,l));
		endfor
	endfor
endif

#####################
# prepare filenames #
#####################

number_characters_directory = columns(base_name_1) + columns(base_name_2);

number_characters_filename = columns(base_name_1) + columns(base_name_2) + columns(signal_angle_name) + 5 ;

temp_1 = char([base_name_1,base_name_2,"             "]);
for n=1:number_characters_directory
	directory_name(1,n) = temp_1(1,n);
endfor

for j=1:number_signal_angle
	temp_2 = char([base_name_1,base_name_2,"_",strtrim(signal_angle_name(j,:)),extension,"             "]);
	for k=1:number_characters_filename
		file_names(j,k) = temp_2(1,k);
	endfor
endfor

################################
# import csv data as variables #
################################

cd (strtrim(directory_name(1,:)));

for j=1:number_signal_angle
	eval(['CSV_' , num2str(j) , ' = csvread(strtrim(file_names(j,:)));']);
endfor

cd ..;

############################
# plot as polar to compare #
############################

filename = [ base_name_1 , base_name_2 , ".gif"];

for i=1:number_signal_angle
	text_title = strtrim(signal_angle_name(i,:));
	f = figure(1);

	polar(eval(['CSV_' , num2str(i) , '(:,1)']) , eval([ 'CSV_' , num2str(i) , '(:,2)']));

	pause(0.5);

	set(gcf,'position',[startx,starty,width,height]);

	pause(0.5);
	RTicks = [ 0 : 0.5 : 1 ];
	set(gca, 'rtick', RTicks );
	title(text_title);
	set(gca, "fontsize", 24);

	pause(0.5);

	% Image Processing
	% Assign plot to a frame
	frame = getframe(f);
	% Convert frame to RGB image (3 dimensional) 
	im = frame2im(frame);
	% Transform RGB samples to 1 dimension with a color map "cm". 
	[imind,cm] = rgb2ind(im); 
	if (i == 1)
		% Create GIF file
		imwrite(imind,cm,filename,'gif','DelayTime', DelayTime , 'Compression' , 'lzw');
	else
		% Add each new plot to GIF
		imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime', DelayTime , 'Compression' , 'lzw');
	endif

	#pause(0.5);

	close all;

endfor

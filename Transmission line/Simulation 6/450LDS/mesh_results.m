############################################
# name of the groups and of the connexions #
############################################

close all;
clear all;

base_name = [ 'CSV_arranged' ];

connexion_names = [ 'S11' ;
 'S12' ;
 'S21' ;
 'S22' ];

extension = [ '.csv' ];

########################
# variables of numbers #
########################

fixed_frequency = (3.5-2.5) / 0.0125;

number_of_csv = 30;

number_of_connexion_names = rows(connexion_names);

#####################
# prepare filenames #
#####################

for i=1:number_of_csv
    for j=1:number_of_connexion_names
        file_names((i-1)*number_of_connexion_names+j,:) = [ base_name , '_' , sprintf("%02d",i) , '_' , connexion_names(j,:) , extension ];
    endfor
endfor

################################
# import csv data as variables #
################################

for i=1:number_of_csv
    for j=1:number_of_connexion_names
        eval(['CSV_' , num2str(i) , '_' , connexion_names(j,:) , ' = csvread(strtrim(file_names((i-1)*number_of_connexion_names+j,:)));']);
    endfor
endfor

frequency = csvread("CSV_frequency.csv");

length_of_trace = csvread("CSV_length_of_trace.csv");

number_of_frequency = rows(frequency);

number_of_length_of_trace = rows(length_of_trace);

number_of_step = columns(CSV_1_S11);

#######################################
# get the width of the trace from csv #
#######################################

for i=1:number_of_step
    width_of_trace(i,:) = CSV_1_S11(1,i);
endfor

##########################################
# remove the first line of the variables #
##########################################

for i=1:number_of_csv
    for j=1:number_of_connexion_names
        eval(['CSV_' , num2str(i) , '_' , connexion_names(j,:) , ' = CSV_' , num2str(i) , '_' , connexion_names(j,:) , '(2:end,:);']);
    endfor
endfor

###############################################################
# find the max of all separate csv data at variable frequency #
###############################################################

for i=1:number_of_connexion_names
    eval(['max_value_' , connexion_names(i,:) ,' = zeros(number_of_csv,number_of_step);' ]);
    eval(['max_pos_' , connexion_names(i,:) ,' = zeros(number_of_csv,number_of_step);' ]);
    eval(['min_value_' , connexion_names(i,:) ,' = zeros(number_of_csv,number_of_step);' ]);
    eval(['min_pos_' , connexion_names(i,:) ,' = zeros(number_of_csv,number_of_step);' ]);
endfor

for i=1:number_of_csv
    for j=1:number_of_connexion_names
        [temp_value , temp_pos] = max(eval(['CSV_' , num2str(i) , '_' , connexion_names(j,:) , ';']));
        eval([ 'max_value_' , connexion_names(j,:) , '(i,:)  = temp_value;' ]);
        eval([ 'max_pos_' , connexion_names(j,:) , '(i,:) = temp_pos * 0.0125 + 2.4875;' ]);
    endfor
endfor

for i=1:number_of_csv
    for j=1:number_of_connexion_names
        [temp_value , temp_pos] = min(eval(['CSV_' , num2str(i) , '_' , connexion_names(j,:) , ';']));
        eval([ 'min_value_' , connexion_names(j,:) , '(i,:)  = temp_value;' ]);
        eval([ 'min_pos_' , connexion_names(j,:) , '(i,:) = temp_pos * 0.0125 + 2.4875;' ]);
    endfor
endfor

############################################################
# find the max of all separate csv data at fixed frequency #
############################################################

for i=1:number_of_csv
    for j=1:number_of_connexion_names
        eval(['value_fixed_frequency_' , connexion_names(j,:) , '(i,:) = CSV_' , num2str(i) , '_' , connexion_names(j,:) , '(fixed_frequency,:);']);
    endfor
endfor

############################
# prepare titles of meshes #
############################

for i=1:number_of_connexion_names
	title_of_meshes_max_value(i,:) = [ connexion_names(i,:) , ' 450LDS - maximum related to length' ];
	title_of_meshes_max_pos(i,:) = [ connexion_names(i,:) , ' 450LDS - frequency related to length' ];
	title_of_meshes_min_value(i,:) = [ connexion_names(i,:) , ' 450LDS - minimum related to length' ];
	title_of_meshes_min_pos(i,:) = [ connexion_names(i,:) , ' 450LDS - frequency related to length' ];
	title_of_meshes_fixed(i,:) = [ connexion_names(i,:) , ' 450LDS - 3,5 GHz value related to length' ];
endfor

#####################
# meshes the values #
#####################

for i=1:number_of_connexion_names
	eval(['F_' , num2str(i) , ' = figure(i);']);
	eval(['mesh(width_of_trace,length_of_trace,max_value_' , connexion_names(i,:) , ');']);
	xlabel('width of trace');
	ylabel('length of trace');
	set(gca, "fontsize", 18, "linewidth", 3);
	grid on;
	eval(['F_' , num2str(i) , ' = axes("visible", "off", "title", "' , title_of_meshes_max_value(i,:) , '");']);
	set(gca, "fontsize", 24);
endfor

for i=1:number_of_connexion_names
	eval(['F_' , num2str(i+number_of_connexion_names) , ' = figure(i+number_of_connexion_names);']);
	eval(['mesh(width_of_trace,length_of_trace,max_pos_' , connexion_names(i,:) , ');']);
	xlabel('width of trace');
	ylabel('length of trace');
	set(gca, "fontsize", 18, "linewidth", 3);
	grid on;
	eval(['F_' , num2str(i) , ' = axes("visible", "off", "title", "' , title_of_meshes_max_pos(i,:) , '");']);
	set(gca, "fontsize", 24);
endfor

for i=1:number_of_connexion_names
	eval(['F_' , num2str(i+(2*number_of_connexion_names)) , ' = figure(i+(2*number_of_connexion_names));']);
	eval(['mesh(width_of_trace,length_of_trace,min_value_' , connexion_names(i,:) , ');']);
	xlabel('width of trace');
	ylabel('length of trace');
	set(gca, "fontsize", 18, "linewidth", 3);
	grid on;
	eval(['F_' , num2str(i) , ' = axes("visible", "off", "title", "' , title_of_meshes_min_value(i,:) , '");']);
	set(gca, "fontsize", 24);
endfor

for i=1:number_of_connexion_names
	eval(['F_' , num2str(i+(3*number_of_connexion_names)) , ' = figure(i+(3*number_of_connexion_names));']);
	eval(['mesh(width_of_trace,length_of_trace,min_pos_' , connexion_names(i,:) , ');']);
	xlabel('width of trace');
	ylabel('length of trace');
	set(gca, "fontsize", 18, "linewidth", 3);
	grid on;
	eval(['F_' , num2str(i) , ' = axes("visible", "off", "title", "' , title_of_meshes_min_pos(i,:) , '");']);
	set(gca, "fontsize", 24);
endfor

for i=1:number_of_connexion_names
	eval(['F_' , num2str(i+(4*number_of_connexion_names)) , ' = figure(i+(4*number_of_connexion_names));']);
	eval(['mesh(width_of_trace,length_of_trace,value_fixed_frequency_' , connexion_names(i,:) , ');']);
	xlabel('width of trace');
	ylabel('length of trace');
	set(gca, "fontsize", 18, "linewidth", 3);
	grid on;
	eval(['F_' , num2str(i) , ' = axes("visible", "off", "title", "' , title_of_meshes_fixed(i,:) , '");']);
	set(gca, "fontsize", 24);
endfor

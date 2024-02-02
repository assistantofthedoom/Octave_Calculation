#####################
# list of the files #
#####################

close all;
clear all;

file_names = [ 'S_Parameter_Plot_01_-_01.csv' ;
 'S_Parameter_Plot_01_-_02.csv' ;
 'S_Parameter_Plot_01_-_03.csv' ;
 'S_Parameter_Plot_01_-_04.csv' ;
 'S_Parameter_Plot_01_-_05.csv' ;
 'S_Parameter_Plot_01_-_06.csv' ;
 'S_Parameter_Plot_01_-_07.csv' ;
 'S_Parameter_Plot_01_-_08.csv' ;
 'S_Parameter_Plot_01_-_09.csv' ;
 'S_Parameter_Plot_01_-_10.csv' ;
 'S_Parameter_Plot_01_-_11.csv' ;
 'S_Parameter_Plot_01_-_12.csv' ;
 'S_Parameter_Plot_01_-_13.csv' ;
 'S_Parameter_Plot_01_-_14.csv' ;
 'S_Parameter_Plot_01_-_15.csv' ;
 'S_Parameter_Plot_01_-_16.csv' ;
 'S_Parameter_Plot_01_-_17.csv' ;
 'S_Parameter_Plot_01_-_18.csv' ;
 'S_Parameter_Plot_01_-_19.csv' ;
 'S_Parameter_Plot_01_-_20.csv' ;
 'S_Parameter_Plot_01_-_21.csv' ;
 'S_Parameter_Plot_01_-_22.csv' ;
 'S_Parameter_Plot_01_-_23.csv' ;
 'S_Parameter_Plot_01_-_24.csv' ;
 'S_Parameter_Plot_01_-_25.csv' ;
 'S_Parameter_Plot_01_-_26.csv' ;
 'S_Parameter_Plot_01_-_27.csv' ;
 'S_Parameter_Plot_01_-_28.csv' ;
 'S_Parameter_Plot_01_-_29.csv' ;
 'S_Parameter_Plot_01_-_30.csv' ];

connexion_names = [ 'S11' ;
 'S21' ;
 'S12' ;
 'S22' ];

########################
# variables of numbers #
########################

number_of_csv = rows(file_names);

number_of_connexion_names = rows(connexion_names);

################################
# import csv data as variables #
################################

for i=1:number_of_csv
    eval(['CSV_' , num2str(i) , ' = csvread(strtrim(file_names(i,:)));']);
endfor

##########################################
# remove the first line of the variables #
##########################################

for i=1:number_of_csv
    eval(['CSV_' , num2str(i) , ' = CSV_' , num2str(i) , '(2:end,:);']);
endfor

########################################################
# need for number of step to separate correcly dataset #
########################################################

number_of_lines = (7.5 - 2.5) / 0.0125 + 1;

number_of_step = zeros(number_of_csv,1);

for i=1:number_of_csv
    eval(['number_of_lines_of_CSV_file = rows(CSV_' , num2str(i) , ');']);
    number_of_step(i,:) = number_of_lines_of_CSV_file / number_of_lines;
endfor

for i=1:number_of_csv
    for j=1:number_of_step(i,:)
        eval(['width_of_trace_' , num2str(i) , '(j,:) = CSV_' , num2str(i) , '((j-1)*number_of_lines + 1,2);']);
    endfor
endfor

#######################
# get length of trace #
#######################

for i=1:number_of_csv
        eval(['length_of_trace(i,:) = CSV_' , num2str(i) , '(1,1);']);
endfor

###################
# arrange dataset #
###################

frequency = zeros(number_of_lines,1);

for j=1:number_of_lines
	frequency(j,1) = CSV_1(j,3);
endfor

for i=1:number_of_csv
    for j=1:number_of_connexion_names
        for k=1:number_of_step(i,:)
            eval(['CSV_arranged_' , num2str(i) , '_' , connexion_names(j,:) , '(1,k) = width_of_trace_' , num2str(i) , '(k,:);']);
            for l=1:number_of_lines
                eval(['CSV_arranged_' , num2str(i) , '_' , connexion_names(j,:) , '(l+1,k) = CSV_' , num2str(i) , '((k-1)*number_of_lines+l,3+j);']);
            endfor
        endfor
    endfor
endfor

#####################
# prepare filenames #
#####################

for i=1:number_of_csv
    for j=1:number_of_connexion_names
        filename_of_csv((i-1)*number_of_connexion_names+j,:) = ['CSV_arranged_' , sprintf("%02d",i) , '_' , connexion_names(j,:) , '.csv'] ;
    endfor
endfor

#######################
# save dataset as csv #
#######################

if (exist("Arranged","dir") == 7)
    cd Arranged ;
else
    mkdir Arranged;
    cd Arranged ;
endif

for i=1:number_of_csv
    for j=1:number_of_connexion_names
        csvwrite(strtrim(filename_of_csv((i-1)*number_of_connexion_names+j,:)),eval(['CSV_arranged_' , num2str(i) , '_' , connexion_names(j,:) , ';']));
    endfor
endfor

csvwrite("CSV_frequency.csv",frequency);

csvwrite("CSV_length_of_trace.csv",length_of_trace);


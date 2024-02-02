#####################
# list of the files #
#####################

close all;
clear all;

file_names = [ 'Coplanarline_450LDS.csv' ;
 'Coplanarline_8MF44VG.csv' ;
 'Coplanarline_E840i.csv' ;
 'Coplanarline_LKX1767LDS.csv' ;
 'Coplanarline_inv_450LDS.csv' ;
 'Coplanarline_inv_8MF44VG.csv' ;
 'Coplanarline_inv_E840i.csv' ;
 'Coplanarline_inv_LKX1767LDS.csv' ;
 'Microstrip_450LDS.csv' ;
 'Microstrip_8MF44VG.csv' ;
 'Microstrip_E840i.csv' ;
 'Microstrip_LKX1767LDS.csv' ;
 'Microstrip_inv_450LDS.csv' ;
 'Microstrip_inv_8MF44VG.csv' ;
 'Microstrip_inv_E840i.csv' ;
 'Microstrip_inv_LKX1767LDS.csv' ];

############################################
# name of the groups and of the connexions #
############################################

group_names = [ 'Coplanarline' ;
 'Coplanarline_inv' ;
 'Microstrip' ;
 'Microstrip_inv' ];

connexion_names = [ 'S11' ;
 'S21' ;
 'S12' ;
 'S22' ];

material_names = [ '450LDS' ;
 '8MF44VG' ;
 'E840i' ;
 'LKX1767LDS' ];

########################
# variables of numbers #
########################

number_of_csv = rows(file_names);

number_of_group_names = rows(group_names);

number_of_connexion_names = rows(connexion_names);

number_of_material_names = rows(material_names);

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
        eval(['width_of_trace_' , num2str(i) , '(j,:) = CSV_' , num2str(i) , '((j-1)*number_of_lines + 1,1);']);
    endfor
endfor

for i=1:number_of_csv
    eval(['text_width_of_trace_' , num2str(i) ' = "";']);
    temp = strcat( '"' , num2str(eval(['width_of_trace_' , num2str(i) , '(1,:);']) ),'"' );
    eval(['text_width_of_trace_' , num2str(i) ' = temp;']);
    for j=2:number_of_step(i,:)
        temp = [ eval(['text_width_of_trace_' , num2str(i) , ';']) , ', "' , num2str(eval(['width_of_trace_' , num2str(i) , '(j,:);']),2) , '"' ];
        eval(['text_width_of_trace_' , num2str(i) ' = temp;']);
    endfor
endfor

###################
# arrange dataset #
###################

frequency = zeros(number_of_lines,1);

for j=1:number_of_lines
	frequency(j,1) = CSV_1(j,2);
endfor

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:number_of_connexion_names
            for l=1:number_of_step((i-1)*number_of_material_names + j,:)
                eval(['CSV_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(k,:) , '(1,l) = width_of_trace_' , num2str((i-1)*number_of_material_names+j) , '(l,:);']);
                for m=1:number_of_lines
                    eval(['CSV_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(k,:) , '(m+1,l) = CSV_' , num2str((i-1)*number_of_material_names+j) , '((l-1)*number_of_lines+m,k+2);']);
                endfor
            endfor
        endfor
    endfor
endfor

#####################
# prepare filenames #
#####################

for i=1:number_of_group_names
    numbers_of_letters_of_group_names(i,:) = length(strtrim(group_names(i,:)));
endfor

max_numbers_of_letters_of_group_names = max(numbers_of_letters_of_group_names);

for i=1:number_of_material_names
    numbers_of_letters_of_material_names(i,:) = length(strtrim(material_names(i,:)));
endfor

max_numbers_of_letters_of_material_names = max(numbers_of_letters_of_material_names);

for i=1:number_of_connexion_names
    numbers_of_letters_of_connexion_names(i,:) = length(strtrim(connexion_names(i,:)));
endfor

max_numbers_of_letters_of_connexion_names = max(numbers_of_letters_of_connexion_names);

max_numbers_of_letters = max_numbers_of_letters_of_group_names + max_numbers_of_letters_of_material_names + max_numbers_of_letters_of_connexion_names;

for i=1:number_of_connexion_names
    for j=1:number_of_material_names
        for k=1:number_of_connexion_names
            blank_to_add((i-1)*number_of_material_names*number_of_connexion_names+(j-1)*number_of_connexion_names+k,:) = max_numbers_of_letters - (numbers_of_letters_of_group_names(i,:) + numbers_of_letters_of_material_names(j,:) + numbers_of_letters_of_connexion_names(k,:));
        endfor
    endfor
endfor

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:number_of_connexion_names
            filename_of_csv((i-1)*number_of_material_names*number_of_connexion_names+(j-1)*number_of_connexion_names+k,:) = ['CSV_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(k,:) , '.csv' , blanks(blank_to_add((i-1)*number_of_material_names*number_of_connexion_names+(j-1)*number_of_connexion_names+k,:))];
        endfor
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

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:number_of_connexion_names
            csvwrite(strtrim(filename_of_csv((i-1)*number_of_material_names*number_of_connexion_names+(j-1)*number_of_connexion_names+k,:)),eval(['CSV_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(k,:) , ';']));
        endfor
    endfor
endfor

csvwrite("CSV_frequency.csv",frequency);


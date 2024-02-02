#####################
# list of the files #
#####################

close all;
clear all;

file_names = [ 'Coplanar_450LDS.csv' ;
 'Coplanar_8MF44VG.csv' ;
 'Coplanar_E840i.csv' ;
 'Coplanar_LKX1767LDS.csv' ];

############################################
# name of the groups and of the connexions #
############################################

group_names = [ 'Coplanar' ];

connexion_names = [ 'S11' ;
 'S21' ;
 'S12' ;
 'S22' ];

material_names = [ '450LDS' ;
 '8MF44VG' ;
 'E840i' ;
 'LKX1767LDS' ];

########################################################
# need for number of step to separate correcly dataset #
########################################################

frequency_step = (7.5 - 2.5) / 0.0125 + 1 ;

ordering_1_step = 3;
name_of_ordering_1 = [ 'width_of_space' ] ;

ordering_2_step = 5;
name_of_ordering_2 = [ 'space_of_trace' ] ;

########################
# variables of numbers #
########################

number_of_group_names = rows(group_names);

number_of_connexion_names = rows(connexion_names);

number_of_material_names = rows(material_names);

################################
# import csv data as variables #
################################

for i=1:number_of_group_names
    for j=1:number_of_material_names
        eval(['CSV_' , num2str((i-1)*number_of_material_names+j) , ' = csvread(strtrim(file_names((i-1)*number_of_material_names+j,:)));']);
    endfor
endfor

##########################################
# remove the first line of the variables #
##########################################

for i=1:number_of_group_names
    for j=1:number_of_material_names
        eval(['CSV_' , num2str((i-1)*number_of_material_names+j) , ' = CSV_' , num2str((i-1)*number_of_material_names+j) , '(2:end,:);']);
    endfor
endfor

#########################################
# get the correct variables for the set #
#########################################

for i=1:frequency_step
    frequency(i,:) = eval(['CSV_' , num2str(1) , '(i,3);']);
endfor

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:ordering_1_step
            ordering_1((i-1)*number_of_material_names*ordering_1_step+(j-1)*ordering_1_step+k,:) = eval(['CSV_' , num2str((i-1)*number_of_material_names+j) , '(k*frequency_step*ordering_2_step,2);']);
        endfor
    endfor
endfor

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:ordering_2_step
            ordering_2((i-1)*number_of_material_names*ordering_2_step+(j-1)*ordering_2_step+k,:) = eval(['CSV_' , num2str((i-1)*number_of_material_names+j) , '(k*frequency_step,1);']);
        endfor
    endfor
endfor

###################
# arrange dataset #
###################

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:number_of_connexion_names
            for l=1:ordering_2_step
                for m=1:ordering_1_step
                    for n=1:frequency_step
                        eval(['CSV_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(k,:) , '_' , num2str(m) , '(n,l) = CSV_' , num2str((i-1)*number_of_material_names+j) , '((m-1)*ordering_2_step*frequency_step+(l-1)*frequency_step+n,k+3);']);
                    endfor
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

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:number_of_connexion_names
            blank_to_add((i-1)*number_of_material_names*number_of_connexion_names+(j-1)*number_of_connexion_names+k,:) = max_numbers_of_letters - (numbers_of_letters_of_group_names(i,:) + numbers_of_letters_of_material_names(j,:) + numbers_of_letters_of_connexion_names(k,:));
        endfor
    endfor
endfor

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:number_of_connexion_names
            for l=1:ordering_1_step
                filename_of_csv((i-1)*number_of_material_names*number_of_connexion_names*ordering_1_step+(j-1)*number_of_connexion_names*ordering_1_step+(k-1)*ordering_1_step+l,:) = ['CSV_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(k,:) , '_' , num2str(l) , '.csv' , blanks(blank_to_add((i-1)*number_of_material_names*number_of_connexion_names+(j-1)*number_of_connexion_names+k,:))];
            endfor
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
            for l=1:ordering_1_step
                csvwrite(strtrim(filename_of_csv((i-1)*number_of_material_names*number_of_connexion_names*ordering_1_step+(j-1)*number_of_connexion_names*ordering_1_step+(k-1)*ordering_1_step+l,:)),eval(['CSV_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(k,:) , '_' , num2str(l) , ';']));
            endfor
        endfor
    endfor
endfor

csvwrite("CSV_frequency.csv",frequency);

name_of_ordering_1 = [name_of_ordering_1 , '.csv']
csvwrite(name_of_ordering_1,ordering_1);

name_of_ordering_2 = [name_of_ordering_2 , '.csv']
csvwrite(name_of_ordering_2,ordering_2);

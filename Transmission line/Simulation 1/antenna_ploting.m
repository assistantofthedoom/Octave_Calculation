#####################
# list of the files #
#####################

close all;
clear all;

file_names = [ 'Coplanarline - 450LDS - S Parameter.csv' ;
 'Coplanarline - 8MF44VG - S Parameter.csv' ;
 'Coplanarline - E840i - S Parameter.csv' ;
 'Coplanarline - LKX1767LDS - S Parameter.csv' ;
 'Coplanarline_inv - 450LDS - S Parameter.csv' ;
 'Coplanarline_inv - 8MF44VG - S Parameter.csv' ;
 'Coplanarline_inv - E840i - S Parameter.csv' ;
 'Coplanarline_inv - LKX1767LDS - S Parameter.csv' ;
 'Microstrip - 450LDS - S Parameter.csv' ;
 'Microstrip - 8MF44VG - S Parameter.csv' ;
 'Microstrip - E840i - S Parameter.csv' ;
 'Microstrip - LKX1767LDS - S Parameter.csv' ;
 'Microstrip_inv - 450LDS - S Parameter.csv' ;
 'Microstrip_inv - 8MF44VG - S Parameter.csv' ;
 'Microstrip_inv - E840i - S Parameter.csv' ;
 'Microstrip_inv - LKX1767LDS - S Parameter.csv' ];

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

number_of_material_names = rows(material_names);

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

# "Freq [GHz]","dB(S(1,1)) []","dB(S(2,1)) []","dB(S(1,2)) []","dB(S(2,2)) []"

####################################
# set x as the frequency reference #
####################################

number_of_lines = rows(CSV_1);

x = zeros(number_of_lines,1);

for j=1:number_of_lines
	x(j,1) = CSV_1(j,1);
endfor

##############################
# regroup into group to plot #
##############################

for i=1:number_of_group_names
    for j=1:number_of_connexion_names
        eval(['CSV_', strtrim(group_names(i,:)) , '_' , connexion_names(j,:) , ' = zeros(number_of_lines,number_of_material_names);']);
    endfor
endfor


for i=1:number_of_group_names
    for j=1:number_of_connexion_names
        for k=1:number_of_material_names
            eval(['CSV_', strtrim(group_names(i,:)) , '_' , connexion_names(j,:) , '(:,k) = CSV_', num2str((i-1)*number_of_group_names+k) , '(:,j+1);']);
        endfor
    endfor
endfor

#################################################
# prepare some string for ease of use into loop #
#################################################

group_names_formated = strrep(group_names , "_" , " ");

material_legend = [ material_names(1,:) ];

for i=2:number_of_material_names
    material_legend = [ material_legend ; material_names(i,:) ] ;
endfor

####################################
# search min and max for the lines #
####################################

max_matrix = zeros(number_of_connexion_names*number_of_group_names,1);
min_matrix = zeros(number_of_connexion_names*number_of_group_names,1);

for i=1:number_of_connexion_names
    for j=1:number_of_group_names
        eval(["max_matrix((i-1)*number_of_group_names+j,:) = max(max(CSV_", strtrim(group_names(j,:)) , "_" , connexion_names(i,:) , "));"]);
        eval(["min_matrix((i-1)*number_of_group_names+j,:) = min(min(CSV_", strtrim(group_names(j,:)) , "_" , connexion_names(i,:) , "));"]);
    endfor
endfor

################################
# loop for to plot the results #
################################

for i=1:number_of_connexion_names
    eval(['figure_' , connexion_names(i,:) , ' = figure(i);']);
    for j=1:number_of_group_names
        eval(['S_' , num2str(i) , num2str(j) , '= subplot(ceil(number_of_connexion_names/ceil(sqrt(number_of_connexion_names))),ceil(sqrt(number_of_connexion_names)),j);']);
        eval(['plot(x,CSV_' , strtrim(group_names(j,:)) , '_' , connexion_names(i,:) , ');']);
        line ([3.5 3.5], [min_matrix((i-1)*number_of_group_names+j,:) max_matrix((i-1)*number_of_group_names+j,:)] , "linestyle", "-.", "color", "k");
        line ([3.4 3.4], [min_matrix((i-1)*number_of_group_names+j,:) max_matrix((i-1)*number_of_group_names+j,:)] , "linestyle", ":", "color", "k");
        line ([3.6 3.6], [min_matrix((i-1)*number_of_group_names+j,:) max_matrix((i-1)*number_of_group_names+j,:)] , "linestyle", ":", "color", "k");
        grid on;
        eval(['title( "' , strtrim(group_names_formated(j,:)) , '" )']);
        eval(['xlabel( "Freq \[GHz\]" )']);
        eval(['ylabel( "| Reflexion | \[dB\]" )']);
        eval(['L_' , num2str(i) , num2str(j) , ' = legend((material_legend) , "location" , "south" , "orientation" , "horizontal");']);
        eval(['set( L_' , num2str(i) , num2str(j) ,  ' , "fontsize" , 14);']);
        set(gca, "fontsize", 18, "linewidth", 2);
    endfor
    eval(['S_' , num2str(i) , " = axes( 'visible', 'off', 'title', '" , connexion_names(i,:) , "');"]);
    set(gca, "fontsize", 24);
endfor

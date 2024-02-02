############################################
# name of the groups and of the connexions #
############################################

close all;
clear all;

group_names = [ 'Coplanar_short' ;
 'Microstrip_short' ];

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

number_of_group_names = rows(group_names);

number_of_material_names = rows(material_names);

number_of_connexion_names = rows(connexion_names);


##########################
# generate the csv names #
##########################

for i=1:number_of_group_names
    numbers_of_letters_of_group_names(i,:) = length(strtrim(group_names(i,:)));
endfor

max_numbers_of_letters_of_group_names = max(numbers_of_letters_of_group_names);

for i=1:number_of_connexion_names
    numbers_of_letters_of_connexion_names(i,:) = length(strtrim(connexion_names(i,:)));
endfor

max_numbers_of_letters_of_connexion_names = max(numbers_of_letters_of_connexion_names);

for i=1:number_of_material_names
    numbers_of_letters_of_material_names(i,:) = length(strtrim(material_names(i,:)));
endfor

max_numbers_of_letters_of_material_names = max(numbers_of_letters_of_material_names);

max_numbers_of_letters = max_numbers_of_letters_of_group_names + max_numbers_of_letters_of_connexion_names + max_numbers_of_letters_of_material_names;

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:number_of_connexion_names
            temp = (i-1)*number_of_material_names*number_of_connexion_names+(j-1)*number_of_connexion_names+k;
            blank_to_add(temp,:) = max_numbers_of_letters - (numbers_of_letters_of_group_names(i,:) + numbers_of_letters_of_material_names(j,:) + numbers_of_letters_of_connexion_names(k,:));
        endfor
    endfor
endfor

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:number_of_connexion_names
            temp = (i-1)*number_of_material_names*number_of_connexion_names+(j-1)*number_of_connexion_names+k;
            filename_of_csv(temp,:) = ['CSV_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(k,:) , '.csv' , blanks(blank_to_add((i-1)*number_of_material_names*number_of_connexion_names+(j-1)*number_of_connexion_names+k,:))];
        endfor
    endfor
endfor

################################
# import csv data as variables #
################################

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:number_of_connexion_names
            eval(['CSV_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(k,:) , ' = csvread(strtrim(filename_of_csv((i-1)*number_of_material_names*number_of_connexion_names+(j-1)*number_of_connexion_names+k,:)));']);
        endfor
    endfor
endfor

frequency = csvread("CSV_frequency.csv");

#######################################
# get the width of the trace from csv #
#######################################

for i=1:number_of_group_names
    for j=1:number_of_material_names
        eval(['width_of_trace_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , ' = CSV_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(1,:) , '(1,:);']);
    endfor
endfor

##########################################
# remove the first line of the variables #
##########################################

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:number_of_connexion_names
            eval(['CSV_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(k,:) , ' = CSV_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(k,:) , '(2:end,:);']);
        endfor
    endfor
endfor

#########################################
# find the max of all separate csv data #
#########################################

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:number_of_connexion_names
            [max_value((i-1)*number_of_material_names*number_of_connexion_names+(j-1)*number_of_connexion_names+k,:) , max_pos((i-1)*number_of_material_names*number_of_connexion_names+(j-1)*number_of_connexion_names+k,:)] = max(max(eval(['CSV_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(k,:) , ';'])));
        endfor
    endfor
endfor

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:number_of_connexion_names
            [min_value((i-1)*number_of_material_names*number_of_connexion_names+(j-1)*number_of_connexion_names+k,:) , min_pos((i-1)*number_of_material_names*number_of_connexion_names+(j-1)*number_of_connexion_names+k,:)] = min(min(eval(['CSV_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(k,:) , ';'])));
        endfor
    endfor
endfor

#################################################
# prepare some string for ease of use into loop #
#################################################

group_names_formated = strrep(group_names , "_" , " ");

for i=1:number_of_group_names
    for j=1:number_of_material_names
        number_of_step((i-1)*number_of_material_names+j,:) = eval(['columns(width_of_trace_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) ');']);
    endfor
endfor

for i=1:number_of_group_names
    for j=1:number_of_material_names
        eval(['text_width_of_trace_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) ' = "";']);
        temp = num2str(eval(['width_of_trace_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '(:,1);']));
        eval(['text_width_of_trace_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) ' = temp;']);
        for k=2:number_of_step((i-1)*number_of_material_names+j,:)
            temp = [ eval(['text_width_of_trace_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , ';']) ; num2str(eval(['width_of_trace_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '(:,k);']),2) ];
            eval(['text_width_of_trace_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) ' = temp;']);
        endfor
    endfor
endfor


################################
# loop for to plot the results #
################################

for i=1:number_of_group_names
    for j=1:number_of_material_names
        eval(['figure_' , num2str(i) , num2str(j) , ' = figure((i-1)*number_of_material_names+j);']);
        for k=1:number_of_connexion_names
            eval(['S_' , num2str(i) , num2str(j) , num2str(k) , '= subplot(ceil(number_of_connexion_names/ceil(sqrt(number_of_connexion_names))),ceil(sqrt(number_of_connexion_names)),k);']);
            eval(['plot(frequency,CSV_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(k,:) , ');']);
            line ([3.5 3.5], [min_value((i-1)*number_of_material_names*number_of_connexion_names+(j-1)*number_of_connexion_names+k,:) max_value((i-1)*number_of_material_names*number_of_connexion_names+(j-1)*number_of_connexion_names+k,:)] , "linestyle", "-.", "color", "k");
            line ([3.4 3.4], [min_value((i-1)*number_of_material_names*number_of_connexion_names+(j-1)*number_of_connexion_names+k,:) max_value((i-1)*number_of_material_names*number_of_connexion_names+(j-1)*number_of_connexion_names+k,:)] , "linestyle", ":", "color", "k");
            line ([3.6 3.6], [min_value((i-1)*number_of_material_names*number_of_connexion_names+(j-1)*number_of_connexion_names+k,:) max_value((i-1)*number_of_material_names*number_of_connexion_names+(j-1)*number_of_connexion_names+k,:)] , "linestyle", ":", "color", "k");
            grid on;
            eval(['title( "' , connexion_names(k,:)  , '" )']);
            eval(['xlabel( "Freq \[GHz\]" )']);
            eval(['ylabel( "| Reflexion | \[dB\]" )']);
            temp = eval(['text_width_of_trace_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , ';']);
            eval(['L_' , num2str(i) , num2str(j) , num2str(k) , ' = legend(temp , "location" , "south" , "orientation" , "horizontal");']);
            eval(['set( L_' , num2str(i) , num2str(j) ,  num2str(k) , ' , "fontsize" , 14);']);
            set(gca, "fontsize", 18, "linewidth", 2);
        endfor
        eval(['S_' , num2str(i) , num2str(j) , " = axes( 'visible', 'off', 'title', '" , group_names_formated(i,:) , ' ' , material_names(j,:) , "');"]);
        set(gca, "fontsize", 24);
    endfor
endfor

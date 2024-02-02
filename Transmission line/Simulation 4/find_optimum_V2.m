############################################
# name of the groups and of the connexions #
############################################

close all;
clear all;

group_names = [ 'Coplanar' ];

connexion_names = [ 'S11' ;
 'S21' ;
 'S12' ;
 'S22' ];

material_names = [ '450LDS' ;
 '8MF44VG' ;
 'E840i' ;
 'LKX1767LDS' ];

###################################################
# argument for the max or min value to be optimal #
###################################################

min_arg = [ '1' ;
 '0' ;
 '0' ;
 '1' ];

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

################################
# import csv data as variables #
################################

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:number_of_connexion_names
            for l=1:ordering_1_step
                eval(['CSV_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(k,:) , '_' , num2str(l) , ' = csvread(strtrim(filename_of_csv((i-1)*number_of_material_names*number_of_connexion_names*ordering_1_step+(j-1)*number_of_connexion_names*ordering_1_step+(k-1)*ordering_1_step+l,:)));']);
            endfor
        endfor
    endfor
endfor

frequency = csvread("CSV_frequency.csv");

name_of_ordering_1 = [name_of_ordering_1 , '.csv'];
CSV_ordering_1 = csvread(name_of_ordering_1);

name_of_ordering_2 = [name_of_ordering_2 , '.csv'];
CSV_ordering_2 = csvread(name_of_ordering_2);

#######################################
# get the width of the trace from csv #
#######################################

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:ordering_1_step
            ordering_1(i,k,j) = CSV_ordering_1((i-1)*number_of_material_names*ordering_1_step+(j-1)*ordering_1_step+k);
        endfor
    endfor
endfor

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:ordering_2_step
            ordering_2(i,k,j) = CSV_ordering_2((i-1)*number_of_material_names*ordering_2_step+(j-1)*ordering_2_step+k);
        endfor
    endfor
endfor

#########################################
# find the max of all separate csv data #
#########################################

position_3_5 = round((3.5 - frequency(1,:)) / (frequency(2,:) - frequency(1,:)) + 1);

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:ordering_1_step
            for l=1:number_of_connexion_names
                temp = (i-1)*number_of_material_names*ordering_1_step*number_of_connexion_names+(j-1)*ordering_1_step*number_of_connexion_names+(k-1)*number_of_connexion_names+l;
                [max_value(temp,:) , max_pos(temp,:)] = max(max(eval(['CSV_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(l,:) , '_' , num2str(k) , ';'])));
            endfor
        endfor
    endfor
endfor

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:ordering_1_step
            for l=1:number_of_connexion_names
                temp = (i-1)*number_of_material_names*ordering_1_step*number_of_connexion_names+(j-1)*ordering_1_step*number_of_connexion_names+(k-1)*number_of_connexion_names+l;
                [min_value(temp,:) , min_pos(temp,:)] = min(min(eval(['CSV_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(l,:) , '_' , num2str(k) , ';'])));
            endfor
        endfor
    endfor
endfor

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:ordering_1_step
            for l=1:number_of_connexion_names
                temp = (i-1)*number_of_material_names*ordering_1_step*number_of_connexion_names+(j-1)*ordering_1_step*number_of_connexion_names+(k-1)*number_of_connexion_names+l;
                if (min_arg(l,:) == '1')
                    optimal_curve(temp,:) = min_pos(temp,:);
                else
                    optimal_curve(temp,:) = max_pos(temp,:);
                endif
            endfor
        endfor
    endfor
endfor

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:ordering_1_step
            for l=1:number_of_connexion_names
                temp = (i-1)*number_of_material_names*ordering_1_step*number_of_connexion_names+(j-1)*ordering_1_step*number_of_connexion_names+(k-1)*number_of_connexion_names+l;
                value_3_5(temp,:) = eval(['CSV_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(l,:) , '_' , num2str(k) , '(position_3_5,optimal_curve(temp,:));']);
            endfor
        endfor
    endfor
endfor

########################################
# prepare optimum matrix to be plotted #
########################################

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:ordering_1_step
            for l=1:number_of_connexion_names
                temp = (i-1)*number_of_material_names*ordering_1_step*number_of_connexion_names+(j-1)*ordering_1_step*number_of_connexion_names+(k-1)*number_of_connexion_names+l;
                eval(['Optimal_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(l,:) , '_' , num2str(k) , ' = CSV_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(l,:) , '_' , num2str(k) , '(:,optimal_curve(temp));']);
            endfor
        endfor
    endfor
endfor

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:ordering_1_step
            for l=1:number_of_connexion_names
                temp = (i-1)*number_of_material_names*ordering_1_step*number_of_connexion_names+(j-1)*ordering_1_step*number_of_connexion_names+(k-1)*number_of_connexion_names+l;
                line_max_value(temp,:) = max(eval(['Optimal_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(l,:) , '_' , num2str(k) , ';'])) ;
                line_min_value(temp,:) = min(eval(['Optimal_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(l,:) , '_' , num2str(k) , ';'])) ;
            endfor
        endfor
    endfor
endfor

#################################################
# prepare some string for ease of use into loop #
#################################################

group_names_formated = strrep(group_names , "_" , " ");

optimal_width_of_trace = zeros(number_of_group_names * number_of_material_names * number_of_connexion_names,1);

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:ordering_1_step
            for l=1:number_of_connexion_names
                temp = (i-1)*number_of_material_names*ordering_1_step*number_of_connexion_names+(j-1)*ordering_1_step*number_of_connexion_names+(k-1)*number_of_connexion_names+l;
                eval(['optimal_width(temp,:) = ordering_2(i,optimal_curve(temp,:),j);']);
            endfor
        endfor
    endfor
endfor

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:ordering_1_step
            eval(['text_ordering_1_group_' , num2str(i) , '_mat_' , num2str(j) , '(k,:) = num2str(ordering_1(i,k,j));']);
        endfor
    endfor
endfor

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:ordering_2_step
            eval(['text_ordering_2_group_' , num2str(i) , '_mat_' , num2str(j) , '(k,:) = num2str(ordering_2(i,k,j));']);
        endfor
    endfor
endfor

################################
# loop for to plot the results #
################################

for i=1:number_of_group_names
    for j=1:number_of_material_names
        for k=1:ordering_1_step
            eval(['figure_' , num2str(i) , num2str(j) , ' = figure((i-1)*number_of_material_names*ordering_1_step+(j-1)*ordering_1_step+k);']);
            for l=1:number_of_connexion_names
                temp_step = (i-1)*number_of_material_names*ordering_1_step*number_of_connexion_names+(j-1)*ordering_1_step*number_of_connexion_names+(k-1)*number_of_connexion_names+l;
                eval(['S_' , num2str(i) , num2str(j) , num2str(l) , num2str(k) , ' = subplot(ceil(number_of_connexion_names/ceil(sqrt(number_of_connexion_names))),ceil(sqrt(number_of_connexion_names)),l);']);
                eval(['plot(frequency,Optimal_' , strtrim(group_names(i,:)) , '_' , strtrim(material_names(j,:)) , '_' , connexion_names(l,:) , '_' , num2str(k) , ');']);
                line ([3.5 3.5], [line_min_value(temp_step,:) line_max_value(temp_step,:)] , "linestyle", "-.", "color", "k");
                line ([3.4 3.4], [line_min_value(temp_step,:) line_max_value(temp_step,:)] , "linestyle", ":", "color", "k");
                line ([3.6 3.6], [line_min_value(temp_step,:) line_max_value(temp_step,:)] , "linestyle", ":", "color", "k");
                grid on;
                temp = eval(['text_ordering_1_group_' , num2str(i) , '_mat_' , num2str(j) , '(k,:);']);
                eval(['title( "' , connexion_names(l,:)  , ' - ' temp ' mm" )']);
                eval(['xlabel( "Freq \[GHz\]" )']);
                eval(['ylabel( "| Reflexion | \[dB\]" )']);
                eval(['text(3.7,value_3_5(temp_step,:),num2str(value_3_5(temp_step,:)))']);
	        temp = eval(['num2str(optimal_width(temp_step,:));']);
	        eval(['L_' , num2str(i) , num2str(j) , num2str(l) , ' = legend(temp , "location" , "south" , "orientation" , "horizontal");']);
                eval(['set( L_' , num2str(i) , num2str(j) ,  num2str(l) , ' , "fontsize" , 14);']);
                set(gca, "fontsize", 18, "linewidth", 2);
            endfor
            eval(['S_' , num2str(i) , num2str(j) , " = axes( 'visible', 'off', 'title', '" , group_names_formated(i,:) , ' ' , material_names(j,:) , "');"]);
            set(gca, "fontsize", 24);
        endfor
    endfor
endfor

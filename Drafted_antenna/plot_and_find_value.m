############################################
################ variables #################
############################################

close all;
clear all;

CSV_names = [ "Simulation-1-575.csv" ;
 "Simulation-2-798.csv" ;
 "Simulation-4-022.csv" ;
 "Simulation-5-248.csv" ;
 "Simulation-6-475.csv" ;
 "Simulation-7-706.csv" ] ;

Thickness_names = [ "1,575" ;
 "2,798" ;
 "4,022" ;
 "5,248" ;
 "6,475" ;
 "7,706" ] ;

number_of_angle = 6;

number_of_csv = rows(CSV_names);

number_of_frequency = 61;

############################################
############# import csv data ##############
############################################

for i=1:number_of_csv
    eval(['CSV_' , num2str(i) , ' = csvread(strtrim(CSV_names(i,:)));']);
endfor

############################################
## remove the first line of the variables ##
############################################

for i=1:number_of_csv
    eval(['CSV_' , num2str(i) , ' = CSV_' , num2str(i) , '(2:end,:);']);
endfor

############################################
############## rearrange data ##############
############################################

for i=1:number_of_frequency
	frequency(i,1) = CSV_1(i,2);
endfor

for i=1:number_of_csv
	for j=1:number_of_angle
		for k=1:number_of_frequency
        		eval(['CSV_combined_' , num2str(i) , '(k,j) = CSV_' , num2str(i) , '((j-1)*number_of_frequency+k,3);']);
		endfor
	endfor
endfor

############################################
############ find minimum value ############
############################################

position = 31;

for i=1:number_of_csv
	min_value(i,1) = eval(['min(CSV_combined_' , num2str(i) , '(position,:));']);
endfor

############################################
############## plot the value ##############
############################################

for i=1:number_of_csv
	figure(i);
	eval(['plot(frequency,CSV_combined_' , num2str(i) ,',"linewidth", 3);']);
	eval(['title("angle ' , num2str(i-1) , '");']);
	set(gca, "fontsize", 24);
	line([frequency(position) frequency(position)], [min_value(i,1) 0]);
	xlim([frequency(1) , frequency(number_of_frequency)]);
	leg = legend(Thickness_names);
	set(gca, "fontsize", 18);
endfor

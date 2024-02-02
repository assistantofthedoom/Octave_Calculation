function [mesh_emission] = test_emission_FFT_pattern(number_of_points, antenna_angle, x_pos, y_pos, matrix_size, FFT_filename)

	mesh_emission = zeros(number_of_points,number_of_points);

	FFT_coefficient = csvread(FFT_filename);

	number_coefficient = rows(FFT_coefficient);

	for i=1:number_of_points
		for j=1:number_of_points
			if(i < matrix_size + x_pos)
				temp = (atan((j - matrix_size - y_pos) / (i - matrix_size - x_pos)) - pi) - antenna_angle;
			else
				temp = (atan((j - matrix_size - y_pos) / (i - matrix_size - x_pos))) - antenna_angle;
			endif

			mesh_emission(j,i) = FFT_coefficient(1,1);

			for k=2:number_coefficient
				mesh_emission(j,i) = mesh_emission(j,i) + FFT_coefficient(k,1) * cos((k-1)*temp) + FFT_coefficient(k,2) * sin((k-1)*temp);
			endfor

		endfor
	endfor


endfunction

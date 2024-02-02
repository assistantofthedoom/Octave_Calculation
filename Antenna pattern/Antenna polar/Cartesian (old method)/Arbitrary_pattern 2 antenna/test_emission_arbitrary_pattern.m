function [mesh_emission] = test_emission_arbitrary_pattern(number_of_points, antenna_angle, x_pos, y_pos, matrix_size, pattern)

	[row, column] = size(pattern);
	mesh_emission = zeros(number_of_points,number_of_points);

	for i=1:number_of_points
		for j=1:number_of_points
			test_condition = 0;
			k = 1;
			if (i < matrix_size + x_pos)
				temp = (atan((j - matrix_size - y_pos) / (i - matrix_size - x_pos)) - pi) - antenna_angle;
			else
				temp = (atan((j - matrix_size - y_pos) / (i - matrix_size - x_pos))) - antenna_angle;
			endif

			temp_value = mod(temp+pi,2*pi);

			while(test_condition == 0)
				if((temp_value >= pattern(1,k)) && (temp_value < pattern(1,k + 1)))
					test_condition = 1;
					mesh_emission(j,i) = pattern(2,k);
				endif
				k = k + 1;
				if(k + 1 > column)
					test_condition = 1;
				endif
			endwhile
		endfor
	endfor


endfunction
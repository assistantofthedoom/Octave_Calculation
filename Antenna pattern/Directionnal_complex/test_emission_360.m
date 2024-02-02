function [mesh_emission] = test_emission_360(number_of_points, antenna_angle, x_pos, y_pos, matrix_size, form_factor, angle_factor)

	mesh_emission = zeros(number_of_points,number_of_points);

	for i=1:number_of_points
		for j=1:number_of_points
			if(i < matrix_size + x_pos)
				temp = (atan((j - matrix_size - y_pos) / (i - matrix_size - x_pos)) - pi) - antenna_angle;
			else
				temp = (atan((j - matrix_size - y_pos) / (i - matrix_size - x_pos))) - antenna_angle;
			endif
			mesh_emission(j,i) = (form_factor + cos(angle_factor * (mod(temp+pi,2*pi)-pi))) / (1 + form_factor);
		endfor
	endfor


endfunction

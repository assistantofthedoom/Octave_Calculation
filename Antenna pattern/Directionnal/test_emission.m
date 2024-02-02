function [mesh_emission] = test_emission(number_of_points, angle_1, angle_2, x_pos, y_pos, matrix_size, angle_emission)

	mesh_emission = zeros(number_of_points,number_of_points);

	m_1 = tan(angle_1 * pi / 180);
	m_2 = tan(angle_2 * pi / 180);

	###
	if (angle_1 == 0)
		if (angle_2 == 0)
			#all
			for i=1:number_of_points
				for j=1:number_of_points
					mesh_emission(j,i) = 1;
				endfor
			endfor
		endif
		if (angle_2 > 0 && angle_2 < 90)
			#below line_1 or above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) || (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 == 90)
			#below line_1 or x<0
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) || (i - matrix_size - 1 - x_pos) < 0 )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 90 && angle_2 < 180)
			#below line_1 or below line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) || (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 == 180)
			#below line_1 and below line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) &&  (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 180 && angle_2 < 270)
			#below line_1 and below line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) &&  (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 == 270)
			#below line_1 and x > 0
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) && (i - matrix_size - 1 - x_pos) > 0 )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 270 && angle_2 < 360)
			#below line_1 and above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
	endif
	if (angle_1 > 0 && angle_1 < 90)
		if (angle_2 == 0)
			#below line_1 and above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 0 && angle_2 < 90)
			if (angle_1 > angle_2)
				#below line_1 and above line_2
				for i=1:number_of_points
					for j=1:number_of_points
						if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
							mesh_emission(j,i) = 1;
						endif
					endfor
				endfor
			endif
			if (angle_1 == angle_2)
				if (angle_emission == 360)
					#all
					for i=1:number_of_points
						for j=1:number_of_points
							mesh_emission(j,i) = 1;
						endfor
					endfor
				endif
			endif
			if (angle_1 < angle_2)
				#below line_1 or above line_2
				for i=1:number_of_points
					for j=1:number_of_points
						if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) || (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
							mesh_emission(j,i) = 1;
						endif
					endfor
				endfor
			endif
		endif
		if (angle_2 == 90)
			#below line_1 or x < 0
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) || (i - matrix_size - 1 - x_pos) < 0 )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 90 && angle_2 < 180)
			#below line_1 or below line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) || (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 == 180)
			#below line_1 and below line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 180 && angle_2 < 270)
			if (angle_1 > angle_2 - 180)
				#below line_1 or below line_2
				for i=1:number_of_points
					for j=1:number_of_points
						if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) || (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
							mesh_emission(j,i) = 1;
						endif
					endfor
				endfor
			endif
			if (angle_1 == angle_2 - 180)
				if (angle_emission == 180)
					#below line_1 and below line_2
					for i=1:number_of_points
						for j=1:number_of_points
							if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
								mesh_emission(j,i) = 1;
							endif
						endfor
					endfor
				endif
			endif
			if (angle_1 < angle_2 - 180)
				#below line_1 and below line_2
				for i=1:number_of_points
					for j=1:number_of_points
						if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
							mesh_emission(j,i) = 1;
						endif
					endfor
				endfor
			endif
		endif
		if (angle_2 == 270)
			#below line_1 and x > 0
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) && (i - matrix_size - 1 - x_pos) > 0 )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 270 && angle_2 < 360)
			#below line_1 and above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 == 360)
			#below line_1 and above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
	endif
	if (angle_1 == 90)
		if (angle_2 == 0)
			#x > 0 and above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (i - matrix_size - 1 - x_pos) > 0 && (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 0 && angle_2 < 90)
			#x > 0 and above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (i - matrix_size - 1 - x_pos) > 0 && (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 == 90)
			if (angle_emission == 360)
				#all
				for i=1:number_of_points
					for j=1:number_of_points
						mesh_emission(j,i) = 1;
					endfor
				endfor
			endif
		endif
		if (angle_2 > 90 && angle_2 < 180)
			#x > 0 or below line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (i - matrix_size - 1 - x_pos) > 0 || (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 == 180)
			#x > 0 or below line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (i - matrix_size - 1 - x_pos) > 0 || (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 180 && angle_2 < 270)
			#x > 0 or below line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (i - matrix_size - 1 - x_pos) > 0 || (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 == 270)
			#x > 0
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (i - matrix_size - 1 - x_pos) > 0 )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 270 && angle_2 < 360)
			#x > 0 and above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (i - matrix_size - 1 - x_pos) > 0 && (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 == 360)
			#x > 0 and above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (i - matrix_size - 1 - x_pos) > 0 && (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
	endif
	if (angle_1 > 90 && angle_1 < 180)
		if (angle_2 == 0)
			#above line_1 and above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 0 && angle_2 < 90)
			#above line_1 and above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 == 90)
			#above line_1 and x < 0
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) && (i - matrix_size - 1 - x_pos) < 0 )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 90 && angle_2 < 180)
			if (angle_1 > angle_2)
				#above line_1 and below line_2
				for i=1:number_of_points
					for j=1:number_of_points
						if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
							mesh_emission(j,i) = 1;
						endif
					endfor
				endfor
			endif
			if (angle_1 == angle_2)
				if (angle_emission == 360)
					#all
					for i=1:number_of_points
						for j=1:number_of_points
							mesh_emission(j,i) = 1;
						endfor
					endfor
				endif
			endif
			if (angle_1 < angle_2)
				#above line_1 or below line_2
				for i=1:number_of_points
					for j=1:number_of_points
						if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) || (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
							mesh_emission(j,i) = 1;
						endif
					endfor
				endfor
			endif
		endif
		if (angle_2 == 180)
			#above line_1 or below line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) || (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 180 && angle_2 < 270)
			#above line_1 or below line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) || (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 == 270)
			#above line_1 or x > 0
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) || (i - matrix_size - 1 - x_pos) > 0 )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 270 && angle_2 < 360)
			if (angle_1 > angle_2 - 180)
				#above line_1 or above line_2
				for i=1:number_of_points
					for j=1:number_of_points
						if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) || (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
							mesh_emission(j,i) = 1;
						endif
					endfor
				endfor
			endif
			if (angle_1 == angle_2 - 180)
				if (angle_emission == 180)
					#above line_1 and above line_2
					for i=1:number_of_points
						for j=1:number_of_points
							if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
								mesh_emission(j,i) = 1;
							endif
						endfor
					endfor
				endif
			endif
			if (angle_1 < angle_2 - 180)
				#above line_1 and above line_2
				for i=1:number_of_points
					for j=1:number_of_points
						if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
							mesh_emission(j,i) = 1;
						endif
					endfor
				endfor
			endif
		endif
		if (angle_2 == 360)
			#above line_1 and above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
	endif
	if (angle_1 == 180)
		if (angle_2 == 0)
			#above line_1 and above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 0 && angle_2 < 90)
			#above line_1 and above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 == 90)
			#above line_1 and x < 0
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) && (i - matrix_size - 1 - x_pos) < 0 )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 90 && angle_2 < 180)
			#above line_1 and below line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 == 180)
			if (angle_emission == 360)
				#all
				for i=1:number_of_points
					for j=1:number_of_points
						mesh_emission(j,i) = 1;
					endfor
				endfor
			endif
		endif
		if (angle_2 > 180 && angle_2 < 270)
			#above line_1 or below line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) || (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 == 270)
			#above line_1 or x > 0
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) || (i - matrix_size - 1 - x_pos) > 0 )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 270 && angle_2 < 360)
			#above line_1 or above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) || (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 == 360)
			#above line_1 or above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) || (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
	endif
	if (angle_1 > 180 && angle_1 < 270)
		if (angle_2 == 0)
			#above line_1 or above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) || (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 0 && angle_2 < 90)
			if (angle_1 - 180 > angle_2)
				#above line_1 or above line_2
				for i=1:number_of_points
					for j=1:number_of_points
						if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) || (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
							mesh_emission(j,i) = 1;
						endif
					endfor
				endfor
			endif
			if (angle_1 - 180 == angle_2)
				if (angle_emission == 180)
					#above line_1 and above line_2
					for i=1:number_of_points
						for j=1:number_of_points
							if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
								mesh_emission(j,i) = 1;
							endif
						endfor
					endfor
				endif
			endif
			if (angle_1 - 180 < angle_2)
				#above line_1 and above line_2
				for i=1:number_of_points
					for j=1:number_of_points
						if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
							mesh_emission(j,i) = 1;
						endif
					endfor
				endfor
			endif
		endif
		if (angle_2 == 90)
			#above line_1 and x < 0
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) && (i - matrix_size - 1 - x_pos) < 0 )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 90 && angle_2 < 180)
			#above line_1 and below line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 == 180)
			#above line_1 and below line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 180 && angle_2 < 270)
			if (angle_1 > angle_2)
				#above line_1 and below line_2
				for i=1:number_of_points
					for j=1:number_of_points
						if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
							mesh_emission(j,i) = 1;
						endif
					endfor
				endfor
			endif
			if (angle_1 == angle_2)
				if (angle_emission == 360)
					#all
					for i=1:number_of_points
						for j=1:number_of_points
							mesh_emission(j,i) = 1;
						endfor
					endfor
				endif
			endif
			if (angle_1 < angle_2)
				#above line_1 or below line_2
				for i=1:number_of_points
					for j=1:number_of_points
						if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) || (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
							mesh_emission(j,i) = 1;
						endif
					endfor
				endfor
			endif
		endif
		if (angle_2 == 270)
			#above line_1 or x > 0
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) || (i - matrix_size - 1 - x_pos) > 0 )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 270 && angle_2 < 360)
			#above line_1 or above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) || (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 == 360)
			#above line_1 or above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) > (m_1 * (i - matrix_size - 1 - x_pos)) || (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
	endif
	if (angle_1 == 270)
		if (angle_2 == 0)
			#x < 0 or above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (i - matrix_size - 1 - x_pos) < 0 || (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 0 && angle_2 < 90)
			#x < 0 or above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (i - matrix_size - 1 - x_pos) < 0 || (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 == 90)
			#x < 0
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (i - matrix_size - 1 - x_pos) < 0 )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 90 && angle_2 < 180)
			#x < 0 and below line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (i - matrix_size - 1 - x_pos) < 0 && (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 == 180)
			#x < 0 and below line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (i - matrix_size - 1 - x_pos) < 0 && (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 180 && angle_2 < 270)
			#x < 0 and below line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (i - matrix_size - 1 - x_pos) < 0 && (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 == 270)
			if (angle_emission == 360)
				#all
				for i=1:number_of_points
					for j=1:number_of_points
						mesh_emission(j,i) = 1;
					endfor
				endfor
			endif
		endif
		if (angle_2 > 270 && angle_2 < 360)
			#x < 0 or above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (i - matrix_size - 1 - x_pos) < 0 || (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 == 360)
			#x < 0 or above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (i - matrix_size - 1 - x_pos) < 0 || (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
	endif
	if (angle_1 > 270 && angle_1 < 360)
		if (angle_2 == 0)
			#below line_1 or above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) || (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 0 && angle_2 < 90)
			#below line_1 or above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) || (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 == 90)
			#below line_1 or x < 0
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) || (i - matrix_size - 1 - x_pos) < 0 )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 90 && angle_2 < 180)
			if (angle_1 - 180 > angle_2)
				#below line_1 or below line_2
				for i=1:number_of_points
					for j=1:number_of_points
						if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) || (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
							mesh_emission(j,i) = 1;
						endif
					endfor
				endfor
			endif
			if (angle_1 - 180 == angle_2)
				if (angle_emission == 180)
					#below line_1 and below line_2
					for i=1:number_of_points
						for j=1:number_of_points
							if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
								mesh_emission(j,i) = 1;
							endif
						endfor
					endfor
				endif
			endif
			if (angle_1 - 180 < angle_2)
				#below line_1 and below line_2
				for i=1:number_of_points
					for j=1:number_of_points
						if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
							mesh_emission(j,i) = 1;
						endif
					endfor
				endfor
			endif
		endif
		if (angle_2 == 180)
			#below line_1 and below line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 180 && angle_2 < 270)
			#below line_1 and below line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) < (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 == 270)
			#below line_1 and x > 0
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) && (i - matrix_size - 1 - x_pos) < 0 )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
		if (angle_2 > 270 && angle_2 < 360)
			if (angle_1 > angle_2)
				#below line_1 and above line_2
				for i=1:number_of_points
					for j=1:number_of_points
						if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) && (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
							mesh_emission(j,i) = 1;
						endif
					endfor
				endfor
			endif
			if (angle_1 == angle_2)
				if (angle_emission == 360)
					#all
					for i=1:number_of_points
						for j=1:number_of_points
							mesh_emission(j,i) = 1;
						endfor
					endfor
				endif
			endif
			if (angle_1 < angle_2)
				#below line_1 or above line_2
				for i=1:number_of_points
					for j=1:number_of_points
						if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) || (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
							mesh_emission(j,i) = 1;
						endif
					endfor
				endfor
			endif
		endif
		if (angle_2 == 360)
			#below line_1 or above line_2
			for i=1:number_of_points
				for j=1:number_of_points
					if ( (j - matrix_size - 1 - y_pos) < (m_1 * (i - matrix_size - 1 - x_pos)) || (j - matrix_size - 1 - y_pos) > (m_2 * (i - matrix_size - 1 - x_pos)) )
						mesh_emission(j,i) = 1;
					endif
				endfor
			endfor
		endif
	endif

endfunction
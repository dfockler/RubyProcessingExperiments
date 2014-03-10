
attr_reader :cells, :cell_size, :cell_num

def setup
	size 600, 600
	frameRate 5
	@cell_num = 30
	@cell_size = 20
	@cells = Array.new(@cell_num){|i| Array.new(@cell_num){|j| rand(2)}}
end

def draw

	background 0 

	@cells.each_with_index do |row, i|
		row.each_with_index do |col, j|
			fill 0
			strokeWeight 2
			if col == 0 #if starting opposite
				stroke 255
				ellipse i * @cell_size, j * @cell_size, 10, 10
				line i * @cell_size + @cell_size, j * @cell_size, i * @cell_size , j * @cell_size + @cell_size
			else #if starting normal
				stroke 255, 0, 0
				ellipse i * @cell_size, j * @cell_size, 10, 10
				stroke 255
				line i * @cell_size + 5, j * @cell_size + 5, i * @cell_size + @cell_size, j * @cell_size + @cell_size
			end
		end
	end

	new_cells = Array.new(@cell_num){ Array.new(@cell_num) }
	@cells.each_with_index do |row, i|
		row.each_with_index do |col, j|
			new_state = change_state(i, j)
			new_cells[i][j] = new_state
		end	
	end

	@cells = new_cells
	
end

#checks neighbors
def change_state(row, col)
	neighbors = 0
	
	#left top
	if row > 0 && col > 0
		neighbors += @cells[row-1][col-1]
	end

	#mid top
	if row > 0
		neighbors += @cells[row-1][col]
	end

	#right top
	if row > 0 && col < (@cell_num - 1)
		neighbors += @cells[row-1][col+1]
	end

	#left center
	if col > 0 
		neighbors += @cells[row][col-1]
	end

	#right center
	if col < (@cell_num - 1)
		neighbors += @cells[row][col+1]
	end

	#left bottom
	if row < (@cell_num - 1) && col > 0
		neighbors += @cells[row+1][col-1]
	end

	#mid bottom
	if row < (@cell_num - 1)
		neighbors += @cells[row+1][col]
	end

	#right bottom
	if row < (@cell_num - 1) && col < (@cell_num - 1)
		neighbors += @cells[row+1][col+1]
	end

	curr_state = @cells[row][col]

	return life_logic(neighbors, curr_state)
end


def life_logic(neighbors, curr_state)
	if (neighbors == 2 || neighbors == 3) && curr_state == 1
		return 1
	elsif curr_state == 0 && neighbors == 3
		return 1
	else
		return 0
	end
end
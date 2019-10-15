require_relative 

class Board 
    def initialize
        @rows = Array.new(8) { Array.new(8, nil) }
        @rows.each_with_index do |row,row_index|
            row.each_with_index do |column,col_index|
                if row_index < 2 || row_index > 5
                    @rows[row_index][col_index] = :P
                else
                    @rows[row_index][col_index] = :N
                end
            end
        end
    end

    def [](pos)
        row, col = pos
        @rows[row][col]
    end

    def []=(pos, value)
        row, col = pos
        @rows[row][col] = value       
    end

    def move_piece(start_pos,end_pos)
        # 1 - remove piece from start_pos using @rows variable
        # 2 - add piece to end_pos using @rows variable
        # 3 - piece.pos = end_pos
        
        raise error if @rows[end_pos] == nil       
    end


end
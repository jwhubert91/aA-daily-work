require "PolyTreeNode"
require "Queue"

class KnightPathFinder

    def initialize(pos)
        @root_node = PolyTreeNode.new(pos)
        @board = Array.new(8) { Array.new(8) }
        @considered_positions = pos
    end

    def self.valid_moves(pos)
        valid_moves_arr = []
        x, y = pos[0], pos[1]

        valid_moves_arr << [x+1, y+2]
        valid_moves_arr << [x+1, y-2]
        valid_moves_arr << [x-1, y+2]
        valid_moves_arr << [x-1, y-2]
        valid_moves_arr << [x+2, y+1]
        valid_moves_arr << [x+2, y-1]
        valid_moves_arr << [x-2, y+1]
        valid_moves_arr << [x-2, y-1]

        valid_moves_arr.select def |pos|
            (pos[0] < 8 && pos[0] => 0) &&
            (pos[1] < 8 && pos[1] => 0)
        end
    end

    def new_move_positions(pos)
        new_moves_arr = self.valid_moves(pos).reject do |position|
            @considered_positions.include?(position)
        end
        @considered_positions += new_moves_arr
        new_moves_arr
    end

    def build_move_tree
        queue = Queue.new([@root_node])
        new_move_positions.each do |position|
            child = PolyTreeNode.new(position)
            @root_node.add_child(child)
            queue.enqueue(child)
        end
        queue
    end
end

if __FILE__ == $PROGRAM_NAME
    kpf = KnightPathFinder.new([0,0])
end
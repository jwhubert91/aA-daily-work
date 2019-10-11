require "byebug"
require "Queue"

class PolyTreeNode
    attr_reader :children, :parent, :value

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def inspect
        @value.inspect
    end

    def parent=(node)
        @parent.children.delete(self) if @parent != nil

        @parent = node
        if node != nil
            node.children << self if !node.children.include?(self)
        end
    end

    def add_child(node)
        node.parent = self
        self.children << node if !self.children.include?(node)
    end

    def remove_child(node)
        raise "This node is no child of mine!" if !self.children.include?(node)
        node.parent = nil
        self.children.delete(node)
    end

    def dfs(target)
        return self if self.value == target
        self.children.each do |node| 
            dfs_return = node.dfs(target)
            if dfs_return != nil
                return dfs_return
            end
        end
        nil
    end

    def bfs(target)
        queue = Queue.new([self])
        until queue.length == 0
            inspect_node = queue.dequeue
            if inspect_node.value == target
                return inspect_node
            else
                inspect_node.children.each { |child| queue.enqueue(child) }
            end
        end
        nil
    end
    
end
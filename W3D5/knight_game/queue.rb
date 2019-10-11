class Queue
    def initialize(arr)
        @queue = arr
    end

    def enqueue(el)
        @queue = [*@queue, el]
    end

    def dequeue
        first_val = @queue.first
        @queue = @queue[1..-1]
    end

    def peek
        @queue.first
    end
end
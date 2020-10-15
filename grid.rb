class Grid

    def initialize
        @current_grid = [["1","2","3"],["4","5","6"],["7","8","9"]]
    end

    def draw_self
        z = 0
        for i in 0..4 do
            if i.even?
                puts @current_grid[z].join("|")
                z += 1
            else
                puts '-+-+-'
            end
            i += 1
        end
    end

    def update_current_grid old_arr_el, new_ar_el
        @current_grid.each { |out_el| out_el.map! { |el| el == old_arr_el ? new_ar_el : el }}
    end

    def get_grid
        @current_grid
    end

    def reset
        @current_grid = [["1","2","3"],["4","5","6"],["7","8","9"]]
    end
end
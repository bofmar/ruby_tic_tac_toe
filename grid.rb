class Grid
    @@initial_grid = [["1","2","3"],["4","5","6"],["7","8","9"]]

    def initialize
        @current_grid = @@initial_grid.clone
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

    def reset
        @current_grid = @@initial_grid.clone
    end
end
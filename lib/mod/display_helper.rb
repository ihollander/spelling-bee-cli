module DisplayHelper
  module InstanceMethods
    # puts an single-dimensional array to columns
    def puts_to_columns(array, columns=4)
      terminal_width = `tput cols`.to_i #width of terminal
      col_width = (terminal_width / columns)
      rows = (array.length / columns.to_f).ceil

      rows.times do |current_row|
        output = ""
        columns.times do |j|
          index = current_row + (j * rows) #offset by total number of rows
          output += (array[index] || " ").ljust(col_width)
        end
        puts output
      end
    end
  end
end

# history
# http://blog.bleything.net/pages
# http://gilesbowkett.blogspot.com/2007/06/irbrc-modifications.html
# Ben's history stuff, slightly modified, plus hvi method
class Object
  def history(how_many = 50)
    history_size = Readline::HISTORY.size
    # no lines, get out of here
    puts "No history" and return if history_size == 0
    start_index = 0
    # not enough lines, only show what we have
    if history_size <= how_many
      how_many  = history_size - 1
      end_index = how_many
    else
      end_index = history_size - 1 # -1 to adjust for array offset
      start_index = end_index - how_many 
    end
    start_index.upto(end_index) {|i| print_line i}
  end
  alias :h  :history

  # -2 because -1 is ourself
  def history_do(lines = (Readline::HISTORY.size - 2))
    irb_eval lines
  end 
  alias :h! :history_do

  def history_write(filename, lines)
    file = File.open(filename, 'w')
    get_lines(lines).each do |l|
      file << "#{l}\n"
    end
    file.close
  end

  # TODO: history_write should go to a file, or the clipboard, or a file which opens in an application
  def history_to_vi
    file = Tempfile.new("irb_tempfile")
    get_lines(0..(Readline::HISTORY.size - 1)).each do |line|
      file << "#{line}\n"
    end
    file.close
    system("vim #{file.path}")
  end
  alias :hvi :history_to_vi

  private
  def get_line(line_number)
    Readline::HISTORY[line_number] rescue ""
  end

  def get_lines(lines = [])
    return [get_line(lines)] if lines.is_a? Fixnum
    out = []
    lines = lines.to_a if lines.is_a? Range
    lines.each do |l|
      out << Readline::HISTORY[l]
    end
    out
  end

  def print_line(line_number, show_line_numbers = true)
    print line_number.to_s + ": " if show_line_numbers
    puts get_line(line_number)
  end

  def irb_eval(lines)
    to_eval = get_lines(lines)
    to_eval.each {|l| Readline::HISTORY << l}
    eval to_eval.join("\n")
  end
end


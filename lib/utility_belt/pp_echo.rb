require 'pp'
require 'stringio'

# Echo return values pretty-printed
#
# Inspired by a ruby-talk posting by Joel VanderWerf <vjoel@path.berkeley.edu>.
# See also yaml_echo.rb
if Object.const_defined?(:IRB)
  IRB::Irb.class_eval do
    alias :output_value_without_pp :output_value
    def output_value
      if @context.inspect?
        output = StringIO.new
        PP.pp(@context.last_value, output)
        printf @context.return_format, output.string
      else
        printf @context.return_format, @context.last_value
      end
    end
  end
end

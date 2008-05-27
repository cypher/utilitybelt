require 'yaml'

# Echo return values in glorious YAML format
#
# As seen on ruby-talk, by Joel VanderWerf <vjoel@path.berkeley.edu>
if Object.const_defined?(:IRB)
  IRB::Irb.class_eval do
    alias :output_value_without_yaml :output_value
    def output_value
      if @context.inspect?
        printf @context.return_format, @context.last_value.to_yaml
      else
        printf @context.return_format, @context.last_value
      end
    end
  end
end

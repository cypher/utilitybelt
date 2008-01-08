# Allow to select which gadgets to equip
#
# Author: Markus Prinz <markus.prinz@qsig.org>

module UtilityBelt
  class << self
    def equip(*args)
      Equipper.equip(*args)
    end
    def equipped?
      Equipper.equipped?
    end
  end
  module Equipper
    GADGETS = Dir['./lib/utility_belt/*.rb'].map{|file| file[6..-4]}.reject do |gadget|
      %w{equipper}.include? gadget
    end
  
    DEFAULTS = %w{hash_math
                  interactive_editor
                  irb_options
                  syntax_coloring}
    
    @equipped = false
    
    class << self
      def equip(*args)
        return if args.empty?
    
        gadgets_to_equip = []
    
        # Special case using :all or :none
        if args[0].is_a?(Symbol) && [:all, :none, :defaults].include?(args[0])
          what = args[0]
      
          unless args[1].nil?
            exceptions = args[1].has_key?(:except) ? args[1][:except] : []
        
            # Handle special case where we get a string or a symbol instead of an array
            exceptions = exceptions.to_s.to_a unless exceptions.is_a?( Array )
          else
            exceptions = []
          end
      
          case what
          when :all
            gadgets_to_equip.push(*(GADGETS - exceptions))
          when :none
            gadgets_to_equip.push(*exceptions)
          when :defaults
            gadgets_to_equip.push(*DEFAULTS)
          end
        # otherwise, args is a list of gadgets to equip
        else
          args.each do |arg|
            gadget = arg.to_s
        
            # Silently ignore unkown gadgets
            gadgets_to_equip << gadget if GADGETS.include? gadget
          end
        end
    
        gadgets_to_equip.each{|gadget| require gadget }
    
        @equipped ||= true
      end
      def equipped?
        @equipped
      end
    end
  end
end

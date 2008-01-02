# original clipboard code: http://project.ioni.st/post/1334#snippet_1334
# turned it into a class to make it flexxy:
# http://gilesbowkett.blogspot.com/2007/09/improved-auto-pastie-irb-code.html
require 'platform'
class MacClipboard
  if :macosx == Platform::IMPL
    class << self
      def read
        IO.popen('pbpaste') {|clipboard| clipboard.read}
      end
      def write(stuff)
        IO.popen('pbcopy', 'w+') {|clipboard| clipboard.write(stuff)}
      end
    end
  end
end

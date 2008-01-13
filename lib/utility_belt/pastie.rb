# automate creating pasties
%w{platform net/http utility_belt}.each {|lib| require lib}
module UtilityBelt
  module Pastie
    def pastie(stuff_to_paste = nil)
      stuff_to_paste ||= Clipboard.read if Clipboard.available?
      # return nil unless stuff_to_paste

      pastie_url = Net::HTTP.post_form(URI.parse("http://pastie.caboo.se/pastes/create"),
                                       {"paste_parser" => "ruby",
                                        "paste[authorization]" => "burger",
                                        "paste[body]" => stuff_to_paste}).body.match(/href="([^\"]+)"/)[1]

      if :macosx == Platform::IMPL
        MacClipboard.write(pastie_url)
        Kernel.system("open #{pastie_url}")
      end

      return pastie_url
    end
    alias :pst :pastie
  end
end

class Object
  include UtilityBelt::Pastie
end if Object.const_defined? :IRB

# # automate creating pasties
%w{platform net/http mac_clipboard}.each {|lib| require lib}
class Object
  def pastie(stuff_to_paste = nil)
    stuff_to_paste ||= MacClipboard.read if :macosx == Platform::IMPL
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

# automate creating pasties
class Object
  if :macosx == Platform::IMPL
    def pastie
      pastie_url = Net::HTTP.post_form(URI.parse("http://pastie.caboo.se/pastes/create"),
                                       {"paste_parser" => "ruby",
                                        "paste[authorization]" => "burger",
                                        "paste[body]" => MacClipboard.read}).body.match(/href="([^\"]+)"/)[1]
      MacClipboard.write(pastie_url)
      system("open #{pastie_url}")
      pastie_url
    end
    alias :pst :pastie
  end
end

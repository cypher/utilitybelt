#!/usr/bin/env ruby
%w{rubygems platform cgi mac_clipboard}.each {|library| require library}

class Object
  if :macosx == Platform::IMPL
    def google(search_term = nil)
      search_term ||= MacClipboard.read
      if search_term.empty?
        puts "Usage: google search_term_without_spaces           (Unix command line only)"
        puts "       google 'search term with spaces'            (Unix or IRB)"
        puts "       google                                      (Unix or IRB)"
        puts "              (if invoking without args, must have text in clipboard)"
      else
        system("open http://google.com/search?q=#{CGI.escape(search_term)}")
      end
    end
  end
end

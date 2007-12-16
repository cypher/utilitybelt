# This started as my (Giles Bowkett's) .irbrc file, turned into a recipe on IRB for the Pragmatic Programmers,
# and soon became a scrapbook of cool code snippets from all over the place. All the RDoc lives in the README.
# Check that file for usage information, authorship, copyright, and extensive details. You can also find a
# nice, HTMLified version of the README content at http://utilitybelt.rubyforge.org.

UTILITY_BELT_IRB_STARTUP_PROCS = {}

%w{rubygems
   platform
   wirble
   net/http
   tempfile}.each {|library| require library}
%w{init colorize}.each {|message| Wirble.send(message)}
%w{mac_clipboard
   is_an
   pastie
   themes
   irb_verbosity_control
   rails_verbosity_control
   command_history
   not
   language_greps
   rails_finder_shortcut
   amazon_upload_shortcut
   irb_options
   interactive_editor
   string_to_proc
   symbol_to_proc
   hash_math
   with}.each {|internal_library| require internal_library}

# default: dark background
UtilityBelt::Themes.background(:dark)

# Called when the irb session is ready, after any external libraries have been loaded. I can't
# remember why I did this. it might be a cargo cult thing.
IRB.conf[:IRB_RC] = lambda do
  UTILITY_BELT_IRB_STARTUP_PROCS.each {|symbol, proc| proc.call}
end

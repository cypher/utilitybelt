# Giles Bowkett, Greg Brown, and several audience members from Giles' Ruby East presentation.
class InteractiveEditor
  attr_accessor :editor
  def initialize(editor = :vim)
    @editor = editor.to_s
    if @editor == "mate"
      @editor = "mate -w"
    end
  end
  def edit_interactively
    unless @file
      @file = Tempfile.new("irb_tempfile")
    end
    system("#{@editor} #{@file.path}")
    Object.class_eval(`cat #{@file.path}`)
    rescue Exception => error
      puts error
  end
end

class Object
  def edit_interactively(editor)
    unless IRB.conf[:interactive_editors] && IRB.conf[:interactive_editors][editor]
      IRB.conf[:interactive_editors] ||= {}
      IRB.conf[:interactive_editors][editor] = InteractiveEditor.new(editor)
    end
    IRB.conf[:interactive_editors][editor].edit_interactively
  end

  def vi
    edit_interactively(:vim)
  end

  def mate
    edit_interactively(:mate)
  end

  def emacs
    edit_interactively(:emacs)
  end
end


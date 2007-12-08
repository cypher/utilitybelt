# Giles Bowkett, Greg Brown, and several audience members from Giles' Ruby East presentation.
class InteractiveEditor
  attr_accessor :editor
  def initialize(editor = :vim)
    @editor = editor.to_s
    if @editor == "mate"
      @editor = "mate -w"
    end
  end
  def edit
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
  def edit(editor)
    unless IRB.conf[:interactive_editors] && IRB.conf[:interactive_editors][editor]
      IRB.conf[:interactive_editors] ||= {}
      IRB.conf[:interactive_editors][editor] = InteractiveEditor.new(editor)
    end
    IRB.conf[:interactive_editors][editor].edit
  end

  def vi
    edit(:vim)
  end

  def mate
    edit(:mate)
  end

  def emacs
    edit(:emacs)
  end
end


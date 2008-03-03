class Hash
  alias :+ :merge
  def -(other)
    difference = if other.is_a? Hash
      reject { |k,v| other[k] == v }
    else
      reject { |k,v| k == other }
    end
  end
end

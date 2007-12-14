class Hash
  alias :+ :merge
  def -(other_hash)
    other_hash.each do |key, value|
      self.delete(key) if self[key] == value
    end
    self
  end
end
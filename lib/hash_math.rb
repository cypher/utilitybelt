class Hash
  alias :+ :merge
  def -(other_hash)
    raise ArgumentError unless other_hash.is_a? Hash
    other_hash.each do |key, value|
      self.delete(key) if self[key] == value
    end
    self
  end
end
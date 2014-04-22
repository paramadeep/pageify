class String
  def lspace
    self[/\A */].size
  end

  def strip_quotes
    self.gsub("\"", "")
  end
end

class String
  def lspace
    self[/\A */].size
  end

  def name
    self.lstrip.split(":").first
  end

  def selector
    self.split(":").last
  end
end





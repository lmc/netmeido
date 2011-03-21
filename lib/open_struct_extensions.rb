module OpenStructExtensions
  def [](key)
    send(key)
  end
end
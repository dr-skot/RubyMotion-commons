module Observable

  def add_observer(o)
    @observers ||= []
    @observers << o;
  end

  def remove_observer(o)
    @observers.delete(o) if @observers
  end

  def notify_observers(notification)
    @observers.each {|o| o.notify(self, notification)}
  end

end

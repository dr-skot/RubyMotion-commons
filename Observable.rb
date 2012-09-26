module Observable

  def add_observer(o)
    observers << o;
  end

  def remove_observer(o)
    observers.delete(o) if @observers
  end

  def fire(notification)
    notify_observers(notification)
  end

  def notify_observers(notification)
    observers.each {|o| o.notify(self, notification)}
    callback(notification).each { |block| block.call }
  end

  def when(notification, &block)
    callback(notification) << block
  end
  
  def callback(notification)
    @callback ||= {}
    @callback[notification] ||= []
  end

  def observers
    @observers ||= []
  end

end

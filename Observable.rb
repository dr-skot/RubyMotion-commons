module Observable

  # classic observer pattern

  def add_observer(o)
    observers << o;
  end

  def remove_observer(o)
    observers.delete(o) if @observers
  end

  def notify_observers(notification)
    observers.each {|o| o.notify(self, notification)}
    callbacks(notification).each_value { |block| block.call }
  end

  def observers
    @observers ||= []
  end

  def fire(notification)
    notify_observers(notification)
  end

  # when pattern

  def when(notification, &block)
    tag = new_tag
    callbacks(notification)[tag] = block
    notifications_for_tag[tag] = notification
  end

  def remove_listener(tag)
    notification = notifications_for_tag[tag]
    callbacks(notification).delete(tag) if notification
  end

  def notifications_for_tag
    @notifications_for_tag ||= {}
  end
  
  def callbacks(notification)
    @callbacks ||= {}
    @callbacks[notification] ||= {}
  end

  # TODO would be safer if this wasn't predictable
  def new_tag
    @next_tag ||= 0
    @next_tag += 1
  end

end

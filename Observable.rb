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
  alias_method :fire, :notify_observers

  def observers
    @observers ||= []
  end


  # when pattern

  def when(notification, &block)
    tag = new_tag
    callbacks(notification)[tag] = block
    notification_for_tag[tag] = notification
  end

  def remove_listener(tag)
    notification = notification_for_tag[tag]
    callbacks(notification).delete(tag) if notification
  end

  def notification_for_tag
    @notification_for_tag ||= {}
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

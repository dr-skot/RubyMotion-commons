class Time
  
  def start_of_day
    secs_to_subtract = sec + min * 60 + hour * 60 * 60
    self - secs_to_subtract
  end

  def same_day?(other_time)
    day_diff(other_time) == 0
  end

  def day_diff(other_time)
    other_time = other_time.getlocal(self.utc_offset) # first coerce timezone
    day_diff = (other_time.start_of_day - self.start_of_day).round / (24 * 60 * 60)
  end

  # TODO i18n, possibly using NSTimeFormatter

  def when_string
    day_diff = day_diff(Time.now)

    #p "day_diff: #{day_diff}"

    if day_diff == 0
      strftime("%-l:%M %P") # eg, "1:35 pm"

    elsif day_diff == -1 
      "Tomorrow"
      
    elsif day_diff == 1
      "Yesterday"

    elsif day_diff <= 7 
      strftime("%A") # eg, "Monday"

    else
      strftime("%-m/%-e/%y") # eg, 5/30/1968

    end

  end
    
end

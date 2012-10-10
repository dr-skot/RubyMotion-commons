require "./Time.rb"

describe "Time" do
  
  it "supports start_of_day" do
    t = Time.now.start_of_day
    t.hour.should == 0
    t.min.should == 0
    t.sec.should == 0
    t += 60 * 60 * 5 + 138
    t = t.start_of_day
    t.hour.should == 0
    t.min.should == 0
    t.sec.should == 0
  end
  
  it "supports same_day?" do
    t = Time.now
    a = t
    b = a + (23 - a.hour) * 60 * 60
    a.same_day?(b).should == true
    b = a - a.hour * 60 * 59
    a.same_day?(b).should == true
  end

  it "knows when they aren't the same day" do
    t = Time.now
    a = t
    b = a + (25 - a.hour) * 60 * 60
    a.same_day?(b).should == false
    b = a - (a.hour + 1) * 60 * 60
    a.same_day?(b).should == false
  end

  it "supports same_day? across timezones" do
    t = Time.now
    a = t.getlocal(0)
    b = a + (23 - a.hour) * 60 * 60
    b = b.getlocal(12)
    b = a - a.hour * 60 * 59
    b = b.getlocal(12)
    a.same_day?(b).should == true
  end

  it "knows when they aren't the same day across timezones" do
    t = Time.now
    a = t.getlocal(0)
    b = a + (25 - a.hour) * 60 * 60
    b = b.getlocal(12)
    a.same_day?(b).should == false
    b = a - (a.hour + 1) * 60 * 60
    b = b.getlocal(12)
    a.same_day?(b).should == false
  end

  it "uses time as when_string when today" do
    t = Time.now
    a = t
    b = a - (a.hour-1) * 60 * 59
    b.when_string.should == b.strftime("%-l:%M %P")
  end

  it "uses Yesterday as when_string when yesterday" do
    t = Time.now
    a = t
    b = a - (a.hour + 1) * 60 * 60
    b.when_string.should == "Yesterday"
  end

  it "uses dow as when_string when 2 days ago" do
    t = Time.now
    a = t
    b = a - 2 * 24 * 60 * 60
    b.when_string.should == b.strftime("%A")
  end

  it "uses %m/%e/%y as when_string when 8 days ago" do
    t = Time.now
    a = t
    b = a - 8 * 24 * 60 * 60
    b.when_string.should == b.strftime("%-m/%-e/%y")
  end

end

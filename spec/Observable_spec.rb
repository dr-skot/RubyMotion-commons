require './Observable.rb'

class O
  include Observable
end

describe "Observable" do

  before do
    @o = O.new
  end

  it "runs callback when 'when' event is fired" do
    @fired = false
    @o.when(:event) do
      @fired = true
    end
    @o.fire(:event)
    @fired.should == true
  end

  it "does not run callback when other events are fired" do
    @fired = false
    @o.when(:event) do
      @fired = true
    end
    @o.fire(:otherevent)
    @fired.should == false
  end

end

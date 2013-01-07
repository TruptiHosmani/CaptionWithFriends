require 'spec_helper'

describe "contests/index" do
  before(:each) do
    assign(:contests, [
      stub_model(Contest,
        :user => nil,
        :title => "Title"
      ),
      stub_model(Contest,
        :user => nil,
        :title => "Title"
      )
    ])
  end

  it "renders a list of contests" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end

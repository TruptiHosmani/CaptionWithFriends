require 'spec_helper'

describe "contests/new" do
  before(:each) do
    assign(:contest, stub_model(Contest,
      :user => nil,
      :title => "MyString"
    ).as_new_record)
  end

  it "renders new contest form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => contests_path, :method => "post" do
      assert_select "input#contest_user", :name => "contest[user]"
      assert_select "input#contest_title", :name => "contest[title]"
    end
  end
end

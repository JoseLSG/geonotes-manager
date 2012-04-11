require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the NotesHelper. For example:
#
# describe NotesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe NotesHelper do
  describe "tag_links" do
    it "should return links based on the passed Tag objects" do   
      links = helper.tag_links([Tag.new(:name => "test1"), Tag.new(:name => "test2")])
      links.should have_selector('a', :content => "test1")
      links.should have_selector('a', :content => "test2")
    end
  end
end

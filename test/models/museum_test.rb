require 'test_helper'

class MuseumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "required" do
    cur_museum = museums(:howard)

    cur_museum[:name] = nil
    refute cur_museum.valid?
    cur_museum[:name] = "The Howard"

    cur_museum[:website] = nil
    refute cur_museum.valid?
    cur_museum[:website] = "www.website.com"

    assert cur_museum.valid?
  end


  test "uniqueness" do
    cur_museum_attrs = museums(:howard).attributes
    cur_museum = Museum.new(cur_museum_attrs)
    refute cur_museum.valid?
  end

end

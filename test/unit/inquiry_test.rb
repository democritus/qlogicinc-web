require 'test_helper'

class InquiryTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Inquiry.new.valid?
  end
end

require 'test_helper'

class BTextyTest < Test::Unit::TestCase
  context "Initialization"do
    should "require a phone number and pin code" do
      lambda { BTexty.new }.should raise_error
      lambda { BTexty.new('15413063365')}.should raise_error
    end
    
    should "handle various types of number inputs" do
      #Assumes a US phone number length of 10 digits & +1 country code. 
     assert_equal '+15413063355', BTexty.new('15413063355','12345').phone_number
     assert_equal '+15413063355', BTexty.new('541-306-3355','12345').phone_number
     assert_equal '+15413063355', BTexty.new('(541) 306-3355', '12345').phone_number
     assert_equal '+15413063355', BTexty.new('1-541-306-3355', '12345').phone_number
    end
    
    should "keep your pin exactly as you type it" do
     assert_equal '12345', BTexty.new('15413061122', '12345').pin
    end
  end
  
  
end

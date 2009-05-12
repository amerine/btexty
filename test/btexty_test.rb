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
  
  context "Checking for unread messages" do
    setup do
      FakeWeb.register_uri(:get, "http://+15419777188:12341@www.btexty.com:80/api/json/inbox/unread", :string => File.read('test/fixtures/unread.json'))
      @btexty = BTexty.new('+15419777188', 12341)
    end
    
    should "return the number of unread messages as an interger" do
      assert_equal 1, @btexty.unread
    end
  end
  
  context "Getting the list a list messages" do
    setup do 
      FakeWeb.register_uri(:get, "http://+15419777188:12341@www.btexty.com:80/api/json/inbox/index", :string => File.read('test/fixtures/messages.json'))
      @btexty = BTexty.new('+15419777188', 12341)
    end
    
    should "return a list of messages" do
      assert_equal 1, @btexty.messages.size
    end
    
    should "allow you to read each messages attributes" do
      message = @btexty.messages.first
      message.content.should == 'Welcome to btexty! Click on the link we just sent you as text message to activate your account.'
      message.thread.should == '9xknm7nn3icqa3qnqxni0uwaooz6k6uiupbuij7tao38b4ax1o2b57dsx0onphx5'
      message.sender.should == '+18579989143'
      message.recipients.should == '+15419777188'
      message.sender_name.should == 'btexty'
      message.recipients_names.should == 'me'
      message.is_read.should == false
      message.wall.should == false
      message.created_on.should == '2009-05-11 22:32:43.643042'
      message.id.should == 'agZtb3dhbGxyIQsSB0FjY291bnQYAgwLEgxTaG9ydE1lc3NhZ2UY_50CDA'
    end
  end
  
end

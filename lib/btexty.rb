require 'rubygems'
gem 'httpary'
require 'httparty'
require File.dirname(__FILE__) + '/btexty/data'

class BTexty
  include HTTParty
  base_uri "http://www.btexty.com/api/"
  
  def initialize(phone_number, pin)
    @phone_number, @pin = phone_number, pin
  end
  
  def get(path, options={})
    options.merge!({:basic_auth => {:username => @phone_number, :password => @pin}, 
      :method => 'xml'})
    self.class.get("#{options[:method]}/#{path}")
  end
  
  def unread
    get('inbox/unread')
  end
end

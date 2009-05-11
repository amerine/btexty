require 'rubygems'
gem 'httparty'
require 'httparty'
require File.dirname(__FILE__) + '/btexty/data'

class BTexty
  include HTTParty
  base_uri "http://www.btexty.com/api"
  attr_accessor :phone_number, :pin
  
  def initialize(phone_number, pin)
    phone_number.gsub!(/\W/,'')
    phone_number.gsub!(/\A/, '1') if phone_number.length == 10
    phone_number.gsub!(/\A/,'+')
    @phone_number, @pin = phone_number, pin
  end
  
  def get(path, options={})
    options.merge!({:basic_auth => {:username => @phone_number, :password => @pin}, 
      :method => 'xml'})
    self.class.get("/#{options[:method]}/#{path}")
  end
  
  def unread
    get('inbox/unread')
  end
end

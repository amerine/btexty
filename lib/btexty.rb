require 'rubygems'
gem 'httparty'
require 'httparty'
require File.dirname(__FILE__) + '/btexty/data'

class BTexty
  include HTTParty
  format :json
  
  attr_accessor :phone_number, :pin, :method
  
  def initialize(phone_number, pin, method='json')
    clean_phone_number(phone_number)
    @phone_number, @pin, @method = phone_number, pin, method
  end
  
  def get(path, options={})
    options.merge!({:basic_auth => {:username => @phone_number, :password => @pin}, 
      :method => @method})
    self.class.get("http://www.btexty.com/api/#{options[:method]}/#{path}", options)
  end
  
  def unread
    get('inbox/unread')['response']['body']['unread']
  end
  
  def messages
    get('inbox/index')
  end
  
  private
  
  def clean_phone_number(phone_number)
    phone_number.gsub!(/\W/,'')
    phone_number.gsub!(/\A/, '1') if phone_number.length == 10
    phone_number.gsub!(/\A/,'+')
    phone_number
  end
end

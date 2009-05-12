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
    return_messages = []
    messages = get('inbox/index')['response']['body']['messages']
    messages.each do |message|
      process_message = Message.new
      process_message.content = message['message']['content']
      process_message.thread = message['message']['thread']
      process_message.sender = message['message']['sender']
      process_message.recipients = message['message']['recipients']
      process_message.sender_name = message['message']['sender_name']
      process_message.recipients_names = message['message']['recipients_names']
      process_message.is_read = message['message']['is_read']
      process_message.wall = message['message']['wall']
      process_message.created_on = message['message']['created_on']
      process_message.id = message['message']['id']
      return_messages << process_message
    end
    return_messages
  end
  
  private
  
  def clean_phone_number(phone_number)
    phone_number.gsub!(/\W/,'')
    phone_number.gsub!(/\A/, '1') if phone_number.length == 10
    phone_number.gsub!(/\A/,'+')
    phone_number
  end
end

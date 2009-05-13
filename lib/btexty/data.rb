class BTexty
  
  class Message
    attr_accessor :content, :thread, :sender, :recipients, :sender_name
    attr_accessor :recipients_names, :is_read, :wall, :created_on, :id
    
    def process_message(message)
      self.content = message['message']['content']
      self.thread = message['message']['thread']
      self.sender = message['message']['sender']
      self.recipients = message['message']['recipients']
      self.sender_name = message['message']['sender_name']
      self.recipients_names = message['message']['recipients_names']
      self.is_read = message['message']['is_read']
      self.wall = message['message']['wall']
      self.created_on = message['message']['created_on']
      self.id = message['message']['id']
    end
    
    def send
      self.class.post('http://www.btexty.com/api/json/send')      
    end
  end
  
end
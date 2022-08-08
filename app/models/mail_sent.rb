class MailSent < ApplicationRecord
   
   belongs_to :user
   belongs_to :message
   
   validates :recipient, presence:true
   
   validates :user_id, presence:true
   
   validates :message_id, presence:true
   
   validates :title, presence:true
   
   # validates :content, presence:true
    
end
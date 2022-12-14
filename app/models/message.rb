class Message < ApplicationRecord
    belongs_to :user
    has_many :mail_sents
    
    has_rich_text :content
    
    validates :title, presence:true, 
                        length: {minimum: 6, maximum: 100}
                        
    validates :content, presence:true, 
                        length: {minimum: 10, maximum: 3000}
    
end

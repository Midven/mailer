class MailSentMailer < ApplicationMailer
    
    def send_mail(object)
        
        @object = object
        @object_count = @object.class.count
        
        mail from: object.user.email, to: object.recipient , subject: object.title
    
    end
    
end

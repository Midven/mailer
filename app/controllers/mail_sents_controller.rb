class MailSentsController < ApplicationController


    def index
        @userconnected = current_user
        @user_id = @userconnected.id
        @message_id = params[:message_id]
        
        @mails = MailSent.where(user_id: @user_id, message_id: @message_id)
    end
    
    def new
        # debugger
        @message_id = params[:message_id]
        @message = Message.find(@message_id)
        @mail = MailSent.new
        
        puts '----------------------'
        puts params
        puts '----------------------'
    end

    def create
        @message_id = params[:message_id]
        @message = Message.find(@message_id)
        
        puts @recipients = mail_params[:recipient].to_s.split
        
        
        @recipients.each do |recipient|
            @validation_mail = recipient =~ URI::MailTo::EMAIL_REGEXP
            
            puts '^^^^^^^^^^^^^^^^^^'
            puts @validation_mail
            puts '^^^^^^^^^^^^^^^^^^'

            if @validation_mail == nil
                flash[:danger] = "Some mails are invalid"
                redirect_to new_message_mail_sent_path and return
            end
        end
        
        
        
        @recipients.each do |recipient|
        
            @mail = MailSent.new(mail_params)
            @mail.user_id = 1
            @mail.message_id = @message_id
            @mail.recipient = recipient
            @mail.save
            
            if @recipients.last == recipient
                
                if @mail.save
                    MailSentMailer.send_mail(@mail).deliver_now
                    
                    redirect_to message_mail_sents_path
                    
                    flash[:notice] = "Your mail was sended successfully."
                else
                    render 'new'
                end
            else
                MailSentMailer.send_mail(@mail).deliver_now
            end
        end
        
        puts '----------------------'
        puts params
        puts @recipients
        puts '----------------------'


    end
    
    def show
        @mail = MailSent.find(params[:id])
    end


    private
        
        def mail_params
            params.require(:mail_sent).permit(:title, :content, :recipient)
        end
        
        # def is_email_valid? email
        #     email =~ URI::MailTo::EMAIL_REGEXP
        # end


end

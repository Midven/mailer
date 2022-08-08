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
        
        
        @mail = MailSent.new(mail_params)
        @mail.user_id = 1
        @mail.message_id = @message_id
        
        puts '----------------------'
        puts params
        puts '----------------------'


        if @mail.save
            redirect_to message_mail_sents_path
            
            flash[:notice] = "Article was created successfully."
        else
            render 'new'
        end
    end
    
    def show
        @mail = MailSent.find(params[:id])
    end


    private
        
        def mail_params
            params.require(:mail_sent).permit(:title, :content, :recipient)
        end


end

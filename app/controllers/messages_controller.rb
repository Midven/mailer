class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]
  before_action :require_user
  before_action :require_same_user, only: [:show, :edit, :update, :destroy]

  # GET /messages or /messages.json
  def index
    @userconnected = current_user
    @id = @userconnected.id
    puts "-------- #{@messageId} --------"
    
    @messages = Message.where(user_id: @id)
  end

  # GET /messages/1 or /messages/1.json
  def show
    puts "--------------------------------------"
    puts "--------------------------------------"
    puts "--------------------------------------"
    puts @messageId = params[:id]
    puts @messageId
    puts "--------------------------------------"
    puts "--------------------------------------"
  end

  # GET /messages/new
  def new
    @message = Message.new
    puts '----------------------'
    puts params
    puts '----------------------'
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages or /messages.json
  def create
    @message = Message.new(message_params)
    puts '----------------------'
    puts params[:id]
    puts '----------------------'
    @message.user = current_user

    respond_to do |format|
      if @message.save
        format.html { redirect_to message_url(@message), notice: "Message was successfully created." }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to message_url(@message), notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:title, :content)
    end
    
    def require_same_user
        if current_user != @message.user
          flash[:alert] = "You can only edit or delete your own article"
          redirect_to @message
        end
    end
    
end

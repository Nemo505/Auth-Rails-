class ChatBotController < ApplicationController
    def index
        user_message = params[:message]

        # Call the send_message method with the user's message
        @bot_response = send_message(user_message)

        # Inform the client to scroll to the top
        @scroll_to_top = true if user_message.present?
        
    end
    
    def send_message(user_message)
        # Handle sending messages and receiving responses here
        # You can use params[:message] to get the user's message
    
        # Simulate a response from the bot for testing
        bot_response = "I received: #{params[:message]}"
    
        # render json: { bot_response: bot_response }
    end
      
end

class ViberWebhookController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new

  end

  def receive
    user_message = params[:message]

    # Call the send_message method with the user's message
    bot_response = send_message(user_message)

    # Render the response as JSON
    render json: { bot_response: bot_response }
  end

  private

  def send_message(user_message)
    # Handle sending messages and receiving responses here
    # You can use user_message to get the user's message

    # Simulate a response from the bot for testing
    bot_response = "I received: #{user_message}"

    bot_response
  end
end

  
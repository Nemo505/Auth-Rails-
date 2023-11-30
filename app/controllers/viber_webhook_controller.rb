require 'openai'
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
    # Use your OpenAI API key here
    openai_client = OpenAI::Client.new(api_key: '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' , default_engine: "ada")

    
    response = openai_client.completions(prompt: user_message, max_tokens: 30)
     # Extract the generated text from the response
    bot_response = response['choices'][0]['text']

    bot_response
  end
end

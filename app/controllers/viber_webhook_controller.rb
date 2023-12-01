require 'openai'
class ViberWebhookController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
  end

  def receive
    user_message = params[:message]
    user_image = params[:image]

    if user_image.present? && user_image == "generate"
      # Call DALL-E API for image generation
      generated_image = generate_image(user_message)

      # Render the generated image URL as JSON
      render json: { generated_image: generated_image }
    else
      # Call the send_message method with the user's message
      bot_response = send_message(user_message)

      # Render the response as JSON
      render json: { bot_response: bot_response }
    end

  end

  private

  # openai_client = OpenAI::Client.new(api_key: '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' , default_engine: "ada")
  def send_message(user_message)
    # Use your OpenAI API key here
    client = OpenAI::Client.new(access_token: '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')
  
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo-1106", # Required.
        messages: [{ role: "user", content: user_message}], # Required.
    })

    # Extract the generated text from the response
    bot_response = response.dig("choices", 0, "message", "content")
    bot_response
  end

  def generate_image(prompt)

    client = OpenAI::Client.new(access_token: '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')

    response = client.images.generate(parameters: { prompt: prompt, size: "256x256" })

    # Placeholder for the actual DALL-E API integration
    generated_image = response.dig("data", 0, "url")

    generated_image
  end

end

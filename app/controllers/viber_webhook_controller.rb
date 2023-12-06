require 'openai'
class ViberWebhookController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
  end

  def receive
    user_message = params[:message]
    user_image = params[:image]
    user_audio = params[:audio]

    if user_image.present? && user_image == "generate"
      # Call DALL-E API for image generation
      generated_image = generate_image(user_message)

      # Render the generated image URL as JSON
      render json: { generated_image: generated_image }
    elsif user_audio.present? && user_audio == "speak"
      # Call a method to process the audio message
      processed_audio = process_audio(user_message)

      # Render the processed audio data as JSON
      render json: { processed_audio: processed_audio }
    else
      # Call the send_message method with the user's message
      bot_response = send_message(user_message)

      # Render the response as JSON
      render json: { bot_response: bot_response }
    end
  end

  private

  def send_message(user_message)
    # Use OpenAI API key here
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

  def process_audio(user_audio)
    client = OpenAI::Client.new(access_token: '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')
    response = client.audio.speech(
      parameters: {
        model: "tts-1",
        input: user_audio,
        voice: "alloy"
      }
    )

    # Define the file path
    audio = Rails.root.join('public', 'demo.mp3')

    # # Write the audio content to the file
    File.binwrite(audio, response)

    # Get the relative path from the 'public' directory
    relative_path = Pathname.new('demo.mp3')

    # Generate the localhost URL
    processed_audio = "http://localhost:3000/#{relative_path}"

    # Return the file path
    processed_audio
  end


end

class ViberWebhookController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    def receive
      # Handle incoming Viber messages here
      # Parse incoming JSON payload from Viber
      data = JSON.parse(request.body.read)
  
      # Implement logic to handle different events (message, join, leave, etc.)
      # Example: reply to a message
      if data['event'] == 'message'
        sender_id = data['sender']['id']
        message_text = data['message']['text']
  
        # Implement your response logic here
        response_text = "You said: #{message_text}"
  
        # Send the response back to the user
        send_message(sender_id, response_text)
      end
  
      head :ok
    end
  
    private
  
    def set_viber_service
        @viber_service = ViberService.new('520017e61327e172-8ce91a4a8b8c03b1-60aa8e241d9bf01c')
      end
    
      def send_message(receiver_id, text)
        # Use the Viber API to send a message
        result = @viber_service.send_message(receiver_id, text)
    
        # Handle the result if needed
        if result.key?('error')
          Rails.logger.error("Viber API error: #{result['error']}")
        else
          Rails.logger.info('Message sent successfully!')
        end
    end
  end
  
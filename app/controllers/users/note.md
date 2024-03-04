

    response.headers['Content-Type'] = 'text/event-stream'
    response.headers['Last-Modified'] = Time.now.httpdate # Helps prevent bug from streaming output
    sse = SSE.new(response.stream, event: 'meessage') # Variable for Server Sent Event
    client = OpenAI::Client.new(access_token: ENV['OPENAI_ACCESS_TOKEN'])


    begin
      client.chat( # Calls the chat API
        parameters: {
          model: 'gpt-3.5-turbo',
          messages: [{ role: 'user', content: params[:prompt] }], # Prompt to pass as a query parameter
          stream: proc do |chunk| # Creates a procedure to handle incoming steam from API
            content = chunk.dig('choices', 0, 'delta', 'content') # Fetches content from API response
            return if content.nil? # Return from procedure once theres no more content
            sse.write(object({ message: content })) # Writes the response to the message event
          end
        }
      )
    ensure
      sse.close # Makes sure it closes
    end

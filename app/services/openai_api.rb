class OpenaiApi
  def initialize
    @client = OpenAI::Client.new
  end

  def generate_content(text)
    prompt = "Generate a lesson abstract for this #{text}" # Replace with my prompt
    response = @client.chat(parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: prompt}]
    })
    @content = response["choices"].first["message"]["content"]
  end
end

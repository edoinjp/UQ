class generate_images
  def initialize
    @client = OpenAI::Client.new
  end

  def generate_images(text)
    prompt = "Convert this text to images: #{text}"
    response = @client.chat(parameters: {
      model: "dall-e-3",
      messages: [{ role: "user", content: prompt}]
  })
  @content = response["choices"].first["message"]["content"]
  return @content
end

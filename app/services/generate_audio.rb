class generate_audio
  def initialize
    @client = OpenAI::Client.new
  end

  def generate_audio(text)
    prompt = "Convert this text to audio: #{text}"
    response = @client.chat(parameters: {
      model: "tts-1",
      voice: "Nova"
      messages: [{ role: "user", content: prompt}]
  })
  @content = response["choices"].first["message"]["content"]
  return @content
end

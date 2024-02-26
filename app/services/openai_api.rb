class OpenaiApi
  def initialize
    @client = OpenAI::Client.new
  end

  def generate_content(text, style:)
    prompt = "Generate a #{style} lesson abstract for this #{text}" # Replace with my prompt
    response = @client.chat(parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: prompt}]
    })
    @content = response["choices"].first["message"]["content"]
    @content
  end

  # Image generation
  def generate_images(text)
    prompt = "Convert this text to images: #{text}"
    response = @client.images.generate(parameters: {
      prompt: prompt, size: "256x256"
    })
    image_url = response["data"][0]["url"]
    image = URI.open(image_url)
    image
  end

  # Audio generation
  def generate_audio(text, voice: 'nova')

    prompt = "You are a teacher, you will be give a lesson, generate the text what you would tell the students as if you were teaching them the lesson content. Your output should only be the generated text"
    response = @client.chat(parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: prompt,
      role: "user", content: "The give lecture content is: #{text}"}]
    })
    lecture_content = response["choices"].first["message"]["content"]

    response = @client.audio.speech(parameters: {
      model: "tts-1",
      voice: voice,
      input: lecture_content
    })
  end

  # Kinesthetic generation
  def generate_content(text, style:)
    prompt = " Create a #{style} lesson activity based on the following content: #{text}, the activity should be engaging and interactive and can be done at home by themselves at home as this is a flipped classroom style learning. The output should be the activity and the lesson content."
    response = @client.chat(parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: prompt}]
    })
    @content = response["choices"].first["message"]["content"]
    @content
  end
end

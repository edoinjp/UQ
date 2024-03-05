require "open-uri"

class OpenaiApi
  def initialize
    @client = OpenAI::Client.new
  end

  def generate_response(question)
     # prompt = "Generate a #{style} lesson abstract for this #{text}"
      response = @client.chat(parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: question}]
      })
      response["choices"].first["message"]["content"]
  end

  def generate_content(text, style:)

      prompt = "Generate a #{style} lesson abstract for this #{text}"
      response = @client.chat(parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: prompt}]
      })
      response["choices"].first["message"]["content"]

  end

  def generate_images(text)
    prompt = "Convert this text to images: #{text}"
    response = @client.images.generate(parameters: {
      prompt: prompt, size: "256x256"
    })
    image_url = response["data"][0]["url"]
    open_uri(image_url)
  end

  def generate_audio(text, voice: 'nova')
      prompt = "You are a teacher, you will be give a lesson, generate the text what you would tell the students as if you were teaching them the lesson content. Your output should only be the generated text"
      response = @client.chat(parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: prompt,
        role: "user", content: "The give lecture content is: #{text}"}]
      })
      lecture_content = response["choices"].first["message"]["content"]

      @client.audio.speech(parameters: {
        model: "tts-1",
        voice: voice,
        input: lecture_content
      })
  end

  # Assuming this method is for generating kinesthetic content specifically.
  def generate_kinesthetic_content(text)
      prompt = "Create a kinesthetic speaking activity that a child can do at home in 10 minutes. Add a clear explanation of how to do it with simple vocabulary based on the following content: #{text}"
      response = @client.chat(parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: prompt}]
      })
      response["choices"].first["message"]["content"]
  end

  private

  def open_uri(url)
    URI.open(url)
  end
end

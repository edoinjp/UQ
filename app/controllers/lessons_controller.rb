class LessonsController < ApplicationController
  def index
    @lessons = Lesson.all
  end

  def styled_params
    params.require(:styled_lesson).permit(:style, :file)
  end
end

class ResponsesController < ApplicationController
  before_action :set_lesson, only: :index

  def index
    @active_tab = "responses"
    @classroom = @lesson.classroom
    # to dsiplay it on side bar
    @active_tab = 'responses'
    # Only Teachers can access this page
    #  Gather all responses
    @responses = policy_scope(Response)
    # @responses = policy_scope(Response.includes(:choice).where(choices: { question_id: @lesson.questions.ids }))

    # Get all students who participated in the lesson
    @students = @lesson.classroom.students

    # Creates the class response score totals
    visual_l1_total = 0
    aural_l1_total = 0
    reading_l1_total = 0
    kinesthetic_l1_total = 0

    visual_l2_total = 0
    aural_l2_total = 0
    reading_l2_total = 0
    kinesthetic_l2_total = 0

    visual_l3_total = 0
    aural_l3_total = 0
    reading_l3_total = 0
    kinesthetic_l3_total = 0

    visual_l4_total = 0
    aural_l4_total = 0
    reading_l4_total = 0
    kinesthetic_l4_total = 0

    visual_student_total = 0
    aural_student_total = 0
    reading_student_total = 0
    kinesthetic_student_total = 0


    @students.each do |student|

      # Lesson 1 Totals Filtered by Style
      if student.learning_style == 'visual'
        visual_l1_total += student.score.values.slice(0)
        visual_student_total += 1
      elsif student.learning_style == 'aural'
        aural_l1_total += student.score.values.slice(0)
        aural_student_total += 1
      elsif student.learning_style == 'reading'
        reading_l1_total += student.score.values.slice(0)
        reading_student_total += 1
      else
        kinesthetic_l1_total += student.score.values.slice(0)
        kinesthetic_student_total += 1
      end

      # Lesson 2 Totals Filtered by Style
      if student.learning_style == 'visual'
        visual_l2_total += student.score.values.slice(1)
      elsif student.learning_style == 'aural'
        aural_l2_total += student.score.values.slice(1)
      elsif student.learning_style == 'reading'
        reading_l2_total += student.score.values.slice(1)
      else
        kinesthetic_l2_total += student.score.values.slice(1)
      end

      # Lesson 3 Totals Filtered by Style
      if student.learning_style == 'visual'
        visual_l3_total += student.score.values.slice(2)
      elsif student.learning_style == 'aural'
        aural_l3_total += student.score.values.slice(2)
      elsif student.learning_style == 'reading'
        reading_l3_total += student.score.values.slice(2)
      else
        kinesthetic_l3_total += student.score.values.slice(2)
      end

      # Lesson 4 Totals Filtered by Style
      if student.learning_style == 'visual'
        visual_l4_total += student.score.values.slice(3)
      elsif student.learning_style == 'aural'
        aural_l4_total += student.score.values.slice(3)
      elsif student.learning_style == 'reading'
        reading_l4_total += student.score.values.slice(3)
      else
        kinesthetic_l4_total += student.score.values.slice(3)
      end

    end

    # Creates the class response score averages
    visual_l1_avg = visual_l1_total / visual_student_total
    aural_l1_avg = aural_l1_total / aural_student_total
    reading_l1_avg = reading_l1_total / reading_student_total
    kinesthetic_l1_avg = kinesthetic_l1_total / kinesthetic_student_total

    visual_l2_avg = visual_l2_total / visual_student_total
    aural_l2_avg = aural_l2_total / aural_student_total
    reading_l2_avg = reading_l2_total / reading_student_total
    kinesthetic_l2_avg = kinesthetic_l2_total / kinesthetic_student_total

    visual_l3_avg = visual_l3_total / visual_student_total
    aural_l3_avg = aural_l3_total / aural_student_total
    reading_l3_avg = reading_l3_total / reading_student_total
    kinesthetic_l3_avg = kinesthetic_l3_total / kinesthetic_student_total

    visual_l4_avg = visual_l4_total / visual_student_total
    aural_l4_avg = aural_l4_total / aural_student_total
    reading_l4_avg = reading_l4_total / reading_student_total
    kinesthetic_l4_avg = kinesthetic_l4_total / kinesthetic_student_total

    # Class Averages Chart
    @chart_data_all = [
      {name: 'Visual', data: {'Ice Breakers': visual_l1_avg, 'Oral Communication II': visual_l2_avg, 'Social Science': visual_l3_avg, 'Language Arts': visual_l4_avg}},
      {name: 'Aural', data: {'Ice Breakers': aural_l1_avg, 'Oral Communication II': aural_l2_avg, 'Social Science': aural_l3_avg, 'Language Arts': aural_l4_avg}},
      {name: 'Reading', data: {'Ice Breakers': reading_l1_avg, 'Oral Communication II': reading_l2_avg, 'Social Science': reading_l3_avg, 'Language Arts': reading_l4_avg}},
      {name: 'Kinesthetic', data: {'Ice Breakers': kinesthetic_l1_avg, 'Oral Communication II': kinesthetic_l2_avg, 'Social Science': kinesthetic_l3_avg, 'Language Arts': kinesthetic_l4_avg}}
    ]

  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end

end

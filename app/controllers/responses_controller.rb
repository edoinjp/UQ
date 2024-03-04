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
    students = @lesson.classroom.students

    # Initialize @student_scores as an empty hash
    @student_scores = {}

    # For each student, fetch the correct answer count from the database
    students.each do |student|
      lesson_score = student.score[@lesson.title] # Assuming 'title' is the lesson title
      if lesson_score.present?
        @student_scores[student] = {
          correct_count: lesson_score, # Assign the score value directly
          # total_questions: @lesson.questions.count Use this later when 5 total questions are available
          total_questions: 5
        }
      else
        # Handle the case where the score for the lesson is not present for the student
        @student_scores[student] = {
          correct_count: 0,
          # total_questions: @lesson.questions.count Use this later when 5 total questions are available
          total_questions: 5
        }
      end
    end

    # Creates quiz scores for each seeded lesson
    @lessons_with_scores = [@lesson.classroom].map(&:lessons).flatten.map do |lesson|
      { lesson: lesson, quiz_score: rand(0..5) }
    end

    # Creates additional lessons on top of the seeded ones
    additional_lesson_titles = ['Oral Communication II', 'Social Science', 'Language Arts']
    additional_lesson_titles.each do |title|
      @lessons_with_scores << { lesson: OpenStruct.new(title: title), quiz_score: rand(0..5) }
    end
    # Creates the individual student progress charts in the pop-up
    @chart_data = {}
    @lessons_with_scores.each do |lesson_result|
      @chart_data[lesson_result[:lesson].title] = lesson_result[:quiz_score]
    end

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


    students.each do |student|

      # Lesson 1 Totals Filtered by Style
      if student.learning_style == 'visual'
        visual_l1_total += student.scores.values.slice(0)
        visual_student_total += 1
      elsif student.learning_style == 'aural'
        aural_l1_total += student.scores.values.slice(0)
        aural_student_total += 1
      elsif student.learning_style == 'reading'
        reading_l1_total += student.scores.values.slice(0)
        reading_student_total += 1
      else
        kinesthetic_l1_total += student.scores.values.slice(0)
        kinesthetic_student_total += 1
      end

      # Lesson 2 Totals Filtered by Style
      if student.learning_style == 'visual'
        visual_l2_total += student.scores.values.slice(1)
      elsif student.learning_style == 'aural'
        aural_l2_total += student.scores.values.slice(1)
      elsif student.learning_style == 'reading'
        reading_l2_total += student.scores.values.slice(1)
      else
        kinesthetic_l2_total += student.scores.values.slice(1)
      end

      # Lesson 3 Totals Filtered by Style
      if student.learning_style == 'visual'
        visual_l3_total += student.scores.values.slice(2)
      elsif student.learning_style == 'aural'
        aural_l3_total += student.scores.values.slice(2)
      elsif student.learning_style == 'reading'
        reading_l3_total += student.scores.values.slice(2)
      else
        kinesthetic_l3_total += student.scores.values.slice(2)
      end

      # Lesson 4 Totals Filtered by Style
      if student.learning_style == 'visual'
        visual_l4_total += student.scores.values.slice(3)
      elsif student.learning_style == 'aural'
        aural_l4_total += student.scores.values.slice(3)
      elsif student.learning_style == 'reading'
        reading_l4_total += student.scores.values.slice(3)
      else
        kinesthetic_l4_total += student.scores.values.slice(3)
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

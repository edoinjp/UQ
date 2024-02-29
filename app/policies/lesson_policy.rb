class LessonPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all # the same as "Lesson.all"
    end
  end

  def show?
    true # switch from application policy so everyone can see the page
  end

  def new?
    user.teacher?
  end

  def create?
    user.teacher?
  end

  def download_pdf?
    true
  end

end

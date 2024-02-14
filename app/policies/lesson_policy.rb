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
end

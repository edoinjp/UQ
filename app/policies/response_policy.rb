class ResponsePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.teacher?
        scope.joins(choice: { question: :lesson }).where(lessons: { classroom: user.classrooms })
      else
        scope.where(user: user)
      end
    end
  end

  def index?
    user.teacher? && record.classroom.user == user
  end
end

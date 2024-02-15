class ResponsePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def view_quiz_results?
    user.teacher? && record.classroom.user == user
  end
end

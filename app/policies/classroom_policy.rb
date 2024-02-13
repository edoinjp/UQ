class ClassroomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.teacher?
        scope.all
      else
        scope.joins(:participations).where(participations: { user_id: user.id })
      end
    end
  end
end

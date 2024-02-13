class ClassroomPolicy < ApplicationPolicy
  def index?
    user.teacher?
  end

  def new?
    user.teacher? # Adjust this based on your user roles
  end

  def create?
    user.teacher?
  end

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



# def index?
#   Rails.logger.debug("Current User: #{user.inspect}")
#   user.teacher? # Adjust this based on your user roles
# end

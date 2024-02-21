class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def show?
    # Ony user with attribute teacher can see other users
    user.teacher? && record != user
  end

  def test?
    true
  end
end

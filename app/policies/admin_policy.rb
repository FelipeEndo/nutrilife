class AdminPolicy < ApplicationPolicy
  def new?
    user.full_access?
  end
  
  def edit?
    user.full_access?
  end
  
  def destroy?
    user.full_access?
  end
end
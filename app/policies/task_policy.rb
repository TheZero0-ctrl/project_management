class TaskPolicy < ApplicationPolicy
  def show?
    authorize? || record.assigned_users.include?(user)
  end

  def update?
    authorize?
  end

  def edit?
    authorize?
  end

  def destroy?
    authorize?
  end

  def create?
    authorize?
  end

  private

  def authorize?
    record.project.user == user
  end
end

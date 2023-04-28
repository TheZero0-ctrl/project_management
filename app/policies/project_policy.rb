class ProjectPolicy < ApplicationPolicy
  def show?
    authorize?
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

  private

  def authorize?
    record.user == user
  end
end

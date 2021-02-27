class ChildrenRelationshipsController < ApplicationController
  def create
    Relationship.create! params.permit(:children_id, :parent_id)
    redirect_back notice: 'Родитель добавлен', fallback_location: users_path
  end

  private

  def children
    @children ||= User.find params[:id]
  end
end

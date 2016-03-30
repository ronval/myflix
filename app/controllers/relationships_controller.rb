class RelationshipsController < ApplicationController
  before_action :require_user, only:[:index]
  def index
    @relationships = current_user.following_relationships
  end

end   
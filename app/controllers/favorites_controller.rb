class FavoritesController < ApplicationController
  def create
		@favorite = current_user.favorites.build(racket_id: params[:racket_id])
		@favorite.save
		redirect_back(fallback_location: root_path)
  end

  def destroy
	  @favorite = current_user.favorites.find_by(racket: params[:racket_id])
		@favorite.destroy!
		redirect_back(fallback_location: root_path)
  end
end

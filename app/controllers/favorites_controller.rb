class FavoritesController < ApplicationController
  def create
		racket = Racket.find(params[:racket_id])
		favorite = current_user.favorites.new(racket_id: racket.id)
		respond_to do |format|
		  if favorite.save
				format.turbo_stream do
					render turbo_stream: turbo_stream.update("racket_#{racket.id}_favorite", partial: 'racket/favorite', locals {racket: racket})
				end
			else
				format.html { redirect_to racket, alert: 'Failed to favorite.'}
		  end
		end
  end

  def destroy
	  favorite = current_user.favorites.find_by(racket: params[:racket_id])
		racket = Racket.find(params[:racket_id])
		respond_to do |format|
			if favorite.destroy
				format.turbo_stream do
				  render turbo_stream: turbo_stream.update("racket_#{racket.id}_favorite", partial: 'rackets/favorite', locals: { racket: racket})
				end
			else
				format.html { redirect_to racket, alert: 'Failed to unfavorite.'}
			end
		end
  end
end

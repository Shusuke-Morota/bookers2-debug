class FavoritesController < ApplicationController

	def create
		@favorite = current_user.favorites.create(book_id: params[:book_id])
		redirect_back(fallback_location: root_path)
		# ↑current_userに結びついているいいねを作成している。book.idはいいねした本のid。
		# いいねをした時に前の画面に戻るという記述。
	end

	def destroy
		@book = Book.find(params[:book_id])
		@favorite = current_user.favorites.find_by(book_id: @book.id)
		@favorite.destroy
		redirect_back(fallback_location: root_path)
	end
end

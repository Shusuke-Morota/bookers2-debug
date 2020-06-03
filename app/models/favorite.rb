class Favorite < ApplicationRecord
	belongs_to :user #１人のユーザーに属している
	belongs_to :book

	validates_uniqueness_of :book_id, scope: :user_id #book_idとuser_idという組が1通りしかないという記述
end

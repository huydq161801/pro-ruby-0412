class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :likes, -> {order(:created_at => :desc)}, dependent: :destroy
  has_many :comments, -> {order(:created_at => :desc)}, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
#nguoi dang
  def is_belongs_to? user
    Post.find_by(user_id: user.id, id: id)
  end
#nguoi like
  def is_liked user
    Like.find_by(user_id: user.id, post_id: id)
  end
#dau trang cua user
  def is_bookmarked user
    Bookmark.find_by(user_id: user.id, post_id: id)
  end
end

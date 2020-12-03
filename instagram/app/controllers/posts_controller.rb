class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:show, :destroy]

  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 5).includes(:photos, :user, :likes).
      order("created_at desc")
    @post = Post.new
  end

# post anh
  def create 
    @post = current_user.posts.build(post_params)
    if @post.save
      if params[:images]
        params[:images].each do |img|
          @post.photos.create(image: params[:images][img])
        end
      end

      redirect_to posts_path
      flash[:notice] = "Saved ..."
    else
      flash[:alert] = "Something went wrong ..."
      redirect_to posts_path
    end
  end
# show anh (home)
  def show
    @photos = @post.photos
    @likes = @post.likes.includes(:user)
    
    @is_bookmarked = @post.is_bookmarked(current_user)
  end
# xoa anh
  def destroy
    if @post.user == current_user
      if @post.destroy
        flash[:notice] = "Post deleted!"
      else
        flash[:alert] = "Something went wrong ..."
      end
    else
      flash[:notice] = "You don't have permission to do that!"
    end
    redirect_to root_path
  end

  private
# tim anh theo id
  def find_post
    @post = Post.find_by id: params[:id]

    return if @post
    flash[:danger] = "Post not exist!"
    redirect_to root_path
  end
# 
  def post_params
    params.require(:post).permit :content
  end
end
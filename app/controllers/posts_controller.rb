class PostsController < ApplicationController
  def index
    @posts = Post.all
  end 

  def new
    @post = Post.all
  end

  def create
    @post = Post.new(title: params[:title], description: params[:description])
    
    if @post.save
      redirect_to @post, notice: 'Post was successfully created!'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    @post = Post.find_by id: params[:id]
  end

  def update
    @post = Post.find_by id: params[:id]
    if @post.update get_post_data
      redirect_to post_path
    else
      render :new
    end
  end
  
  def get_post_data
    params.require(:post).permit(:tite, :description)
  end
end

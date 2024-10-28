class PostsController < ApplicationController
  def index
    @title = "All Posts"
    @posts = Post.all
  end

  def show
    @post = Post.find_by id: params[:id]

    render plain: @post
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
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])  # Find the post by ID
    @post.destroy                     # Delete the post
  
    redirect_to posts_path, notice: "Post was successfully deleted."
  end

  private
  
  def get_post_data
    params.require(:post).permit(:title, :description)
  end
end

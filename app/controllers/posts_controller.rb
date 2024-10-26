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
    render plain: params
  end
  
  def edit
    @post = Post.find_by id: params[:id]
  end
  
end

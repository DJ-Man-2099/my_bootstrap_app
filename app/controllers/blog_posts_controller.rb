class BlogPostsController < ApplicationController
  def index
    @posts = BlogPost.all
  end

  def show
    @post = BlogPost.find(
      params[:id]
    )
    #this is the catch block
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def new
    @post = BlogPost.new
  end

  def create
    @post = BlogPost.new(post_params)
    @form_submitted = true
    if @post.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def post_params
    params.require(:blog_post).permit(:title, :body)
  end
end

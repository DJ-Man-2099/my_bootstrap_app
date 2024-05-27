class BlogPostsController < ApplicationController
  # this equivalent to this
  # before_action :check_sign_in, except: %i[index show]
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = BlogPost.all
  end

  def show; end

  def new
    @post = BlogPost.new
  end

  def edit
    @title = @post.title
  end

  def create
    @post = BlogPost.new(post_params)
    @form_submitted = true
    if @post.save
      redirect_to root_path
    else
      @form_submitted = false
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @title = @post.title
    @form_submitted = true
    if @post.update(post_params)
      redirect_to @post
    else
      @form_submitted = false
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = "BlogPost was successfully deleted."
    else
      flash[:error] = "Something went wrong"
    end
    redirect_to blog_posts_url
  end

  private

  def set_blog_post
    @post = BlogPost.find(params[:id])
    # this is the catch block
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def check_sign_in
    return if user_signed_in?

    redirect_to root_path
  end

  def post_params
    params.require(:blog_post).permit(:title, :body)
  end
end

class BlogsController < ApplicationController
  def index
    @blogs = Blog.paginate(page: params[:page], per_page: params[:per_page])
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.create(blog_params)
    redirect_to edit_blog_path(@blog)
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:slug, :body)
  end
end

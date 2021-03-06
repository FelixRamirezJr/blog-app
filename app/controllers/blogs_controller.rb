class BlogsController < ApplicationController

  def create
    @blog = Blog.create(blog_params)
    redirect_to edit_blog_path(@blog)
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to request.referrer
  end

  def index
    if params[:search] && !params[:search].blank?
      if Rails.env.production?
        @blogs = Blog.search_by_slug_and_body(params[:search])
                     .paginate(page: params[:page], per_page: params[:per_page])
      else
        @blogs = Blog.where('lower(slug) like ? OR lower(body) like ?', params[:search].downcase, params[:search].downcase)
                     .paginate(page: params[:page], per_page: params[:per_page])
      end
    else
      @blogs = Blog.paginate(page: params[:page], per_page: params[:per_page])
    end
  end

  def new
    @blog = Blog.new
  end

  def show
    @blog = Blog.find_by_slug(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    @blog.update(blog_params)
    redirect_to edit_blog_path(@blog)
  end

  def blog_params
    params.require(:blog).permit(:slug, :body)
  end
end

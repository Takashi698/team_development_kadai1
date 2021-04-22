class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show edit update destroy ]

  # GET /blogs or /blogs.json
  def index
    @blogs = Blog.all
  end

  # GET /blogs/1 or /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs or /blogs.json
  def create
    @blog = Blog.new(blog_params)
    if params[:back]
      render :new
    else
      if @blog.save
        redirect_to blogs_path, notice: "ささやきました！"
      else
        render :new
      end
    end
  end

  # PATCH/PUT /blogs/1 or /blogs/1.json
  def update
    if params[:back]
      render :edit
    else
      if @blog.update(blog_params)
        redirect_to blogs_path, notice: "ささやきを編集しました！"
      else
        render :edit
      end
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: "ささやきを削除しました！"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:title, :content)
    end
end

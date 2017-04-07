class ArticlesController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :edit, :new]

  def new
    @username = user_signed_in? ? current_user.username : NilClass.class
    @article = Article.new
  end

  def create
    @article = Article.new (article_params)

    @errors = params[:article].class
    if @article.save
      redirect_to articles_path
    else
      @errors = @article.errors.full_messages
      render :action => 'new'
    end
  end

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    @comments = Comment.where(article_id: params[:id])
  end

  def edit
    @article = Article.find(params[:id])

  end

  def update
    if @article = Article.find(params[:id]).update(article_params)

    else
      @errors = @article.errors.full_messages
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, :author)
  end
end

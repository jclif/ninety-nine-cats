class CatsController < ApplicationController
  before_filter :not_owner, only: [:edit, :update]

  def index
    @user = self.current_user
    @cats = Cat.all

    render :index
  end

  def show
    @cat = Cat.find(params[:id])

    render :show
  end

  def new
    @cat = Cat.new

    render :new
  end

  def create
    @cat = Cat.new(params[:cat])
    @cat.user_id = current_user.id
    if @cat.save!
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])

    render :edit
  end

  def update
    @cat = Cat.find(params[:id])

    if @cat.update_attributes(params[:cat])
      redirect_to @cat
    else
      render :edit
    end
  end

  def destroy
    Cat.delete(params[:id])
    redirect_to cats_url
  end

end

class CatsController < ApplicationController
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

    if @cat.save!
      redirect_to @cat
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

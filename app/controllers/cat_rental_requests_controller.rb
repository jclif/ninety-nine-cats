class CatRentalRequestsController < ApplicationController
  before_filter :not_owner, only: [:approve, :deny]

  def new
    @cat_rental_request = CatRentalRequest.new

    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(params[:cat_rental_request])

    if @cat_rental_request.save
      redirect_to cats_url
    else
      render :new
    end
  end

  def approve
    @cat_rental_request = CatRentalRequest.find_by_id(params[:cat_rental_request][:id])
    @cat_rental_request.approve!

    redirect_to cat_url(params[:id])
  end

  def deny
    @cat_rental_request = CatRentalRequest.find_by_id(params[:cat_rental_request][:id])
    @cat_rental_request.deny!

    redirect_to cat_url(params[:id])
  end

end

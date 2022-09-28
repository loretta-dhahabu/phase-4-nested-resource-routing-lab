class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :unavailable
  def index
    if(params[:user_id])
    user = User.find(params[:user_id])
    items = user.items
    else
    items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = Item.find(params[:id])
    render json: item, include: :user
  end
  def create
    if(params[:user_id])
    user = User.find(params[:user_id])
    item = user.items.create(item_params)
    end
    render json: item, include: :user, status: :created 
  end

  private

  def item_params
    params.permit(:name, :description, :price, :user_id)
  end

  def unavailable
    render json: {error: "user not found"}, status: :not_found
  end


end

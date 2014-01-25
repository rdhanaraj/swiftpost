class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy] 
  before_action :correct_user, only: [:edit, :update, :destroy]

  def show
  end

  def edit
  end

  def index
    @orders = Order.all
  end

  def new
    unless user_signed_in?
      redirect_to new_user_session_path
    else
      #@order = current_user.orders.new
      @order = Order.new
      @user = current_user
    end
  end

  def create
    @order = current_user.orders.build order_params
    if @order.save
      redirect_to @order, notice: 'Order was successfully created!'
    else
      render action: 'new'
    end
  end

  def update
    if @order.save
      redirect_to @order, notice: 'Order was successfully updated!'
    else
      render action: 'edit'
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def correct_user
      @order = current_user.orders.find_by(id: params[:id])
      redirect_to orders_path, notice: "Not your order!" if @order.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:design, :user_id) if params[:order]
    end
end

class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy] 
  before_action :correct_user, only: [:edit, :update, :destroy]

  def import
    Order.import params[:spreadsheet]
  end

  def show
  end

  def edit
    @order = Order.find_by params[:id]

    # if data is from the demographic selector
    @order.scrape_the_data(@order.create_address(params[:city], params[:state], params[:zipcode])).each do |key, value|
      if (params[:starting_age] >= @order.starting_age and params[:starting_age] <= @order.ending_age)
        or (params[:ending_age] >= @order.starting_age and params[:ending_age] <= @order.ending_age)
        recipient = Recipient.new
        recipient.update_attributes params
        recipient.update_attributes name: 'Current Resident', address: key
        recipient.save!
      end
    end

    # if data is from the spreadsheet uploader
    
  end

  def index
    @orders = Order.all
  end

  def new
    unless user_signed_in?
      redirect_to new_user_session_path
    else
      @order = Order.new
      @user = current_user
    end
  end

  def create
    @order = current_user.orders.build order_params

    import if params[:spreadsheet]
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
      params.require(:order).permit(:design, :user_id, :city, :state, :zipcode, :sender_city, :sender_state, :sender_zipcode, :starting_age, :ending_age) if params[:order]
    end
end

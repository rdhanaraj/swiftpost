class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy] 
  before_action :correct_user, only: [:edit, :update, :destroy]

  # def import
  #   Order.import params[:spreadsheet]
  # end

  def show
    @order
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

    if params[:step1] == 'demographic-selector'
      select_demographic
    end

    if @order.save
      redirect_to @order, notice: 'Please make payment to complete order.'
    else
      redirect_to new_order_path, notice: 'Order not successful, try again.'
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find_by_id(params[:id])
    end

    def correct_user
      @order = current_user.orders.find_by_id(params[:id])
      redirect_to orders_path, notice: "Not your order!" if @order.nil?
    end

    def select_demographic
      @address = @order.create_address(params[:city], params[:state], params[:zipcode])
      @order.scrape_the_data(@address, params[:cap]).each do |key, value|
        if ((params[:starting_age].between?(@order.starting_age, @order.ending_age)) or (params[:ending_age].between?(@order.starting_age, @order.ending_age)))
          recipient = Recipient.new
          recipient.update_attributes params
          recipient.update_attributes name: 'Current Resident', address: key
          recipient.save!
        end
      end
    end

    # def upload_spreadsheet
    #   import if params[:spreadsheet]
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:design, :user_id, :city, :state, :zipcode, :sender_city, :sender_state, :sender_zipcode, :starting_age, :ending_age, :cap, :setting, :order_date, :cardholder_name, :credit_card_number, :cvc, :expiration) if params[:order]
    end
end

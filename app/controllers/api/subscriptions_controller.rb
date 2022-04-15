class Api::SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    if perform_payment
      current_user.update(subscribed: true)
      render json: { message: 'You are now subscribed.' }, status: 201
    else
      # render an error message
    end
  end

  private 

  def perform_payment
    customer = Stripe::Customer.create(
      email: current_user.email,
      source: params[:stripeToken],
      description: 'Subscription to DGMS-News'
    )
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: params[:amount].to_i,
      currency: 'sek'
    )
    charge.paid
  end
end

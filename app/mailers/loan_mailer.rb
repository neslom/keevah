class LoanMailer < ActionMailer::Base
  default from: "chase@example.com"

  def lent_money(user, loan_requests, checkout_amounts)
    @user = user
    @loans = loan_requests
    @amounts = checkout_amounts
    mail(to: @user.email, subject: "Your order has been processed.")
  end

  def received_money(user, loan_request, checkout_amount)
    @user = user
    @loan = loan_request
    @amount = checkout_amount
      mail(to: @loan.user.email, subject: "You have received funding.")
  end

end

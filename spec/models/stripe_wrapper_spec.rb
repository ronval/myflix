require "rails_helper"


describe StripeWrapper do 
  describe StripeWrapper::Charge do 
    context "with valid card" do 
      describe ".create" do
        it "makes a successfull charge", :vcr do 
          Stripe.api_key = ENV['STRIPE_API_KEY']
          
          token = Stripe::Token.create(
              :card => {
              :number => "4242424242424242",
              :exp_month => 4,
              :exp_year => 2017,
              :cvc => "314"
            }
          ).id

          charge = StripeWrapper::Charge.create(
            amount: 999,
            source: token,
            description:"charge example"
            )
        
          expect(charge.successful?).to eq(true)
          expect(charge.response.amount).to eq(999)
        end   
      end 
    end 
    context "with invalid card" do 
      describe ".create" do
        it "doesnt charge", :vcr do 
          Stripe.api_key = ENV['STRIPE_API_KEY']
          
          token = Stripe::Token.create(
              :card => {
              :number => "4000000000000002",
              :exp_month => 4,
              :exp_year => 2017,
              :cvc => "314"
            }
          ).id

          charge = StripeWrapper::Charge.create(
            amount: 999,
            source: token,
            description:"charge example"
            )
        
          expect(charge.successful?).to eq(false)
          
        end   
        it "contains an error message", :vcr do 
          Stripe.api_key = ENV['STRIPE_API_KEY']
          
          token = Stripe::Token.create(
              :card => {
              :number => "4000000000000002",
              :exp_month => 4,
              :exp_year => 2017,
              :cvc => "314"
            }
          ).id

          charge = StripeWrapper::Charge.create(
            amount: 999,
            source: token,
            description:"charge example"
            )
        
          expect(charge.error_message).to eq("Your card was declined.")

        end 
      end 
    end 
  end 
end 

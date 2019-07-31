class CustomersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

    def index
        if params[:id]
            @customer = Customer.find(params[:id])
        elsif params[:email]
            @customer = Customer.find_by email: params[:email]
        else
            @customer = Customer.all
        end
        
        if @customer.nil?
            render json: {message: 'Not found'}, status: :not_found
        else
            render json: @customer, status: :ok
        end
    end
    
    def create
        @customer = Customer.new(customer_params)
        
        if @customer.save
            render json:@customer, status: :created
        else
            render json:@customer.errors, status: :bad_request
        end
    end
    
    def update
         if params[:customerId]
             total =params[:total].to_f
             award =params[:award].to_f
             @customer = Customer.find(params[:customerId])
             if @customer && total && award
                    if @customer.award>0 && total>0
                        @customer.award=0.0
                        @customer.lastOrder = total
                        @customer.lastOrder2 = 0.0
                        @customer.lastOrder3 = 0.0
                    elsif @customer.lastOrder == 0  && total>0
                        @customer.lastOrder = total
                    elsif @customer.lastOrder2 == 0  && total>0
                        @customer.lastOrder2 = total
                    elsif @customer.lastOrder3 == 0  && total>0
                        @customer.lastOrder3 = total
                    elsif award > 0  && total>0
                        @customer.award = award
                    else 
                         render json: {message: 'Oops1'}, status: :bad_request
                    end
                    if !performed?
                        if @customer.save
                            render status: :no_content
                        else
                            render json: {message: 'Oops1'}, status: :bad_request
                        end
                    end
             else
                 render json: {message: 'Oops2'}, status: :bad_request 
             end
         else 
             render json: {message: 'Oops'}, status: :bad_request
         end

    end
    
    def handle_record_not_found
    # Send 404
    render status: :not_found
    end
    

    private
    
    def customer_params
        params.permit(:email,:lastName,:firstName)
    end
    
    def order_params
        params.permit(:itemId,:description,:customerId,:price,:award,:total)
    end
    
end

class CustomersController < ApplicationController
  def index
    if params[:keywords].present?
      @customers = Customer.where(" first_name like :first_name "+
                                  " or last_name like :last_name "+
                                  " or email like :email ",{
                                    first_name: params[:keywords]+"%",
                                    last_name: params[:keywords]+"%",
                                    email: params[:keywords]+"%"
                                  }

        )
      puts "--hxx customers: #{@customers} "
    else
      @customers = []
    end



    
  end
end
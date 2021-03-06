class CustomersController < ApplicationController
  PAGE_SIZE = 10
  def index
    @page = (params[:page] || 0).to_i
    if params[:keywords].present?
      @keywords = params[:keywords]
      @customers = Customer.where(" first_name like :first_name "+
                                  " or last_name like :last_name "+
                                  " or email like :email ",{
                                    first_name: params[:keywords]+"%",
                                    last_name: params[:keywords]+"%",
                                    email: params[:keywords]+"%"
                                  }).order(" email ")
                                  .offset(PAGE_SIZE * @page)
                                  .limit(PAGE_SIZE)



      puts "--hxx customers: #{@customers} "
    else
      @customers = []
    end

    respond_to do |format|
      format.html {}
      format.json { render json: @customers}

    end
  end

  def show
    customer_detail = CustomerDetail.find(params[:id])
    respond_to do |format|
      format.json {render json: customer_detail}
    end
  end
end

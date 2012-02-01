class StoreController < ApplicationController
skip_before_filter :authorize
  def index
	@products = Product.find_products_for_sale.paginate(:per_page => 3, :page => params[:page])
	@cart= current_cart
  end

end

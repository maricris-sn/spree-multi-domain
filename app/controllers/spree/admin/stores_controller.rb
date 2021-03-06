class Spree::Admin::StoresController < Spree::Admin::ResourceController

  before_filter :load_payment_methods
  before_filter :load_shipping_methods

  def index
    @stores = @stores.ransack({ name_or_domains_or_code_cont: params[:q] }).result if params[:q]
    @stores = @stores.where(id: params[:ids].split(',')) if params[:ids]

    respond_with(@stores) do |format|
      format.html
      format.json
    end
  end

  def new
    @store.logo = Spree::StoreLogo.new(viewable: @store, attachment: File.open("#{Rails.root}/public/missing.png"))
  end

  def edit
    if @store.logo.blank?
      @store.logo = Spree::StoreLogo.new(viewable: @store, attachment: File.open("#{Rails.root}/public/missing.png"))
      @store.save
    end
  end

  private
    def load_payment_methods
      @payment_methods = Spree::PaymentMethod.all
    end

    def load_shipping_methods
      @shipping_methods = Spree::ShippingMethod.all
    end
end

module Spree
  Store.class_eval do
    has_and_belongs_to_many :products, join_table: 'spree_products_stores'
    #has_many :taxonomies
    has_many :orders

    has_many :store_payment_methods
    has_many :payment_methods, through: :store_payment_methods

    has_many :store_shipping_methods
    has_many :shipping_methods, through: :store_shipping_methods

    has_and_belongs_to_many :promotion_rules, class_name: 'Spree::Promotion::Rules::Store', join_table: 'spree_promotion_rules_stores', association_foreign_key: 'promotion_rule_id'

    has_one :logo, -> { order(:position) }, as: :viewable, dependent: :destroy, class_name: "Spree::StoreLogo"

    accepts_nested_attributes_for :logo
  end
end

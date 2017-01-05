module Spree
  Slide.class_eval do
    has_and_belongs_to_many :stores, join_table: 'spree_slides_stores'
  end
end
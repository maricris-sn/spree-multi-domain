module Spree
  module Api
    ProductsHelper.class_eval do
      def get_taxonomies
        @taxonomies = Spree::Taxonomy.all
        @taxonomies = @taxonomies.includes(root: :children)
        @taxonomies
      end
    end
  end
end
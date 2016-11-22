Spree::Taxonomy.class_eval do
  belongs_to :store

  scope :by_store, -> (store) { where(store_id: store).present? ? where(store_id: store) : all }
end

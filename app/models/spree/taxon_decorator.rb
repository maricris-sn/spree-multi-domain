Spree::Taxon.class_eval do
  scope :by_store, -> (store) { joins(:taxonomy).merge(Spree::Taxonomy.by_store(store)) }

  def self.find_by_permalink!(permalink)
    by_store(store_id).where(permalink: permalink).first!
    where(permalink: permalink).first!
  end
end

Spree::Taxon.class_eval do
  scope :by_store, -> (store) { joins(:taxonomy).merge(Spree::Taxonomy.by_store(store)) }

  def self.find_by_permalink!(permalink, store)
    #by_store(store.id).where(permalink: permalink).first!
  	store_taxons = (store.taxons.map(&:descendants) + store.taxons).flatten
  	return store_taxons.select{|x| x.permalink == permalink}.first
  end
end

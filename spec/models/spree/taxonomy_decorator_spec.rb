require 'spec_helper'

describe Spree::Taxonomy do

  before(:each) do
    @store = FactoryGirl.create(:store)
    @taxonomy = FactoryGirl.create(:taxonomy, store: @store)

    @taxonomy2 = FactoryGirl.create(:taxonomy)
  end

  # it 'correctly finds taxonomy by store' do
  #   taxonomy_by_store = Spree::Taxonomy.by_store(@store)

  #   taxonomy_by_store.should include(@taxonomy)
  #   taxonomy_by_store.should_not include(@taxonomy2)
  # end
end

require 'spec_helper'

describe Spree::Taxon do    
  describe ".find_by_store_id_and_permalink!" do        
    context "taxon exist in given store" do

      let!(:store) { FactoryGirl.create :store }
      let!(:taxonomy) { FactoryGirl.create :taxonomy , store: store}
      let!(:taxon) { FactoryGirl.create :taxon , taxonomy: taxonomy}      

      let!(:anotherstore) { FactoryGirl.create :store, name: "second-test-store" }
      let!(:anothertaxonomy) { FactoryGirl.create :taxonomy , store: anotherstore}
      let!(:anothertaxon) { FactoryGirl.create :taxon , taxonomy: anothertaxonomy}      

      it "should return a taxon" do
        found_taxon = Spree::Taxon.find_by_permalink!(taxon.permalink)
        found_taxon.should == taxon
        found_taxon.should_not == anothertaxon
      end        
    end

    context "taxon does not exist in given store" do
      it "should raise active_record::not_found" do
        expect{
          Spree::Taxon.find_by_permalink!("non-existing-permalink")
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'scopes' do
    describe '.by_store' do
      before(:each) do
        @store = FactoryGirl.create(:store)
        @taxonomy = FactoryGirl.create(:taxonomy, store: @store)
        @taxon = FactoryGirl.create(:taxon, taxonomy: @taxonomy)
        @taxon2 = FactoryGirl.create(:taxon)
      end

      it 'correctly finds taxon by store' do
        taxon_by_store = Spree::Taxon.by_store(@store)

        taxon_by_store.should include(@taxon)
        taxon_by_store.should_not include(@taxon2)
      end
    end
  end
end
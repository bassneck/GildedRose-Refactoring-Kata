require File.join(File.dirname(__FILE__), '..', 'inventory_item')

describe InventoryItem do

  let(:item) { double('Item') }
  let(:decorated_item) { InventoryItem.new(item) }

  describe 'attributes' do
    describe '#name' do
      it 'is delegated to the original item' do
        expect(item).to receive(:name)
        decorated_item.name
      end
    end

    describe '#sell_in' do
      it 'is delegated to the original item' do
        expect(item).to receive(:sell_in)
        decorated_item.sell_in
      end
    end

    describe '#sell_in=' do
      it 'is delegated to the original item' do
        expect(item).to receive(:sell_in=).with(10)
        decorated_item.sell_in = 10
      end
    end

    describe '#quality' do
      it 'is delegated to the original item' do
        expect(item).to receive(:quality)
        decorated_item.quality
      end
    end

    describe "#quality=" do
      let(:item) { Item.new("foo", 10, 25) }

      it 'assigns value to the item' do
        expect(item).to receive(:quality=).with(5)
        decorated_item.quality = 5
      end

      it "does not change beyond the min-max limit" do
        decorated_item = InventoryItem.new(item)
        min_quality = InventoryItem::MIN_QUALITY
        max_quality = InventoryItem::MAX_QUALITY
        random_valid_quality = (min_quality..max_quality).to_a.sample

        expect { decorated_item.quality = (min_quality - 5) }.to change { item.quality }.to(min_quality)
        expect { decorated_item.quality = random_valid_quality }.to change { item.quality }.to(random_valid_quality)
        expect { decorated_item.quality = (max_quality + 5) }.to change { item.quality }.to(max_quality)
      end
    end

    describe "#update" do
      it "delegates to #updater" do
        updater = double('Updater')
        decorated_item.updater = updater

        expect(updater).to receive(:update).with(decorated_item)
        decorated_item.update
      end
    end
  end
end

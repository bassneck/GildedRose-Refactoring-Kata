require File.join(File.dirname(__FILE__), '..', 'gilded_rose')

describe Updaters::Updater do

  let(:updater) { Updaters::Updater.new(-1, -2) }
  let(:decorated_item) { double('Item', sell_in: 5, quality: 5) }

  describe "#update" do
    it "decreases the sell_in by 1" do
      expect(decorated_item).to receive(:sell_in=).with(decorated_item.sell_in - 1)
      expect(decorated_item).to receive(:quality=)
      updater.update(decorated_item)
    end

    it "decreases the quality by 1" do
      expect(decorated_item).to receive(:sell_in=)
      expect(decorated_item).to receive(:quality=).with(decorated_item.quality - 1)
      updater.update(decorated_item)
    end

    context "when sell_in is < 0" do
      let(:decorated_item) { double('Item', sell_in: -1, quality: 5) }

      it "decreases the quality by 2" do
        expect(decorated_item).to receive(:sell_in=)
        expect(decorated_item).to receive(:quality=).with(decorated_item.quality - 2)
        updater.update(decorated_item)
      end
    end
  end
end

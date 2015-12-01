module Updaters
  class Updater
    def initialize(regular_rate = -1, past_expiry_rate = -2)
      @regular_rate = regular_rate
      @past_expiry_rate = past_expiry_rate
    end

    def update(inventory_item)
      inventory_item.sell_in -= 1

      if inventory_item.sell_in >= 0
        inventory_item.quality += @regular_rate
      else
        inventory_item.quality += @past_expiry_rate
      end
    end
  end

  class LegendaryUpdater
    def update(inventory_item)
      # Nothing to do. Yay.
    end
  end

  class BackstageUpdater
    def update(inventory_item)
      inventory_item.sell_in -= 1

      if inventory_item.sell_in < 0
        inventory_item.quality = 0
      elsif inventory_item.sell_in < 5
        inventory_item.quality += 3
      elsif inventory_item.sell_in < 10
        inventory_item.quality += 2
      else
        inventory_item.quality += 1
      end
    end
  end
end

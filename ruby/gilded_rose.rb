require 'forwardable'

class GildedRose

  def initialize(items)
    @items = items
  end

  class InventoryItem
    extend Forwardable

    MIN_QUALITY = 0
    MAX_QUALITY = 50

    def initialize(item)
      @item = item
    end

    def_delegators :@item, :name, :sell_in, :sell_in=, :quality

    def quality=(value)
      @item.quality = [[MIN_QUALITY, value].max, MAX_QUALITY].min
    end
  end

  def update_quality()
    @items.each do |item|
      item = InventoryItem.new(item)

      next if item.name == "Sulfuras, Hand of Ragnaros"

      if item.name == "Aged Brie"
        item.quality = item.quality + 1
      elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
        item.quality = item.quality + 1

        if item.sell_in < 11
          item.quality = item.quality + 1
        end

        if item.sell_in < 6
          item.quality = item.quality + 1
        end
      else
        item.quality = item.quality - 1
      end

      item.sell_in = item.sell_in - 1

      if item.sell_in < 0
        if item.name == "Aged Brie"
          item.quality = item.quality + 1
        elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
          item.quality = 0
        else
          item.quality = item.quality - 1
        end
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

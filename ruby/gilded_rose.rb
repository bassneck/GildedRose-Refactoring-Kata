require 'forwardable'
require './inventory_item'
require './updaters'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      item = InventoryItem.new(item)

      item.updater =
        if item.name == "Sulfuras, Hand of Ragnaros"
          Updaters::LegendaryUpdater.new
        elsif item.name == "Aged Brie"
          Updaters::Updater.new(1, 2)
        elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
          Updaters::BackstageUpdater.new
        else
          Updaters::Updater.new(-1, -2)
        end

      item.update
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

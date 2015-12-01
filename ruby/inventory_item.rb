require './updaters'

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

  attr_writer :updater
  def updater
    @updater ||= Updater.new
  end

  def update
    updater.update(self)
  end
end

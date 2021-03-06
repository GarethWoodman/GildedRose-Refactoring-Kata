# frozen_string_literal: true

require_relative 'item'

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      item.name.include?('Sulfuras') ? next : check_item(item)

      quality_check_process(item)
    end
  end

  private

  def check_item(item)
    return aged_brie(item)        if item.name.include?('Aged Brie')
    return backstage_passes(item) if item.name.include?('Backstage passes')

    other(item)
  end

  def other(item)
    i = item.name.include?('Conjured') ? 2 : 1
    item.sell_in.positive? ? (item.quality -= 1 * i) : (item.quality -= 2 * i)
  end

  def aged_brie(item)
    item.sell_in.positive? ? (item.quality += 1) : (item.quality += 2)
  end

  def backstage_passes(item)
    item.quality += 1 if item.sell_in > 10
    item.quality += 2 if item.sell_in > 5 && item.sell_in <= 10
    item.quality += 3 if item.sell_in.positive? && item.sell_in <= 5
    item.quality = 0 if item.sell_in <= 0
  end

  def quality_check_process(item)
    item.quality = 50 if item.quality > 50
    item.quality = 0 unless item.quality.positive?
    item.sell_in -= 1
  end
end

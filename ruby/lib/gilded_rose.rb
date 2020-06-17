require_relative 'item'

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      check_item(item)
    end
  end

  private

  def check_item(item)
    return                        if item.name.include? 'Sulfuras'
    return aged_brie(item)        if item.name.include? 'Aged Brie'
    return conjured(item)         if item.name.include? 'Conjured'
    return backstage_passes(item) if item.name.include? 'Backstage passes'
    normal(item)
  end

  def normal(item)
    item.sell_in.positive? ? (item.quality -= 1) : (item.quality -= 2)
    item.quality = 0 unless item.quality.positive?
    item.sell_in -= 1
  end

  def aged_brie(item)
    item.sell_in.positive? ? (item.quality += 1) : (item.quality += 2)
    item.quality = 50 if item.quality > 50
    item.sell_in -= 1
  end

  def backstage_passes(item)
    item.quality += 1 if item.sell_in > 10
    item.quality += 2 if item.sell_in > 5 && item.sell_in <= 10
    item.quality += 3 if item.sell_in > 0 && item.sell_in <= 5
    item.quality = 0 if item.sell_in <= 0
    item.sell_in -= 1
  end

  def conjured(item)
    item.sell_in.positive? ? (item.quality -= 2) : (item.quality -= 4)
    item.quality = 0 unless item.quality.positive?
    item.sell_in -= 1
  end
end

# def update_quality()
#   @items.each do |item|
#     if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
#       if item.quality > 0
#         if item.name != "Sulfuras, Hand of Ragnaros"
#           item.quality = item.quality - 1
#         end
#       end
#     else
#       if item.quality < 50
#         item.quality = item.quality + 1
#         if item.name == "Backstage passes to a TAFKAL80ETC concert"
#           if item.sell_in < 11
#             if item.quality < 50
#               item.quality = item.quality + 1
#             end
#           end
#           if item.sell_in < 6
#             if item.quality < 50
#               item.quality = item.quality + 1
#             end
#           end
#         end
#       end
#     end
#     if item.name != "Sulfuras, Hand of Ragnaros"
#       item.sell_in = item.sell_in - 1
#     end
#     if item.sell_in < 0
#       if item.name != "Aged Brie"
#         if item.name != "Backstage passes to a TAFKAL80ETC concert"
#           if item.quality > 0
#             if item.name != "Sulfuras, Hand of Ragnaros"
#               item.quality = item.quality - 1
#             end
#           end
#         else
#           item.quality = item.quality - item.quality
#         end
#       else
#         if item.quality < 50
#           item.quality = item.quality + 1
#         end
#       end
#     end
#   end
# end

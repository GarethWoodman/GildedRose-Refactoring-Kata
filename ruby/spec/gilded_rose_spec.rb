require 'gilded_rose'

describe GildedRose do

  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq 'foo'
    end

    context 'normal items' do
      context 'postive sell_in value' do
        it 'decreases sell_in and quanity by 1' do
          items = [Item.new('foo', 10, 20)]
          GildedRose.new(items).update_quality()
          expect(items[0].sell_in).to eq 9
          expect(items[0].quality).to eq 19
        end

        it 'quality of item is never negative' do
          items = [Item.new('foo', 1, 0)]
          GildedRose.new(items).update_quality()
          expect(items[0].sell_in).to eq 0
          expect(items[0].quality).to eq 0
        end
      end

      context 'negative sell_in value' do
        it 'decreases sell_in by 1 and quanity by 2' do
          items = [Item.new('foo', 0, 6)]
          GildedRose.new(items).update_quality()
          expect(items[0].sell_in).to eq -1
          expect(items[0].quality).to eq 4
        end

        it 'quality of item is never negative' do
          items = [Item.new('foo', 0, 0)]
          GildedRose.new(items).update_quality()
          expect(items[0].sell_in).to eq -1
          expect(items[0].quality).to eq 0
        end
      end
    end

    context 'Aged Brie' do
      context 'postive sell_in value' do
        it 'decreases sell_in by 1 and increases quality by 1' do
          items = [Item.new('Aged Brie', 1, 6)]
          GildedRose.new(items).update_quality()
          expect(items[0].sell_in).to eq 0
          expect(items[0].quality).to eq 7
        end

        it 'quality is never more than 50' do
          items = [Item.new('Aged Brie', 1, 49)]
          GildedRose.new(items).update_quality()
          expect(items[0].sell_in).to eq 0
          expect(items[0].quality).to eq 50
        end
      end

      context 'negative sell_in value' do
        it 'decreases sell_in by 1 and increases quality by 2' do
          items = [Item.new('Aged Brie', 0, 6)]
          GildedRose.new(items).update_quality()
          expect(items[0].sell_in).to eq -1
          expect(items[0].quality).to eq 8
        end

        it 'quality is never more than 50' do
          items = [Item.new('Aged Brie', 0, 49)]
          GildedRose.new(items).update_quality()
          expect(items[0].sell_in).to eq -1
          expect(items[0].quality).to eq 50
        end
      end
    end
  end
end

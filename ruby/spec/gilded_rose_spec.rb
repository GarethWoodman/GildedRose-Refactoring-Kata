require 'gilded_rose'

def enter_item(name, sell_in, quality)
  @items = [Item.new(name, sell_in, quality)]
  GildedRose.new(@items).update_quality()
end


describe GildedRose do
  describe '#update_quality' do
    it 'does not change the name' do
      enter_item('foo', 0, 0)
      expect(@items[0].name).to eq 'foo'
    end

    context 'normal items' do
      context 'postive sell_in value' do
        it 'decreases quality by 1' do
          enter_item('foo', 10, 20)
          expect(@items[0].quality).to eq 19
        end

        it 'quality of item is never negative' do
          enter_item('foo', 1, 0)
          expect(@items[0].quality).to eq 0
        end
      end

      context 'negative sell_in value' do
        it 'decreases quality by 2' do
          enter_item('foo', 0, 6)
          expect(@items[0].quality).to eq 4
        end

        it 'quality of item is never negative' do
          enter_item('foo', 0, 0)
          expect(@items[0].quality).to eq 0
        end
      end
    end

    context 'Aged Brie' do
      context 'postive sell_in value' do
        it 'increases quality by 1' do
          enter_item('Aged Brie', 1, 6)
          expect(@items[0].quality).to eq 7
        end

        it 'quality is never more than 50' do
          enter_item('Aged Brie', 1, 49)
          expect(@items[0].quality).to eq 50
        end
      end

      context 'negative sell_in value' do
        it 'increases quality by 2' do
          enter_item('Aged Brie', 0, 6)
          expect(@items[0].quality).to eq 8
        end

        it 'quality is never more than 50' do
          enter_item('Aged Brie', 0, 49)
          expect(@items[0].quality).to eq 50
        end
      end
    end

    context 'Bakstage Passes' do
      context 'sell_in value of 15' do
        it 'quality increases by 1' do
          enter_item('Backstage passes to a TAFKAL80ETC concert', 15, 10)
          expect(@items[0].quality).to eq 11
        end
      end

      context 'sell_in value of 10' do
        it 'quality increases by 2' do
          enter_item('Backstage passes to a TAFKAL80ETC concert', 10, 10)
          expect(@items[0].quality).to eq 12
        end
      end
    end
  end
end

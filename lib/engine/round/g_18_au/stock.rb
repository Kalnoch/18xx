# frozen_string_literal: true

require_relative '../stock'

module Engine
  module Round
    module G18AU
      class Stock < Stock
        def finish_round
          (@game.corporations.select(&:floated?) - @game.minor_regional_order).sort.each do |corp|
            prev = corp.share_price.price

            @game.stock_market.move_up(corp) if sold_out?(corp)
            pool_share_drop = @game.class::POOL_SHARE_DROP
            price_drops =
              if (pool_share_drop == :none) || (shares_in_pool = corp.num_market_shares).zero?
                0
              elsif pool_share_drop == :one
                1
              else
                shares_in_pool
              end
            price_drops.times { @game.stock_market.move_down(corp) }

            @game.log_share_price(corp, prev)
          end
        end
      end
    end
  end
end

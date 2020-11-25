# frozen_string_literal: true

require_relative '../dividend'
require_relative '../half_pay'
require_relative '../minor_half_pay'

module Engine
  module Step
    module G18AU
      class Dividend < Dividend
        DIVIDEND_TYPES = %i[payout half withhold].freeze
        include HalfPay
        include MinorHalfPay

        def share_price_change(entity, revenue = 0)
          return {} if @game.minor_regional_order.include? entity

          price = entity.share_price.price
          return { share_direction: :left, share_times: 1 } if revenue < 1

          times = 0
          times = 1 if revenue >= price
          if times.positive?
            { share_direction: :right, share_times: times }
          else
            {}
          end
        end
      end
    end
  end
end


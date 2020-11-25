# frozen_string_literal: true

require_relative '../buy_sell_par_shares'
require_relative '../../action/float_minor'
require_relative '../../action/convert'

module Engine
  module Step
    module G18AU
      class BuySellParShares < BuySellParShares

        def actions(entity)
          actions = super
          actions << 'convert' if can_convert_any?(entity)
          actions << 'pass' if actions.any?
          actions << 'float_minor' if can_float_any?(entity)
          actions
        end

        def can_float_any?(entity)
          !bought? && @game.minors.any? { |m| !m.floated? }
        end

        def can_convert_any?(entity)
          !bought? && @game.corporations.any? { |c| c.floated? }
        end

        def process_float_minor(action)
#          entity = action.entity
#          minor = action.minor
#          minor.owner = entity
#          entity.minors << minor
           company = action.entity
           player = company.player
           float_minor(company)
           @round.last_to_act = player
           @current_actions << action
           @acted = true
           pass!
        end

        def float_minor(company)
          return unless (minor = @game.minors.find { |m| m.id == company.id })
          
          minor.owner = company.player
          minor.float!
          @game.place_home_token(minor)
          @game.minor_regional_order << minor
          company.close!
        end

        def process_convert(action)
          corporation = action.entity
          @game.float_major(corporation)
          # need to set last_to_act as floating a major is an action
          @round.last_to_act = @round.current_entity
          @current_actions << action
          @log << "#{corporation.name} converts from regional to major"
        end

        def float_major(corporation)
          shares = @_shares.values.select { |share| share.corporation == corporation }

          if corporation.total_shares == 4
            shares.each { |share| share.percent = 10 }
            shares[0].percent = 20
            shares = 6.times.map { |i| Share.new(corporation, percent: 10, index: i + 3) }
            corporation.always_market_price = false
            # corporation.tokens needs to be added in
          else
            game_error('Cannot convert a major corporation')
          end

          shares.each do |share|
            corporation.shares_by_corporation[corporation] << share
            @_shares[share.id] = share
          end
        end


        def process_par(action)
          super
          @game.minor_regional_order << action.corporation
        end

#        def can_buy?(entity, bundle)
#          return unless bundle
#
#          if bundle.corporation.id == 'L' || bundle.corporation.id == 'F' && !bundle.corporation.ipoed
#            # L/F is floated via a minor charter.
#
#            corporation = bundle.corporation
#            entity.cash >= bundle.price_per_share && can_gain?(entity, bundle) &&
#              !@players_sold[entity][corporation] &&
#              (can_buy_multiple?(corporation) || !bought?)
#          else
#            super
#          end
#        end

#        def get_par_prices(entity, corp)
#          if corp.id == 'F' || corp.id == 'L'
#            @game
#              .stock_market
#              .par_prices
#              .select { |p| p.price == 60 }
#          else
#            super
#          end
#        end

#        def process_par(action)
#          if action.corporation.id == 'L' || action.corporation.id == 'F'
#            share_price = action.share_price
#            corporation = action.corporation
#            @game.game_error("#{corporation} cannot be parred") unless corporation.can_par?(action.entity)
#
#            @game.stock_market.set_par(corporation, share_price)
#            share = corporation.shares.first
#            bundle = share.to_bundle
#            @game.share_pool.buy_shares(action.entity,
#                                        bundle,
#                                        exchange: corporation.par_via_exchange)
#
#            @game.bank.spend(120, corporation)
#            # Minor chooses home token now.
#            @game.place_home_token(corporation)
#            corporation.par_via_exchange.close!
#
#            @current_actions << action
#          else
#            super
#          end
#        end

      end
    end
  end
end

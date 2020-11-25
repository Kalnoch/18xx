# frozen_string_literal: true

require_relative '../config/game/g_18_au'
require_relative 'base'

module Engine
  module Game
    class G18AU < Base
      attr_accessor :minor_regional_order
      register_colors(black: '#37383a',
                      orange: '#f48221',
                      brightGreen: '#76a042',
                      red: '#d81e3e',
                      turquoise: '#00a993',
                      blue: '#0189d1',
                      brown: '#7b352a')

      load_from_json(Config::Game::G18AU::JSON)

      DEV_STAGE = :alpha

      GAME_LOCATION = 'Austria/Hungary'
      GAME_RULES_URL = ''
      GAME_DESIGNER = ''
      GAME_PUBLISHER = ''
      GAME_INFO_URL = ''

      HOME_TOKEN_TIMING = :float
      SELL_BUY_ORDER = :sell_buy

      EBUY_PRES_SWAP = false
      MUST_BUY_TRAIN = :never
      MINOR_BUY_TRAINS = true

      IPO_NAME = 'Treasury'
      TILE_LAYS = [{ lay: true, upgrade: true }, { lay: true, upgrade: :not_if_upgraded }].freeze


#      def init_company_abilities
#        @companies.each do |company|
#          next unless (ability = company.abilities(:exchange))
#
#          next unless ability.from.include?(:par)
#
#          corporation = corporation_by_id(ability.corporation)
#          corporation.par_via_exchange = company
#        end
#        super
#      end

      def setup
        @minor_regional_order = []
      end

      def minor_f
        @minor_f ||= minor_by_id('F')
      end

      def minor_l
        @minor_l ||= minor_by_id('L')
      end

      def home_token_locations(corporation)
        raise NotImplementedError unless corporation.name == 'L' || corporation.name == 'F'

        hexes = @hexes.dup
        hexes.select do |hex|
          hex.tile.cities.any? { |city| city.tokenable?(corporation, free: true) }
        end
      end

      def stock_round
        Round::G18AU::Stock.new(self, [
          Step::DiscardTrain,
          Step::G18AU::HomeToken,
          Step::G18AU::BuySellParShares
        ])
      end

      def new_auction_round
        Round::Auction.new(self, [
          Step::CompanyPendingPar,
          Step::G18AU::WaterfallAuction,
        ])
      end

      def operating_round(round_num)
        Round::G18AU::Operating.new(self, [
          Step::Bankrupt,
          Step::Exchange,
          Step::DiscardTrain,
          Step::HomeToken,
          Step::G18AU::Track,
          Step::Token,
          Step::Route,
          Step::G18AU::Dividend,
          Step::BuyTrain,
          Step::G18AU::IssueShares
        ], round_num: round_num)
      end

      def active_players
        return super if @finished

        current_entity == company_by_id('ER') ? [@round.company_seller] : super
      end

      def float_major(corporation)
        shares = @_shares.values.select { |share| share.corporation == corporation }

        if corporation.total_shares == 4
          shares.each { |share| share.percent = 10 }
          shares[0].percent = 20
          shares = 6.times.map { |i| Share.new(corporation, percent: 10, index: i + 3) }

          # Majors are affected by the stock market, set tokens in the correct place
          #corporation.always_market_price = true
          stock_market.move_right(corporation)
          stock_market.move_up(corporation)
          stock_market.move_up(corporation)
          # corporation.tokens needs to be added in
          corporation.tokens += [40, 60, 60, 80, 80, 80].map { |price| Token.new(corporation, price: price) }
          # Lastly, remove major from minor/regional turn order
          @minor_regional_order -= [corporation]
        else
          game_error('Cannot convert a major corporation')
        end

        shares.each do |share|
          corporation.shares_by_corporation[corporation] << share
          @_shares[share.id] = share
        end
      end

      def merge_minor(minor, major, share)
        treasury = format_currency(minor.cash).to_s
        @log << "-- Minor #{minor.name} merges into #{major.name} who receives the treasury of #{treasury} --"
        
        share.buyable = true
        share_pool.buy_shares(minor.player, share, exchange: :free, exchange_price: 0)
        
        hexes.each do |hex|
          hex.tile.cities.each do |city|
            if city.tokened_by?(minor)
              city.tokens.map! { |token| token&.corporation == minor ? nil : token }
              city.reservations.delete(minor)
            end
          end
        end

        minor.spend(minor.cash, major)
        hexes.each do |hex|
          hex.tile.cities.each do |city|
            if city.tokened_by?(minor)
              city.tokens.map! { |token| token&.corporation == minor ? nil : token }
            end
          end
        end

        @minors.delete(minor)
      end

      def tile_cost(tile, entity)
        # Need to implement percentage discounts
        super
      end

      def company_becomes_minor?(company)
        @minors.collect(&:name).include?(company.sym)
      end

      def issuable_shares(entity)
        return [] unless entity.corporation? && entity.total_shares == 10
        return [] unless round.steps.find { |step| step.class == Step::G18AU::IssueShares }.active?
        num_shares = 5 - entity.num_market_shares
        bundles = bundles_for_corporation(entity, entity)
        share_price = entity.share_price.price

        bundles
          .each { |bundle| bundle.share_price = share_price }
          .reject { |bundle| bundle.num_shares > num_shares }
      end

      def redeemable_shares(entity)
        return [] unless entity.corporation? && entity.total_shares == 10
        return [] unless round.steps.find { |step| step.class == Step::G18AU::IssueShares }.active?
        share_price = entity.share_price.price

        bundles_for_corporation(share_pool, entity)
          .each { |bundle| bundle.share_price = share_price }
          .reject { |bundle| entity.cash < bundle.price }        
      end

    end
  end
end

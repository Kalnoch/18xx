# frozen_string_literal: true

require_relative '../config/game/g_1817'
require_relative '../loan.rb'
require_relative 'base'

module Engine
  module Game
    class G1867 < Base
      register_colors(black: '#16190e',
                      blue: '#165633',
                      brightGreen: '#0a884b',
                      brown: '#984573',
                      gold: '#904098',
                      gray: '#984d2d',
                      green: '#bedb86',
                      lavender: '#e96f2c',
                      lightBlue: '#bedef3',
                      lightBrown: '#bec8cc',
                      lime: '#00afad',
                      navy: '#003d84',
                      natural: '#e31f21',
                      orange: '#f2a847',
                      pink: '#ee3e80',
                      red: '#ef4223',
                      turquoise: '#0095da',
                      violet: '#e48329',
                      white: '#fff36b',
                      yellow: '#ffdea8')

      # @todo: Actually import the 1867 config
      load_from_json(Config::Game::G1817::JSON)

      GAME_LOCATION = 'Canada'
      GAME_RULES_URL = 'tbd'
      GAME_DESIGNER = 'Ian D. Wilson'
      GAME_PUBLISHER = :grand_trunk_games
      GAME_INFO_URL = 'https://github.com/tobymao/18xx/wiki/1867'

      # @todo: unchanged from here
      MUST_BID_INCREMENT_MULTIPLE = true
      SEED_MONEY = 200
      MUST_BUY_TRAIN = :never
      EBUY_PRES_SWAP = false # allow presidential swaps of other corps when ebuying
      POOL_SHARE_DROP = :each
      SELL_MOVEMENT = :none
      ALL_COMPANIES_ASSIGNABLE = true
      SELL_AFTER = :operate
      DEV_STAGE = :prealpha

      ASSIGNMENT_TOKENS = {
        'bridge' => '/icons/1817/bridge_token.svg',
        'mine' => '/icons/1817/mine_token.svg',
      }.freeze

      GAME_END_CHECK = { bankrupt: :immediate, custom: :one_more_full_or_set }.freeze

      CERT_LIMIT_CHANGE_ON_BANKRUPTCY = true

      # Two lays with one being an upgrade, second tile costs 20
      TILE_LAYS = [{ lay: true, upgrade: true }, { lay: true, upgrade: :not_if_upgraded, cost: 20 }].freeze

      IPO_NAME = 'Treasury'

      LIMIT_TOKENS = 8

      EVENTS_TEXT = Base::EVENTS_TEXT.merge('signal_end_game' => ['Signal End Game',
                                                                  'Game Ends 3 ORs after purchase/export'\
                                                                  ' of first 8 train']).freeze
      STATUS_TEXT = Base::STATUS_TEXT.merge(
        'no_new_shorts' => ['Cannot gain new shorts', 'Short selling is not permitted, existing shorts remain'],
      ).freeze
      MARKET_TEXT = Base::MARKET_TEXT.merge(safe_par: 'Minimum Price for a 2($55), 5($70) and 10($120) share'\
      ' corporation taking maximum loans to ensure it avoids acquisition',
                                            acquisition: 'Acquisition (Pay $40 dividend to move right, $80'\
                                            ' to double jump)').freeze
      STOCKMARKET_COLORS = Base::STOCKMARKET_COLORS.merge(par: :gray).freeze
      MARKET_SHARE_LIMIT = 1000 # notionally unlimited shares in market
      CORPORATION_SIZES = { 2 => :small, 5 => :medium, 10 => :large }.freeze

      attr_reader :loan_value, :owner_when_liquidated, :stock_prices_start_merger

      def init_stock_market
        @owner_when_liquidated = {}
        super
      end

      def bankruptcy_limit_reached?
        @players.reject(&:bankrupt).one?
      end

      # @todo: unchanged to here

      def interest_rate
        5 # constant
      end

      def interest_owed_for_loans(loans)
        (interest_rate * loans * @loan_value) / 100
      end

      def interest_owed(entity)
        interest_owed_for_loans(entity.loans.size)
      end

      # @todo: unchanged from here

      def can_pay_interest?(entity, extra_cash = 0)
        # Can they cover it using cash?
        return true if entity.cash + extra_cash > interest_owed(entity)

        # Can they cover it using buying_power minus the full interest
        (buying_power(entity) + extra_cash) > interest_owed_for_loans(maximum_loans(entity))
      end

      def maximum_loans(entity)
        entity.total_shares
      end

      def bidding_power(player)
        player.cash + player.companies.sum(&:value)
      end

      def num_certs(entity)
        # Privates don't count towards limit
        entity.shares.count { |s| s.corporation.counts_for_limit && s.counts_for_limit }
      end

      def home_token_locations(corporation)
        hexes.select do |hex|
          hex.tile.cities.any? { |city| city.tokenable?(corporation, free: true) }
        end
      end

      def redeemable_shares(entity)
        return [] unless entity.corporation?
        return [] unless round.steps.find { |step| step.class == Step::G1817::BuySellParShares }.active?

        bundles_for_corporation(share_pool, entity)
          .reject { |bundle| entity.cash < bundle.price }
      end

      def tokens_needed(corporation)
        tokens_needed = { 2 => 1, 5 => 2, 10 => 4 }[corporation.total_shares] - corporation.tokens.size
        tokens_needed += 1 if corporation.companies.any? { |c| c.id == 'TS' }
        tokens_needed
      end

      def size_corporation(corporation, size)
        original_shares = @_shares.values.select { |share| share.corporation == corporation }
        game_error('Can only convert 2 share corporation') unless corporation.total_shares == 2

        corporation.share_holders.clear

        case size
        when 5
          original_shares[0].percent = 40
          shares = 3.times.map { |i| Share.new(corporation, percent: 20, index: i + 1) }
        when 10
          original_shares[0].percent = 20
          shares = 8.times.map { |i| Share.new(corporation, percent: 10, index: i + 1) }
        end

        original_shares.each { |share| corporation.share_holders[share.owner] += share.percent }

        corporation.max_ownership_percent = 60 unless size == 2

        shares.each do |share|
          add_new_share(share)
        end
      end

      def bundles_for_corporation(share_holder, corporation, shares: nil)
        super(
          share_holder,
          corporation,
          shares: shares || share_holder.shares_of(corporation).select { |share| share.percent.positive? },
        )
      end

      def convert(corporation)
        shares = @_shares.values.select { |share| share.corporation == corporation }

        corporation.share_holders.clear

        case corporation.total_shares
        when 2
          shares[0].percent = 40
          new_shares = 3.times.map { |i| Share.new(corporation, percent: 20, index: i + 1) }
        when 5
          shares.each { |share| share.percent = share.percent.positive? ? 10 : -10 }
          shares[0].percent = 20
          new_shares = 5.times.map { |i| Share.new(corporation, percent: 10, index: i + 4) }
        else
          game_error('Cannot convert 10 share corporation')
        end

        corporation.max_ownership_percent = 60
        shares.each { |share| corporation.share_holders[share.owner] += share.percent }

        new_shares.each do |share|
          add_new_share(share)
        end
        new_shares
      end

      def shorts(corporation)
        @_shares.values.select { |share| share.corporation == corporation && share.percent.negative? }
      end

      def entity_shorts(entity, corporation)
        entity.shares_of(corporation).select { |share| share.percent.negative? }
      end

      def close_market_shorts
        @corporations.each do |corporation|
          # Try closing shorts
          count = 0
          while entity_shorts(@share_pool, corporation).any? &&
            (market_shares = @share_pool.shares_of(corporation)
             .select { |share| share.percent.positive? && !share.president }).any?

            unshort(@share_pool, market_shares.first)
            count += 1
          end
          @log << "Market closes #{count} shorts for #{corporation.name}" if count.positive?
        end
      end

      def close_bank_shorts
        # Close out shorts in stock market with the bank buying shares from the treasury
        @corporations.each do |corporation|
          count = 0
          while entity_shorts(@share_pool, corporation).any? &&
            corporation.shares.any?

            # Market buys the share
            share = corporation.shares.first
            @share_pool.buy_shares(@share_pool, share)

            # Then closes the share
            unshort(@share_pool, share)
            count += 1

          end
          @log << "Market closes #{count} shorts for #{corporation.name}" if count.positive?
        end
      end

      def migrate_shares(corporation, other)
        # Migrate shares from a 5 & 5 corporation merger
        new_shares = convert(corporation)
        percentage = 10

        shares = @_shares.values.select { |share| share.corporation == other }
        surviving_shares = @_shares.values.select { |share| share.corporation == corporation }
        # Highest share (9 is all the potential 'normal' share certificates)
        highest_share = [surviving_shares.map(&:index).max, 9].max

        shares.each do |share|
          entity = share.owner
          entity = corporation if entity == other
          # convert each 20% in the old company into 10% in the new company
          (share.percent / 20).abs.times do
            if share.percent.positive?
              if new_shares.any?
                # Use the 'normal' shares where possible until they run out.
                new_share = new_shares.shift
                new_share.transfer(entity)
              else
                highest_share += 1
                new_share = Share.new(corporation, owner: entity, percent: percentage, index: highest_share)
                add_new_share(new_share)
              end
            else
              highest_share += 1
              short = Share.new(corporation, owner: entity, percent: -percentage, index: highest_share)
              short.buyable = false
              short.counts_for_limit = false
              add_new_share(short)
            end
          end
        end

        max_shares = corporation.player_share_holders.values.max

        # Check cross-short merge problem
        game_error('At least one player must have more than 20% to allow a merge') if max_shares < 20

        # Find the new president, tie break is the surviving corporation president
        # This is done before the cancelling to ensure the new president can cancel any shorts
        majority_share_holders = corporation
          .player_share_holders
          .select { |_, p| p == max_shares }
          .keys

        previous_president = corporation.owner

        if majority_share_holders.none? { |player| player == previous_president }
          president = majority_share_holders
            .select { |p| p.percent_of(corporation) >= corporation.presidents_percent }
            .min_by { |p| @share_pool.distance(previous_president, p) }

          president_share = previous_president.shares_of(corporation).find(&:president)
          corporation.owner = president
          @log << "#{president.name} becomes the president of #{corporation.name}"
          @share_pool.change_president(president_share, previous_president, president)
        end

        # Consolidate shorts with their share pair (including share pool shares)
        @_shares
          .values
          .select { |share| share.corporation == corporation }
          .group_by(&:owner)
          .each do |owner, _shares_|
          shares = owner.shares_of(corporation)
          while shares.any? { |s| s.percent.negative? } && shares.any? { |s| s.percent == percentage }
            share = shares.find { |s| s.percent == percentage }
            unshort(owner, share)
          end
        end
      end

      def add_new_share(share)
        owner = share.owner
        corporation = share.corporation
        corporation.share_holders[owner] += share.percent if owner
        owner.shares_by_corporation[corporation] << share
        @_shares[share.id] = share
      end

      def remove_share(share)
        owner = share.owner
        corporation = share.corporation
        corporation.share_holders[owner] -= share.percent if owner
        owner.shares_by_corporation[corporation].delete(share)
        @_shares.delete(share.id)
      end

      def short(entity, corporation)
        price = corporation.share_price.price
        percent = corporation.share_percent

        shares = @_shares.values.select { |share| share.corporation == corporation }

        # Highest share (9 is all the potential 'normal' share certificates)
        highest_share = [shares.map(&:index).max, 9].max

        share = Share.new(corporation, owner: @share_pool, percent: percent, index: highest_share + 1)
        short = Share.new(corporation, owner: entity, percent: -percent, index: highest_share + 2)
        short.buyable = false
        short.counts_for_limit = false

        @log << "#{entity.name} shorts a #{percent}% " \
          "share of #{corporation.name} for #{format_currency(price)}"

        @bank.spend(price, entity)
        add_new_share(short)
        add_new_share(share)
      end

      def unshort(entity, share)
        # Share is the positive share bought to cancel the short.
        # The share should be owned by the entity

        shares = entity.shares_of(share.corporation)
        remove_share(share)

        short = shares.find { |s| s.percent == -share.percent }
        remove_share(short)
      end

      def take_loan(entity, loan)
        game_error("Cannot take more than #{maximum_loans(entity)} loans") unless can_take_loan?(entity)
        price = entity.share_price.price
        name = entity.name
        name += " (#{entity.owner.name})" if @round.is_a?(Round::Stock)
        @log << "#{name} takes a loan and receives #{format_currency(loan.amount)}"
        @bank.spend(loan.amount, entity)
        @stock_market.move_left(entity)
        log_share_price(entity, price)
        entity.loans << loan
        @loans.delete(loan)
      end

      def can_take_loan?(entity)
        entity.corporation? &&
          entity.loans.size < maximum_loans(entity) &&
          @loans.any?
      end

      def float_str(_entity)
        '2 shares to start'
      end

      def buying_power(entity)
        return entity.cash unless entity.corporation?

        entity.cash + ((maximum_loans(entity) - entity.loans.size) * @loan_value)
      end

      def liquidate!(corporation)
        @owner_when_liquidated[corporation] = corporation.owner
        @stock_market.move(corporation, 0, 0, force: true)
      end

      def find_share_price(price)
        @stock_market
          .market[0]
          .reverse
          .find { |sp| sp.price <= price }
      end

      def revenue_for(route, stops)
        revenue = super

        revenue += 10 * stops.count { |stop| stop.hex.assigned?('bridge') }

        game_error('Route visits same hex twice') if route.hexes.size != route.hexes.uniq.size

        mine = 'mine'
        if route.hexes.first.assigned?(mine) || route.hexes.last.assigned?(mine)
          game_error('Route cannot start or end with a mine')
        end

        revenue += 10 * route.all_hexes.count { |hex| hex.assigned?(mine) }
        revenue
      end

      def can_go_bankrupt?(player, corporation)
        total_emr_buying_power(player, corporation).negative?
      end

      def total_emr_buying_power(player, _corporation)
        liquidity(player, emergency: true)
      end

      def total_rounds(name)
        # Return the total number of rounds for those with more than one.
        # Merger exists twice since it's logged as the long form, but shown on the UI in the short form
        @operating_rounds if ['Operating', 'Merger', 'Merger and Conversion', 'Acquisition'].include?(name)
      end

      def corporation_size(entity)
        # For display purposes is a corporation small, medium or large
        CORPORATION_SIZES[entity.total_shares]
      end

      def show_corporation_size?(_entity)
        true
      end

      private

      # @todo: unchanged to here

      def new_auction_round
        Round::Auction.new(self, [
          Step::G1867::SingleItemAuction,
        ])
      end

      # @todo: unchanged from here

      def stock_round
        close_bank_shorts
        @interest_fixed = nil

        Round::G1817::Stock.new(self, [
          Step::DiscardTrain,
          Step::HomeToken,
          Step::G1817::BuySellParShares,
        ])
      end

      def operating_round(round_num)
        @interest_fixed = nil
        @interest_fixed = interest_rate
        # Revaluate if private companies are owned by corps with trains
        @companies.each do |company|
          next unless company.owner

          company.abilities(:revenue_change, 'has_train') do |ability|
            company.revenue = company.owner.trains.any? ? ability.revenue : 0
          end
        end

        Round::G1817::Operating.new(self, [
          Step::G1817::Bankrupt,
          Step::G1817::CashCrisis,
          Step::G1817::Loan,
          Step::G1817::SpecialTrack,
          Step::G1817::Assign,
          Step::DiscardTrain,
          Step::G1817::Track,
          Step::Token,
          Step::Route,
          Step::G1817::Dividend,
          Step::G1817::BuyTrain,
        ], round_num: round_num)
      end

      def or_round_finished
        if @depot.upcoming.first.name == '2'
          depot.export_all!('2')
        else
          depot.export!
        end
      end

      def next_round!
        @round =
          case @round
          when Round::Stock
            @operating_rounds = @final_operating_rounds || @phase.operating_rounds
            reorder_players
            new_operating_round
          when Round::Operating
            or_round_finished
            # Store the share price of each corp to determine if they can be acted upon in the AR
            @stock_prices_start_merger = @corporations.map { |corp| [corp, corp.share_price] }.to_h
            @log << "-- #{round_description('Merger and Conversion', @round.round_num)} --"
            Round::G1817::Merger.new(self, [
              Step::G1817::ReduceTokens,
              Step::DiscardTrain,
              Step::G1817::PostConversion,
              Step::G1817::PostConversionLoans,
              Step::G1817::Conversion,
            ], round_num: @round.round_num)
          when Round::G1817::Merger
            @log << "-- #{round_description('Acquisition', @round.round_num)} --"
            Round::G1817::Acquisition.new(self, [
              Step::G1817::ReduceTokens,
              Step::G1817::Bankrupt,
              Step::G1817::CashCrisis,
              Step::DiscardTrain,
              Step::G1817::Acquire,
            ], round_num: @round.round_num)
          when Round::G1817::Acquisition
            if @round.round_num < @operating_rounds
              new_operating_round(@round.round_num + 1)
            else
              @turn += 1
              or_set_finished
              new_stock_round
            end
          when init_round.class
            reorder_players
            new_stock_round
          end
      end

      # @todo: unchanged to here

      def init_loans
        @loan_value = 50
        # @todo: this is wrong, but can be calculated
        70.times.map { |id| Loan.new(id, @loan_value) }
      end

      # @todo: unchanged from here

      def round_end
        Round::G1817::Acquisition
      end

      def custom_end_game_reached?
        @final_operating_rounds
      end

      def final_operating_rounds
        @final_operating_rounds || super
      end

      def event_signal_end_game!
        # If we're in round 1, we have another set of ORs with 2 ORs
        # If we're in round 2, we have another set of ORs with 3 ORs
        @final_operating_rounds = @round.round_num == 2 ? 3 : 2

        @log << "First 8 train bought/exported, ending game at the end of #{@turn + 1}.#{@final_operating_rounds}"
      end
    end
  end
end
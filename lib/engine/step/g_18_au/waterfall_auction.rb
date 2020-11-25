# frozen_string_literal: true

require_relative '../waterfall_auction'

module Engine
  module Step
    module G18AU
      class WaterfallAuction < WaterfallAuction

        def buy_company(player, company, price)
          company.owner = player
          player.companies << company
          player.spend(price, @game.bank) if price.positive?
          if @game.company_becomes_minor?(company)
            price = 180 if price > 180
            @game.bank.spend(price, @game.minor_by_id(company.sym))
          end
          @companies.delete(company)
          @log <<
          case @bidders[company].size
          when 0
            "#{player.name} buys #{company.name} for #{@game.format_currency(price)}"
          when 1
            "#{player.name} wins the auction for #{company.name} "\
              "with the only bid of #{@game.format_currency(price)}"
          else
            "#{player.name} wins the auction for #{company.name} "\
              "with a bid of #{@game.format_currency(price)}"
          end

          company.abilities(:shares) do |ability|
            ability.shares.each do |share|
              if share.president
                @round.company_pending_par = company
              else
                @game.share_pool.buy_shares(player, share, exchange: :free)
              end
            end
          end
        end

      end
    end
  end
end

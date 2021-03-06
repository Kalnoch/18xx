# frozen_string_literal: true

module Engine
  module G1860
    class Bank < Bank
      def initialize(cash, game, log: [])
        @cash = cash
        @game = game
        @log = log
        @broken = false
      end

      def check_cash(amount)
        return unless (@game.bank_cash - amount).negative?

        @log << '-- The bank has broken --' unless @broken
        @broken = true
      end
    end
  end
end

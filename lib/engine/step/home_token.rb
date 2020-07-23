# frozen_string_literal: true

require_relative 'base'
require_relative 'tokener'

module Engine
  module Step
    class HomeToken < Base
      include Tokener
      ACTIONS = %w[place_token].freeze

      def actions(entity)
        return [] unless entity == pending_entity

        ACTIONS
      end

      def round_state
        {
          pending_tokens: [],
        }
      end

      def active?
        pending_entity
      end

      def pending_entity
        pending_token[:entity]
      end

      def token
        pending_token[:token]
      end

      def pending_token
        @round.pending_tokens&.first || {}
      end

      def description
        if current_entity != token.corporation
          "Place #{token.corporation.name} Home Token"
        else
          'Place Home Token'
        end
      end

      def available_hex(hex)
        hex == pending_token[:hex]
      end

      def available_tokens
        [token]
      end

      def process_place_token(action)
        # the action is faked and doesn't represent the actiual token laid
        place_token(
          token.corporation,
          action.city,
          token,
          teleport: true,
        )
        @round.pending_tokens.shift
      end
    end
  end
end

# frozen_string_literal: true

require_relative '../tracker'
require_relative '../track'

module Engine
  module Step
    module G18AU
      class Track < Track
        def setup
          @points_used = 0
        end

        def can_lay_tile?(entity)
          points_available = get_tile_lay(entity) - @points_used
          return false unless points_available > 0
          entity.tokens.any?
        end

        def get_tile_lay(entity)
          return 3 if entity.minor? || entity.total_shares == 4
          return 6 if entity.total_shares == 10
          # return 9 if national
        end

        def lay_tile_action(action)
          tile = action.tile
          metropolis = true if tile.label.to_s != "" && 'ABCLNPS'.include?(tile.label.to_s)
          points_available = get_tile_lay(action.entity) - @points_used
          if tile.color != :yellow && metropolis
            points_cost = 4
          elsif tile.color == :yellow && metropolis || tile.color != :yellow
            points_cost = 2
          else
            points_cost = 1
          end
          @game.game_error('Cannot lay an upgrade now') if tile.color != :yellow && points_cost > points_available
          @game.game_error('Cannot lay a yellow now') if tile.color == :yellow && points_cost > points_available
          lay_tile(action)
          @game.log << "Used #{points_cost} tile point(s) to lay tile"
          @game.log << "#{points_available - points_cost} point(s) remaining"
          @points_used += points_cost
        end
      end
    end
  end
end

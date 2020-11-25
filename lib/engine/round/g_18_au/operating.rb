# frozen_string_literal: true

require_relative '../operating'

module Engine
  module Round
    module G18AU
      class Operating < Operating

        def select_entities
          @game.minor_regional_order + (@game.corporations.select(&:floated?) - @game.minor_regional_order).sort
          # Once I have majors implemented need to do minor/regional
          # in float order then majors in market order
          # + (@game.corporations.select(&:floated?) - @game.class::MINOR_REGIONAL_ORDER).sort
        end

      end
    end
  end
end

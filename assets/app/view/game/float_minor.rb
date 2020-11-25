# frozen_string_literal: true

require 'view/game/actionable'

module View
  module Game
    class FloatMinor < Snabberb::Component
      include Actionable

      needs :selected_company, default: nil, store: true

      def render
        return h(:span) unless (ability = @selected_company&.abilities(:float_minor))

        h(:button, { on: { click: -> { process_action(Engine::Action::FloatMinor.new(@selected_company)) } } }, 'Float Minor')
      end
    end
  end
end

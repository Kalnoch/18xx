# frozen_string_literal: true

require_relative 'base'

module Engine
  module Ability
    class FloatMinor < Base
      attr_reader :corporation, :from

      def setup(minor:)
        @minor = minor
      end
    end
  end
end

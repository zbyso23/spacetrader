# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json/json_api'

class Player::Representer::PlayerInventoryRepresenter < Roar::Decorator
  include Roar::JSON::JSONAPI.resource :inventory

  attributes do
    property :quantity
    property :quality
  end

  has_one :good, class: Good do
    type :good
    attributes do
      property :name
      property :description
    end

    def included?(_options)
      false
    end
  end
end

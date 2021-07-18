module Api
  module V1
    class HealthcheckController < ApplicationController
      def index
        head 200
      end
    end
  end
end

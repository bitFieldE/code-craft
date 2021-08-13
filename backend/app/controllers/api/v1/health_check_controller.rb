module Api
  module V1
    class HealthCheckController < ApplicationController
      def index
        # head 200
        render json: 'Hello'
      end
    end
  end
end

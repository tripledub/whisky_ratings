module Api
  module V1
    class WhiskeysController < ApplicationController
      def index
        json_response(whiskeys)
      end

      def create
        build_whiskey
        save_whiskey
      end

      def show
        json_response(whiskey)
      end

      private

      def build_whiskey
        @whiskey ||= whiskey_scope.build
        @whiskey.attributes = whiskey_params
      end

      def save_whiskey
        @whiskey.save!
        json_response(@whiskey, :created)
      end

      def whiskey
        @whiskey ||= whiskey_scope.find(params[:id])
      end

      def whiskeys
        @whiskeys ||= whiskey_scope.to_a
      end

      def whiskey_scope
        Whiskey.all
      end

      def whiskey_params
        whiskey_params = params[:whiskey]
        whiskey_params ? whiskey_params.permit(
          :title,
          :description,
          :taste,
          :color,
          :smokiness
        ) : {}
      end
    end
  end
end

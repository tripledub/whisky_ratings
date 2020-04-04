class Api::V1::WhiskeysController < ApplicationController
  def index
    render json: whiskeys
  end

  private

  def whiskeys
    @whiskeys ||= whiskey_scope.to_a
  end

  def whiskey_scope
    Whiskey.all
  end
end

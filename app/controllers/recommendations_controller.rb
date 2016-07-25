class RecommendationsController < ApplicationController
  def create
    @recommendation = Recommendation.where(
      user_id: current_user.id,
      business_id: params[:business_id]
    )

    if @recommendation.present?
      @recommendation.value = params[:value]
    else
      @recommendation = Recommendation.new(
        user_id: current_user.id,
        business_id: params[:business_id],
        value: params[:value]
      )
    end

    if @recommendation.save
      render json: {"message":"success"}
    else
      render json: {"message":"failure"}
    end

  end
end

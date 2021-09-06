class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @activities = Activity.where(user_id: current_user.id)

    @monthly = current_user.activities.group_by_month(:created_at, last: 1).group_by_day(:created_at,
                                                                                         format: '%d. %B').sum(:distance)

    #  abort @monthly.inspect

    respond_to do |format|
      format.html
      format.json { render json: @activities }
    end
  end

  def show
    @activity = Activity.find(params[:id])
    @weekly =  current_user.activities.where('created_at > ?', 7.days.ago).sum(:distance).round(2)
    respond_to do |format|
      format.html
      format.json { render json: @weekly }
    end
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = current_user.activities.build(activity_params)
    @activity.distance = DistanceCalc.new(activity_params).calculate

    # abort @activity.inspect

    if @activity.save
      flash[:success] = 'Activity was successfully created.'
      redirect_to @activity
    else
      render 'new'
      flash[:notice] = @activity.errors unless @activity.valid?
    end
  end

  private

  def activity_params
    params.require(:activity).permit(:address1, :address2)
  end
end

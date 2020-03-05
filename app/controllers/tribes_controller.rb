class TribesController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    @tribes = Tribe.all
  end

  def new
    @tribe = Tribe.new
  end

  def create
    @user=User.find(session[:user_id])
    @tribe=Tribe.new(tribe_params)
    @tribe.owner_id=@user.id
    @tribe.save
    @user.tribes<<@tribe
    redirect_to tribe_path(@tribe)
  end

  def show
    @tribe=Tribe.find(params[:id])
    @user= User.find(session[:user_id])
    @rides_sorted = @tribe.rides.sort_by { |r| r['date'] }
  end

  def edit
    @tribe=Tribe.find(params[:id])
    @user= User.find(session[:user_id])
    if !@tribe.owner?(@user)
      redirect_to tribe_path(@tribe)
    end
  end

  def update
    @tribe=Tribe.find(params[:id])
    @tribe.update(tribe_params)
    @tribe.save
    redirect_to tribe_path(@tribe)
  end

  
  private

  def tribe_params
    params.require(:tribe).permit(:name, :image_url, :url, :image )
    end

   

end

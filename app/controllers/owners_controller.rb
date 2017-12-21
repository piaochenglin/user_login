class OwnersController < ApplicationController
  before_action :load_owner, only: [:show, :edit, :update, :destroy]

  def index
    @owners = Owner
                  .select("id,name,email,active")
                  .by_name(params[:name])
                  .by_email(params[:email])
                  .by_active(params[:active])
    # 再写一个render的话，会报Template is missing错误
    # render @owners
  end

  def show
    # @owner = Owner.find(params[:id])
    @owner
  end

  def new
    @owner = Owner.new
  end

  def create
    @owner = Owner.new(owner_params)
    if @owner.save
      redirect_to @owner
    else
      render 'new'
    end
  end

  def edit
    @owner
  end

  def update
    if @owner.update(owner_params)
      redirect_to @owner
    else
      render 'edit'
    end
  end

  def destroy
    @owner = Owner.find(params[:id])
    @owner.deleted_at = Time.now
    if @owner.save!
      redirect_to owners_path
    else
    end

  end

  private
  def owner_params
    params.require(:owner).permit(:name, :email, :sex, :address, :tel, :active)
  end

  def load_owner
    @owner = Owner.find(params[:id])
  end


end

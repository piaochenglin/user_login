class OwnersController < ApplicationController
  before_action :load_owner, only: [:show, :edit, :update, :destroy]

  def index
    page = params[:page]
    @owners = Owner.where(deleted_at: nil)
                  .select("id,name,email,active")
                  .paginate(page: page, per_page: ApplicationController::PAGE_SIZE)
                  .by_id(params[:owner][:id])
                  .by_name(params[:name])
                  .by_email(params[:email])
                  .by_active(params[:active])
    # 再写一个render的话，会报Template is missing错误
    # render @owners
  end

  # 返回json的用法，json型的数据不知道怎么取到select里
  # def list
  #   owners = Owner.where(deleted_at: nil)
  #   owner_list = []
  #   owners.each do |owner|
  #     owner_list << {:key => owner.id, :value => owner.name}
  #   end
  #   # 下面的两种方法都可以，发送json格式，第一种包了一层
  #   # render json: {owner_list: owner_list}
  #   render :json => owner_list.to_json
  # end

  def list
    # @owner_list = Owner.where(deleted_at: nil)
    #                    .select("id,name")
    def list
      owners = Owner.where(deleted_at: nil)
      @owner_list = []
      owners.each do |owner|
        owner_list << {:key => owner.id, :value => owner.name}
      end
      # 下面的两种方法都可以，发送json格式，第一种包了一层
      # render json: {owner_list: owner_list}
      render :json => @owner_list.to_json
    end
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

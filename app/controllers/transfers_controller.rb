class TransfersController < ApplicationController
  before_action :set_transfer, only: [:destroy]

  def index
    @transfers = Transfer.all
  end

  def new
    @transfer = Transfer.new(datetime: DateTime.now)
  end

  def create
    @transfer = Transfer.new(transfer_params)

    respond_to do |format|
      if @transfer.save
        format.html { redirect_to :transfers, notice: 'Transfer was successfully created.' }
        format.json { render :index, status: :created, location: @transfer }
      else
        format.html { render :new }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @transfer.destroy
    respond_to do |format|
      format.html { redirect_to :transfers, notice: 'Transfer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_transfer
    @transfer = Transfer.find(params[:id])
  end

  def transfer_params
    params.fetch(:transfer, {})
    .permit(:datetime, :kind, :parent_id,
      :medium_id, :culture_id, :notes, :count,
      medium:  [ :name, :recipe ],
      culture: [ :name, :collected, :comments, :species ])
  end
end

class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :calculate, :suggest, :close, :plan4dinkum, :addattendee, :update, :destroy]

  # GET /plans
  # GET /plans.json
  def index
    @plans = Plan.all
    @plan = Plan.where(:jahr => Date.today.year).first
    if @plan && @plan.folge 
      @folge = @plan.folge.split(",")
    end
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
    if @plan.folge 
      @folge = @plan.folge.split(",")
    else
      @folge = []
    end
    @auslastung = attendeesload(@folge)
  end

  def plan4dinkum
    @folge = @plan.folge.split(",")
  end

  # GET /plans/new
  def new
    @plan = Plan.new
    # some defaults - should be changed later on
    Plan.last ? @plan.jahr = Plan.last.jahr + 1 : @plan.jahr = Time.now.year + 1
    @plan.start_datum = "#{@plan.jahr}-01-01"
    @plan.end_datum = "#{@plan.jahr}-12-31"
    @plan.wochentage = "1,2,3,4,5,6"
  end

  def addattendee
    if params[:todo] == "tn"
      @plan.attendances.where(user_id: params[:user_id]).first.destroy
    else
      @plan.attendances.create(user_id: params[:user_id])
    end
    redirect_to @plan
  end

  # GET /plans/1/edit
  def edit
  end

  # POST /plans
  # POST /plans.json

  def calculate
    @folge = @plan.calculate
    @auslastung = attendeesload(@folge)
    respond_to do |format|
      format.js
    end
  end

  def suggest
    @plan.update(folge: params[:folge].join(","))
    redirect_to @plan
  end

  def close
    @plan.update(abgenommen: true)
    # attendees dates leeren und mit Weihnachtsdefaults füllen
    redirect_to @plan
  end

  def create
    @plan = Plan.new(plan_params)

    respond_to do |format|
      if @plan.save
        format.html { redirect_to @plan, notice: "Plan was successfully created. Now let's add some attendees." }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to @plan, notice: 'Plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to plans_url, notice: 'Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:jahr, :start_datum, :end_datum, :wochentage, {attendances_attributes: [:id, :plan_id, :user_id, :_destroy]}, :folge, :abgenommen)
    end
end

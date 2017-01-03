class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :edit, :update, :destroy]

  skip_before_filter :current_user #, :configuriert

  def create
    user = User.where(email: params[:email]).first
    if user
      if user.geloescht == true
        redirect_to new_session_url, alert: "Dieser Benutzer wollte nicht mehr!"
      elsif user.authenticate(params[:password])
        session[:user_id] = user.id
        cookies['whosin'] = { 
                :value => user.id,
                :expires => Time.new.at_end_of_month
              }
        redirect_to root_url   # , :notice => "angemeldet"
      else
        redirect_to new_session_url, alert: "Die Login-Daten waren falsch"
      end
    else
      redirect_to new_session_url, alert: "Die Login-Daten waren falsch"
    end
  end
     
  def destroy
    session[:user_id] = nil
    cookies.delete 'whosin'
    redirect_to root_url, notice: "voll abgemeldet"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = Session.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
      params[:session]
    end
end

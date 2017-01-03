class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_filter :configuriert
  before_filter :current_user

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
    @plans = Plan.all.order(:jahr)
  end

  private

  def current_user()
    # User.first
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    elsif cookies['whosin'] && User.find(cookies['whosin'])
      @current_user ||= User.find(cookies['whosin'])
    else
      redirect_to new_session_url, notice: "Bitte erst anmelden."
      return false
    end
  end

  def monate 
    [ "X", "Januar", "Februar", "März", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober"  , "November", "Dezember" ] 
  end
  
  def wochentage
    [ "X", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag" ]
  end

  def attendeesload(folge)
    folge.each_with_object(Hash.new(0)) { |name,anzahl| anzahl[name] += 1}
  end

  # def configuriert
  #   unless Admin.first
  #     redirect_to new_admin_path, notice: "Bitte erstmal die Grundeinstellungen vornehmen."
  #     return false
  #   end
  # end

  helper_method :current_user, :attendeesload, :monate, :wochentage #, :configuriert
end

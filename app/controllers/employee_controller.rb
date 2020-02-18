class EmployeeController < ApplicationController
  
  before_action :already_paired, :only => [:spinner, ]
    require 'csv'
    def index
      # render plain: "hello"
    end

    def login
      @employee = Employee.find_by_email(employee_params[:email].strip)

      if @employee == nil
        flash[:error] = "email does not exist please check and try again"
        redirect_to employee_path
      elsif @employee.paired_with != 0
        @pair = Employee.find(@employee.paired_with)
        flash[:error] = "Hi #{@employee.name} You have already been paired with #{@pair.name} in #{@pair.department}"
        redirect_to employee_path
      else
        session[:id] = @employee.id
        redirect_to employee_match_path
      end
    end

    def spinner
      @user = Employee.find(session[:id])
     
      if @user.sex == 'male' and @user.paired_with == 0
        @people = Employee.where("sex = ? AND paired_with = ?","female", 0)
        person = rand(@people.length)
        @person =   @people[person]

        # render plain: @person.inspect
        if @person != nil
          @update_person = Employee.find(@person.id)
          @update_person['paired_with'] = @user.id
          @user['paired_with'] = @person.id
          @update_person.save
          @user.save
          # render plain:"hi! #{@user.name}"
        else
          # render plain: "females are scare! they are all taken!"
        end
      elsif @user.sex == 'female' and @user.paired_with == 0
        @people = Employee.where("sex = ? AND paired_with = ?", "male", 0)
        person = rand(@people.length)
        @person =   @people[person]
        if @person != nil
          @update_person = Employee.find(@person.id)
          @update_person['paired_with'] = @user.id
          @user['paired_with'] = @person.id
          @update_person.save
          @user.save
          # render plain: @person.inspect
      else
        # render plain: "male are scare! they are all taken!"
      end
   
    end
  end

    def match
    end

    def update
      render plain: "updater!"
    end
      
    def paired
      @user = Employee.find(session[:id])
      @pair = Employee.find(@user.paired_with)
      # render plain: 'paired'
    end

    def employee_params
      params.require(:employee).permit(:email)
    end
end

# <% if @person.sex == 'male' %>
#   <div class="girl-pic guy-pic"></div>
#       <div class="white-bg">
#           <h3>Your Outsource Val Details</h3>
#           <p>Full Name: <strong><%= @person.name %></strong></p>
#           <p>Department: <strong><%= @person.department %></strong></p>
#       </div>
#   </div>
#   <% else %>
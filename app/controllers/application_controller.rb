class ApplicationController < ActionController::Base
    helper_method :already_paired

    def already_paired
        @user = Employee.find(session[:id])
        if @user.paired_with != 0
            redirect_to employee_path
            @pair = Employee.find(@user.paired_with)
            flash[:error] = "Hi #{@user.name} You have already been paired with #{@pair.name} in #{@pair.department}"
        end
    end
end

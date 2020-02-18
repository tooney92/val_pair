class AdminController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "Pa55worD123"
    require 'csv'
  layout "import"

    def index
      @employees = Employee.all
    end
  
    def import
      og_employees = CSV.read(params[:file], headers: true)
      @females = 0
      @males = 0
      og_employees.each do |og_employee|
        if og_employee['sex'] == 'female'
          @females += 1
        elsif og_employee['sex'] == 'male'
          @males += 1
        end
        @employee = Employee.new
        Employee.create({name: og_employee['name'], email: og_employee['email'], sex: og_employee['sex'], department: og_employee['department'], paired_with: 0})
      end
      @employees = Employee.all
      redirect_to admin_csv_path
    end

    def empty
      Employee.delete_all
      redirect_to admin_csv_path
    end

    def update
      @person = Employee.new
      @person['name'] = employee_params['name']
      @person['email'] = employee_params['email'].strip
      @person['sex'] = employee_params['sex']
      @person['department'] = employee_params['department']
      @person['paired_with'] = 0
      if @person.save
        flash[:success] = "#{@person.name}, addedd sucessfully!"
        redirect_to admin_csv_path
      else
        flash[:error] = "#{@person.email}, already exists! user not saved!"
        redirect_to admin_csv_path
      end

    end

    def change
      @user = Employee.find_by_email(employee_params['email'].strip)
      if @user.paired_with != 0 
        @formerpair = Employee.find(@user.paired_with)
        @formerpair.paired_with = 0
        @formerpair.save
        @user.name = employee_params['name']
        @user.sex = employee_params['sex']
        # @user['gender'] = employee_params['email']
        @user.department = employee_params['department']
        @user.paired_with = 0
        if @user.save
          flash[:success] = "#{@user.name}, reset sucessfully!"
          redirect_to admin_csv_path
        # render plain: @formerpair.inspect + ' ' + @user.inspect
        end
      else
        @user.name = employee_params['name']
        @user.sex = employee_params['sex']
        @user.department = employee_params['department']
        @user.paired_with = 0
        if @user.save
          flash[:success] = "#{@user.name}, reset sucessfully!"
          redirect_to admin_csv_path
        end
      end
    end


    def edit_employee
      @employees = Employee.all
      count = 0
      @employees.each do |employee|
          employee_params = {}
          @employee = Employee.find(employee['id'])
          employee_params['name'] = employee['name']
          employee_params['sex'] = employee['sex']
          employee_params['department'] = employee['department']
          employee_params['email'] = employee['email'].strip
          @employee.update(employee_params)
      end
      render plain: "Done"
     end
    #  def custom_nnamdi
    #   @
    #  end
    private

      def employee_params
        params.require(:employee).permit(:name, :email, :sex, :department, :paired_with)
      end


end

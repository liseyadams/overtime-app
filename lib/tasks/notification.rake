namespace :notification do
  desc "Sends SMS notification to employees asking them to log if they had overtime or not"
  task sms: :environment do
    if Time.now.sunday?
        employees = Employee.all
        notification_message = "Please log into the overtime management dashboard to request ovetime or confirm your hours for last week: https://elise-overtime.herokuapp.com"
        # 1. Schedule to run at Sunday at 5pm
    # 2. Iterate over all employees
    # 3. Skip AdminUsers
    # 4. Send a message that has instructions and a link to log time
    employees.each do |employee|
        AuditLog.create!(user_id: employee.id)
      SmsTool.send_sms(number: employee.phone, message: notification_message)
    end
    # number: "555-555-3323"
    # number: "5555553323"
    # No spaces or dashes
    # exactly 10 characters
    # all characters have to be a number
    end
  end

  desc "Sends mail notification to managers (admin users) each day to inform of pending overtime requests"
  task manager_email: :environment do
    # 1. Iterate over the list of pending overtime requests
    # 2. Check to see if there are any requests
    # 3. Iterate over the list of admin users/managers
    # 4. Send the email to each admin
    submitted_posts = Post.submitted
    admin_users = AdminUser.all

    if submitted_posts.count > 0 
        admin_users.each do |admin|
            ManagerMailer.email(admin).deliver_later
        end
    end
  end
end

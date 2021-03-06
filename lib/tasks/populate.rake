namespace :db do
  desc "Populate database with seed data"
  task populate: :environment do
    [User, Tenant, Category, LoanRequest, Loan].each(&:delete_all)

    user_quantity         = 200_000
    tenant_quantity       = 30_000
    category_quantity     = 15
    loan_request_quantity = 500_000
    loan_quantity         = 50_000

    puts "Creating #{tenant_quantity} tenants"

    Tenant.populate tenant_quantity do |tenant|
      tenant.name = tenant.id.to_s + Faker::Name.name
      tenant.slug = tenant.name.parameterize
      tenant.blurb = Faker::Internet.domain_word
      tenant.description = Faker::Hacker.say_something_smart
    end

    @tenant_count = Tenant.count
    puts "Tenants generated"

    #===========================================================================

    puts "Creating #{user_quantity} users"

    User.populate user_quantity do |user|
      user.first_name      = Faker::Name.name
      user.username        = Faker::Internet.user_name
      user.email           = user.id.to_s + Faker::Internet.safe_email(user.first_name)
      user.password_digest = "$2a$10$orSVnNUCDWHnkOWIL92kuONrG6yEyK5916wTgqj1kWLhrhgMN3V7."
      user.tenant_id       = rand(1..@tenant_count)
    end

    @user_count = User.count
    puts "Users generated"

    #===========================================================================

    puts "Creating #{category_quantity} categories"

    Category.populate category_quantity do |category|
      category.name        = Faker::Commerce.department(1, true) + category.id.to_s
      category.description = Faker::Commerce.product_name
      category.slug        = category.name.parameterize
    end

    @category_count = Category.count
    puts "Categories generated"

    #===========================================================================

    puts "Creating #{loan_request_quantity} loan requests"

    LoanRequest.populate loan_request_quantity do |loan_request|
      loan_request.user_id = rand(1..@user_count)
      loan_request.title = Faker::Commerce.product_name
      loan_request.blurb = Faker::Internet.domain_word
      loan_request.description = Faker::Hacker.say_something_smart
      loan_request.requested_by_date = DateTime.now
      loan_request.payments_begin_date = rand(41..61).days.from_now
      loan_request.payments_end_date = rand(100..182).days.from_now
      loan_request.borrowing_amount = rand(50..1000)
      loan_request.amount_funded = rand(1..49)
      loan_request.status = "open"
      loan_request.image_url = ["http://www.kiva.org/img/w632/1867090.jpg",
                                "http://www.kiva.org/img/w632/1876504.jpg",
                                "http://www.kiva.org/img/w632/1883529.jpg",
                                "http://www.kiva.org/img/w632/1859815.jpg",
                                "http://www.kiva.org/img/w632/1847429.jpg"].sample

      LoanRequestCategory.create(loan_request_id: loan_request.id, category_id: rand(1..@category_count))
    end

    @loan_request_count = LoanRequest.count
    puts "LoanRequests generated"

    #===========================================================================

    puts "Creating #{loan_quantity} loans"

    Loan.populate loan_quantity do |loan|
      loan.user_id = rand(1..@user_count)
      loan.loan_request_id = rand(1..@loan_request_count)
      loan.amount = rand(50..1000)
      loan.status = ["ordered", "completed", "canceled", "paid"].sample
    end

    puts "Loans generated"
  end
end

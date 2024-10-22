require "sinatra"
require "sinatra/reloader"

get("/howdy") do
  erb(:hello)
end

get("/") do
  "
  <h1>Welcome to your Sinatra App!</h1>
  <p>Define some routes in app.rb</p>
  "
end

get("/square/new") do
  erb(:new_square_calc)
end

get ("/square/results") do
  @the_num = params.fetch("users_number").to_f

  @the_result = @the_num ** 2
  erb(:square_results)
end

get("/square_root/new") do
  erb(:square_root_new)
end

get("/square_root/results") do
  @the_num = params.fetch("users_number").to_f

  @the_result = Math.sqrt(@the_num).round(3)
  erb(:results_square_root)
end

get("/random/new") do
  erb(:random_new)
end

get("/random/results") do
  @the_min = params.fetch("user_min").to_f
  @the_max = params.fetch("user_max").to_f
  
  @the_result = rand(@the_min..@the_max)

  erb(:random_results)
  
end

get ("/payment/new") do
  erb(:payment_new)
end

get ("/payment/results") do
  @the_apr = params.fetch("user_apr").to_f / 100 / 12
  @the_years = params.fetch("user_years").to_f
  @the_pv = params.fetch("user_pv").to_f
  n = @the_years * 12

  # Calculate the numerator and denominator separately for debugging
  @numerator = @the_apr * @the_pv
  @denominator = 1 - (1 + @the_apr) ** (-n)
  
  # Calculate the monthly payment using the formula
  if @the_apr == 0
    # If the APR is 0, the formula simplifies to pv/n
    @the_payment = @the_pv / n
  else
    # Using the full formula when APR is not 0
    @the_payment = (@numerator / @denominator).to_fs(:currency)
  end

  erb(:payment_results)
end

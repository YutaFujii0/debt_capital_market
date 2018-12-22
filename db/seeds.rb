# Delete all data only if it's development environment
if Rails.env.development?
  User.destroy_all
  Issuer.destroy_all
  Investor.destroy_all
  Deal.destroy_all
end

if LargeCodes.all.empty?

end

if SmallCodes.all.empty?

end

if LargeCategory.all.empty?

end

# Create users <origination>


# Create users <syndicate>


# Create users <sales>


# Create issuers


# Create investors


# Create deals
# Create tranches
# Create very important investors
# Create marketings
# Create feedbacks
# Create orders

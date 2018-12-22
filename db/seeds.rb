

# Delete all data only if it's development environment
if Rails.env.development?
  puts "Deleting User instances"
  User.destroy_all
  # puts "Deleting Issuer instances"
  # Issuer.destroy_all
  # puts "Deleting Investor instances"
  # Investor.destroy_all
  puts "Deleting Deal instances"
  Deal.destroy_all
end

if LargeCode.all.empty?
  puts "Create LargeCode model"
  csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
  file_path = File.expand_path("../../lib/assets/stocklist.csv", __FILE__)

  CSV.foreach(file_path, csv_options) do |row|
    name_read = row["業種分類"]
    LargeCode.create(name: name_read) unless LargeCode.find_by(name: name_read)
  end
  puts "Finished"
end

# Create small_code if there's no record
if SmallCode.all.empty?
  puts "Create SmallCode model"
  csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
  file_path = File.expand_path("../../lib/assets/stocklist.csv", __FILE__)

  CSV.foreach(file_path, csv_options) do |row|
    name_read = row["業種分類"]
    # this is temporary code
    large_code = LargeCode.find_by(name: name_read)
    unless SmallCode.find_by(name: name_read)
      instance = SmallCode.new(name: name_read)
      instance.large_code = large_code
      instance.save!
    end
  end
  puts "Finished"
end

# Create investor code
data = {
    "生損保": ["生保", "損保"],
    "銀行": ["都市銀行", "ネット銀行", "地方銀行"],
    "系統": ["系統上部", "系統下部"],
    "中央公的": ["中央公的"],
    "地方公的": ["地方公的"],
    "投信・投資顧問": ["投信・投資顧問"],
    "外人": ["外人"]
  }
if LargeInvestorCategory.all.empty?
  puts "Create LargeInvestorCategory"
  data.keys.each do |key|
    LargeInvestorCategory.create(name: key) unless LargeInvestorCategory.find_by(name: key)
  end
  puts "Finished"
end

if SmallInvestorCategory.all.empty?
  puts "Create SmallInvestorCategory"
  data.each do |key, value|
    large_investor_category = LargeInvestorCategory.find_by(name: key)
    value.each do |element|
      unless SmallInvestorCategory.find_by(name: element)
        instance = SmallInvestorCategory.new(name: element)
        instance.large_investor_category = large_investor_category
        instance.save!
      end
    end
  end
  puts "Finished"
end

# Create users <origination>
# Create users <syndicate>
# Create users <sales>
User::ROLE.each do |key, value|
  puts "Create User #{key}"
  10.times do
    gimei = Gimei.name
    email_head = gimei.first.romaji + gimei.last.romaji
    attributes = {
      email: Faker::Internet.email(email_head),
      password: "123456",
      first_name: gimei.first.kanji,
      last_name: gimei.last.kanji,
      tel: "03-1234-" + Faker::PhoneNumber.subscriber_number,
      role: value
    }
    instance = User.create(attributes)
  end
  puts "Finished"
end

# Create issuers
if Issuer.all.empty?
  puts "Create Issuer"
  csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
  file_path = File.expand_path("../../lib/assets/stocklist.csv", __FILE__)

  CSV.foreach(file_path, csv_options) do |row|
    name_read = row["銘柄名"]
    # this is temporary code
    small_code = SmallCode.find_by(name: row["業種分類"])
    unless Issuer.find_by(name: name_read)
      instance = Issuer.new(name: name_read)
      instance.small_code = small_code
      instance.save!
    end
  end
  puts "Finished"
end

# Create investors
if Investor.all.empty?
  puts "Create investor"
    csv_options = { col_sep: '.', quote_char: '"', headers: :first_row}
    file_path = File.expand_path("../../lib/assets/qib.csv", __FILE__)

    CSV.foreach(file_path, csv_options) do |row|
      name_read = row["商号等"]
      small_investor_category = SmallInvestorCategory.all.sample
      address = Gimei.address

      attributes = {
        name: name_read,
        team: "Credit",
        small_investor_category_id: small_investor_category.id,
        address: address.kanji,
        tel: "03-8888-" + Faker::PhoneNumber.subscriber_number,
        email: Faker::Internet.email
      }

    end
  puts "Finished"
end

# Create deals
# Create tranches
# Create very important investors
# Create marketings
# Create feedbacks
# Create orders

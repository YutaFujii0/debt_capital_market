

# Delete all data only if it's development environment
if Rails.env.development?
  # puts "Deleting User instances"
  # User.destroy_all
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
  if User.where(role: value).empty?
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
      Investor.create(attributes)
    end
  puts "Finished"
end

# Create UserInvestors(assign sales)
puts "Create UserInvestor"
Investor.all.each do |investor|
  if investor.users.empty?
    2.times do |index|
      attributes = {
        user_id: User.where(role: 2).sample.id,
        investor_id: investor.id,
        main: index == 0
      }
      UserInvestor.create!(attributes)
    end
  end
end

# Create UserIssuers(assign origination)
puts "Create UserIssuer"
Issuer.all.each do |issuer|
  if issuer.users.empty?
    3.times do |index|
      attributes = {
        user_id: User.where(role: 0).sample.id,
        issuer_id: issuer.id,
        main: index == 0
      }
      UserIssuer.create!(attributes)
    end
  end
end

# ============== Deal related models ===============================
# Create deal category
if DealCategory.all.empty?
  puts "Create DealCategory model"
  DealCategory.create(name: ["事業債", "財投機関債", "地方債", "政府保証債", "サムライ債"])
  puts "Finished"
end

# Treasury.destroy_all
# Create treasury
if Treasury.all.empty?
  puts "Create Treasury model"
  # 10.times do
    attributes = {
      serial_id: 360,
      tenor: 10,
      issue: Date.today,
      maturity: Date.today.since(10.years),
      coupon: 0.0005,
      payment_per_an: 2,
      cmp_interest: 0.0005
    }
    Treasury.create!(attributes)
  # end
  puts "Finished"
end

# Create underwriters
if Underwriter.all.empty?
  puts "Create Underwriter"
  data = [
    {name: "野村證券", abbreviation: "野村"},
    {name: "三菱UFJモルガン・スタンレー証券", abbreviation: "三菱"},
    {name: "SMBC日興証券", abbreviation: "日興"},
    {name: "みずほ証券", abbreviation: "みずほ"},
    {name: "大和証券", abbreviation: "大和"},
    {name: "東海東京証券", abbreviation: "東海東京"},
    {name: "ゴールドマン・サックス証券", abbreviation: "GS"},
    {name: "メリルリンチ証券", abbreviation: "メリル"}
  ]
  Underwriter.create!(data)
  puts "Finished"
end


# Create deals
# Create tranches
# Create very important investors
# Create marketings
# Create feedbacks
# Create orders

today = Date.today
px_dates = [today.next_month, today.next_month.since(2.days), today.next_month.since(3.days), today.next_month.since(4.days),]

# deals
10.times do
  puts "Create deal"
  px = px_dates.sample
  attributes = {
    issuer_id: Issuer.all.sample.id,
    deal_category_id: DealCategory.all.sample.id,
    pricing: px,
    settlement: px.since(5.days)
  }
  deal = Deal.create!(attributes)

  # Create UserDeal model(assign syndicate)
  2.times do |index|
    attributes = {
      deal_id: deal.id,
      user_id: User.where(role: 1).sample.id,
      main: index == 0
    }
    UserDeal.create!(attributes)
  end

  # tranches
  puts "Create tranches"
  (rand(3) + 1).times do
    attributes = {
      deal_id: deal.id,
      treasury_id: Treasury.all.sample.id,
      tenor: [3, 5, 7, 10, 20, 30].sample,
      volume: [50, 100, 150, 200, 250].sample,
      interest_type: Tranche::INTEREST_TYPE[1], # fixed interest
      # coupon: , fixed later
      restriction: Tranche::RESTRICTION[rand(4)],
      # spread: , fixed later
      book_runners: Underwriter.all.sample(rand(3) + 1).map {|i| i.id},
      portion: 0.4,
      management_fee: 5,
      underwriting_fee: 5,
      sales_fee: 12
    }
    tranche = Tranche.create!(attributes)

    # VII
    investors = Investor.all.sample(5)

    puts "Create VIIs"
    5.times do |index|
      attributes = {
        tranche_id: tranche.id,
        investor_id: investors[index].id
      }
      VeryImportantInvestor.create!(attributes)
    end

    # marketings
    marketing_str = ["主幹事プレマ②", "主幹事プレマ①", "ソフトヒアリング②", "ソフトヒアリング①"]
    strategy = ["様子見", "1億成行優先", "フリーゼロ"]
    volume = ["150億円", "150億円程度" , "150億円程度", "100億円程度"]
    range = (20..30).to_a
    investors = Investor.all.sample(10)

    puts "Create Marketings"
    4.times do |index|
      attributes = {
        tranche_id: tranche.id,
        date: deal.pricing.ago((index + 1).days),
        marketing: marketing_str[index],
        volume: volume[index],
        range: range.slice(rand(11 - index - 1) , index + 1),
        strategy: strategy.sample
      }
      marketing = Marketing.create!(attributes)

      # feedbacks
      comment = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Magnam doloremque dolor, eum a, deleniti corporis possimus consequatur cupiditate molestias ipsa illum non sunt nam at sequi facere aut rerum. Reprehenderit?"

      puts "Create Feedbacks"
      10.times do |index|
        attributes = {
          marketing_id: marketing.id,
          investor_id: investors[index].id,
          comment: comment,
          volume: [1, 3, 5, 7, 10, 20, 30].sample,
          intent: (1..5).to_a.sample
        }
        feedback = Feedback.create!(attributes)

        # order
        puts "Create Orders"
        if rand(2) == 0
          attributes = {
            feedback_id: feedback.id,
            spread: marketing.range[0],
            volume: feedback.volume
          }
          Order.create!(attributes)
        end
      end
    end

    tranche.spread = tranche.marketings.first.range[0]
    tranche.coupon = tranche.reckon_coupon
    tranche.save!
  end

end

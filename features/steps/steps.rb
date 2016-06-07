Given(/^there are no properties$/) do
  Spotippos::Property.delete_all
end

Given(/^exists property with x "([^"]*)" and y "([^"]*)"$/) do |x, y|
  prop = Spotippos::Property.new({ "x"=> x.to_i,
                                   "y"=> y.to_i,
                                   "title"=>"Imovel codigo 1, com 5 quartos e 4 banheiros",
                                   "price"=>1250000,
                                   "description"=>"Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                   "beds"=>4,
                                   "baths"=>3,
                                   "square_meters"=>210 })
  prop.save
end

Given(/^I add properties with the following attributes:$/) do |table|
  data = table.raw
  data.shift
  data.each do |row|
    prop = Spotippos::Property.new({ "x"=> row[0].to_i,
                                     "y"=> row[1].to_i,
                                     "title"=> row[2],
                                     "price"=> row[3],
                                     "description"=> row[4],
                                     "beds"=> row[5].to_i,
                                     "baths"=> row[6].to_i,
                                     "square_meters"=> row[7].to_i })
     prop.save
     prop.id = row[8].to_i if row[8]
     prop.save
  end
end

When(/^I send a POST request to "([^"]*)" with:$/) do |path, body|
  post path, body
end

When(/^I send a POST request to "([^"]*)" without params$/) do |path|
  post path
end

When(/^I send a GET request to "([^"]*)"$/) do |path|
  get path
end

Then(/^the status code response should be "([^"]*)"$/) do |status_code|
  expect(last_response.status).to eq status_code.to_i
end

Then(/^the property should be created$/) do
  response = JSON.parse(last_response.body)
  prop = Spotippos::Property.find(response['id'].to_i)
  expect(prop).not_to be_nil
end

Then(/^the response body with the following JSON:$/) do |response_json|
  response = JSON.parse(last_response.body)
  expect(response).to include(JSON.parse(response_json))
end

Then(/^the response should have error for "([^"]*)" with "([^"]*)"$/) do |attribute, message|
  response = JSON.parse(last_response.body)["errors"][attribute]
  expect(response).to include(message)
end

Then(/^the response should have error "([^"]*)"$/) do |message|
  response = JSON.parse(last_response.body)["errors"]
  expect(response).to include(message)
end

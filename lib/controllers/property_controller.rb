class Spotippos::PropertyController < Sinatra::Base

  post '/' do
    begin
      params = JSON.parse(request.body.read)
      prop = Spotippos::Property.new(params.slice('x','y', 'title', 'price', 'description', 'beds', 'baths', 'squareMeters'))

      if prop.valid? && !prop.exists!
        prop.id = increment_id
        prop.provinces = Spotippos::ProvinceHelper.find_provinces(prop.x, prop.y)
        $properties << prop
        halt 201, { id: prop.id }.to_json
      else
        halt 400, { errors: prop.errors.messages }.to_json
      end
    rescue Spotippos::PropertyAlreadyExist
      halt 409, { errors: 'property already exists' }.to_json
    end
  end

  get '/:id' do
    prop = $properties.select{ |p| p.id == params[:id].to_i }.first

    if prop
        halt 200, prop.to_json
    else
        halt 404, { errors: 'property not found' }.to_json
    end
  end

  get '/' do
    upper_left_x = params['ax'].to_i
    upper_left_y = params['ay'].to_i
    bottom_right_x = params['bx'].to_i
    bottom_right_y = params['by'].to_i

    properties_selected = $properties.select { |p| p.x >= upper_left_x && p.x <= bottom_right_x && p.y >= bottom_right_y && p.y <= upper_left_y }
    halt 200, { foundProperties: properties_selected.length, properties: properties_selected }.to_json
  end

  private

  def increment_id
    max = $properties.max {|a, b| a.id <=> b.id }
    if max
        max.id + 1
    else
        1
    end
  end
end

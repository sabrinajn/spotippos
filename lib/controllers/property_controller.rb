class Spotippos::PropertyController < Sinatra::Base

  post '/' do
    begin
      body = request.body.read
      if body.empty?
        params = {}
      else
        params = JSON.parse(body)
      end

      prop = Spotippos::Property.new(params.slice('x','y', 'title', 'price', 'description', 'beds', 'baths'))
      prop.square_meters = params['squareMeters']

      if prop.valid? && !prop.exists!
        prop.save
        halt 201, { id: prop.id }.to_json
      else
        halt 400, { errors: prop.errors.messages }.to_json
      end
    rescue Spotippos::PropertyAlreadyExist
      halt 409, { errors: 'property already exists' }.to_json
    end
  end

  get '/:id' do
    begin
      prop = Spotippos::Property.find(params[:id])
      
      halt 200, prop.to_json
    
    rescue ActiveRecord::RecordNotFound
      halt 404, { errors: 'property not found' }.to_json
    end
  end

  get '/' do
    upper_left_x = params['ax'].to_i
    upper_left_y = params['ay'].to_i
    bottom_right_x = params['bx'].to_i
    bottom_right_y = params['by'].to_i

    properties_selected = Spotippos::Property.all.select { |p| p.x >= upper_left_x && p.x <= bottom_right_x && p.y >= bottom_right_y && p.y <= upper_left_y }
    halt 200, { foundProperties: properties_selected.length, properties: properties_selected }.to_json
  end
end

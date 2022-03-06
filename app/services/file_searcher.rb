class FileSearcher
  require "json"

  class << self

    def read_file_and_search_services(data)
      file_data = read_file
      selected_values = file_data.select do |service|
        if service['name'].include?(data[:name])
          service['score'] = calculate_score(service['name'], data[:name])
          service['distance'] = calculate_distance(service['position'], data[:latitude], data[:longitude])
        end
      end
      { totalHits: selected_values.count, totalDocuments: file_data.count, results: selected_values }
    end

    def read_file
      json_from_file = File.read("data.json")
      JSON.parse(json_from_file)
    end

    def calculate_score(hash_string, input_string)
      "#{((input_string.length / hash_string.length.to_f) * 100).to_i}%"
    end

    def calculate_distance(hash_distance_object, param_latitude, param_longitude)
      Geocoder::Calculations.distance_between([hash_distance_object['lat'], hash_distance_object['lng']], [param_latitude, param_longitude]).round(1)
    end

  end

end

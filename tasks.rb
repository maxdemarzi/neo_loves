require 'bundler'
Bundler.require

require 'csv'

class Tasks
  extend GluttonRatelimit

  def initialize
    @neo = Neography::Rest.new
  end

  #<CSV::Row "Store ID":"723" "Name":"Safeway - Burnaby #44" "Brand":"Starbucks"
  # "Store Number":"79644-107081" "Phone Number":"6042912901" "Ownership Type":"LS"
  # "Street Combined":"6564 East Hastings St" "Street 1":"6564 East Hastings St"
  # "Street 2":nil "Street 3":nil "City":"Burnaby" "Country Subdivision":"BC" "Country":"CA"
  # "Postal Code":"V5B 1S2" "Coordinates":"(49.2795295715332, -122.967216491699)"
  # "Latitude":"49.2795295715332" "Longitude":"-122.96721649169922" "Timezone":"Pacific Standard Time"
  # "Current Timezone Offset":"-420" "Olson Timezone":"GMT-08:00 America/Vancouver"
  # "First Seen":"12/08/2013 10:41:59 PM">

  def import
    @neo.create_spatial_index("CoffeeShops", "point", "latitude", "longitude")

    file = "./data/All_Starbucks_Locations_in_the_World.csv"
    queue = []
    counter = 0
    CSV.foreach(file, headers:true) do |row|
      next unless row.has_key?("Latitude") && row.has_key?("Longitude")
      next if (row["Latitude"].nil? && row["Longitude"].nil?)
      next if (row["Latitude"].strip == "" )  || (row["Longitude"].strip == "" )
      shop[:latitude]  = row["Latitude"]
      shop[:longitude] = row["Longitude"]
      shop[:name]      = row["Name"]
      shop[:address]   = row["Street Combined"]
      shop[:city]      = row["City"]
      shop[:state]     = row["Country Subdivision"]
      shop[:country]   = row["Country"]
      shop[:zip]       = row["Postal Code"]
      queue << [:create_node, shop]
      queue << [:add_node_to_spatial_index, "CoffeeShops", "{#{counter}}"]
      counter += 2

      if counter / 1000 == 0
        @neo.batch *queue
      end
    end

  end

  def importold
    @neo.create_spatial_index("CoffeeShops", "point", "latitude", "longitude")

    Dir.glob('data/combined/*.json') do |json_file|
      restaurants = JSON.load(File.open(json_file, 'r'))
      queue = []
      counter = 0
      restaurants.each_value do |restaurant|
        next unless restaurant.has_key?("latitude") && restaurant.has_key?("longitude")
        restaurant.delete("category_labels")
        queue << [:create_node, restaurant]
        queue << [:add_node_to_spatial_index, "restaurants", "{#{counter}}"]
        counter += 2
      end
      puts "File: #{json_file} Restaurants: #{counter/2}"
      @neo.batch *queue
    end

  end

end
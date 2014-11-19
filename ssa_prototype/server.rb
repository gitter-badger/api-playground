require 'sinatra'    # the library that powers the server (e.g. get '/' do...)
require 'pry'        # debugger
require 'open-uri'   # HTTP library for fetching the CSV file
require 'csv'        # parses the CSV
require 'json'       # encodes JSON

# convenience function, cribbed from:
# http://stackoverflow.com/questions/6005139/ruby-1-9-2-read-and-parse-a-remote-csv
def read(url)
  data = []
  CSV.new(open(url), headers: :true).each do |line|
    data << line
  end
  
  data
end

get '/' do
  year = params["year"]  # /?year=2012
  data = read("http://ssa.gov/open/data/fy12-onward-rib-filed-via-internet.csv")
    
  if year
    return data.select {|row| row[0] == year}.to_json
  else
    return data.to_json
  end
end

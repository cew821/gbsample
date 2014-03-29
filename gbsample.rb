require 'sinatra'
require "sinatra/config_file"
require 'greenbutton'

config_file 'config.yml'

get '/greenbutton' do
  # @url = params[:source]
  @url = "https://services.greenbuttondata.org/DataCustodian/espi/1_1/resource/Batch/RetailCustomer/1/UsagePoint"
  @collected_data = get_green_button_data_from(@url)
  erb :greenbutton
end



def get_green_button_data_from(url)
  # gb = GreenButton.load_xml_from_file('fixtures/sample_data.xml')
  gb = GreenButton.load_xml_from_web(url)
  puts "successfully loaded the file"
  response = get_array_of_monthly_values(gb)
  response
end

def get_array_of_monthly_values(gb)
  interval_blocks = gb.usage_points.first.meter_readings.first.interval_blocks
  interval_length = gb.usage_points.first.meter_readings.first.reading_type.interval_length
  start_time = Time.new(2013,1,1,0,0,0)
  end_time   = Time.new(2014,1,31,23,59,59)

  timecursor = start_time
  month = 1
  month_total = 0
  results = {}

  while timecursor < end_time
    current_month = timecursor.month
    if current_month != month
      puts "finished parsing month #{month.to_s}. The total was #{month_total.to_s}"
      results[month] = month_total
      month = current_month
      month_total = 0
    end

    interval_blocks.each do |block|
      if timecursor >= block.start_time && timecursor < block.end_time
        reading = block.reading_at_time(timecursor)
        month_total += reading.value
        break
      end
    end

    timecursor += interval_length
  end

  results
end
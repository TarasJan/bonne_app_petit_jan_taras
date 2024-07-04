# frozen_string_literal: true
module CSVProducers
  class Product
    attr_reader :source_data

    def initialize(source_data)
      @source_data = source_data
    end

    def produce_csv!
      products = CSV.generate do |csv|
        csv << ["name"]
        transformed_data.each do |data_row|
          csv << [data_row[:name]]
        end
      end

      File.open('db/products.csv', 'w') do |file| 
        file.write(products) 
      end
    end

    private

    def transformed_data
      puts "imterpreting products..."
      starting = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      data = source_data.pluck('ingredients').flatten.map do |description|
        DescriptionInterpreter.new(description).with_product_name.call
      end
      ending = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      puts ending - starting
      data
    end
  end
end

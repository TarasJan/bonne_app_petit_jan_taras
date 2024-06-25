# frozen_string_literal: true

namespace :recipes do
  AVAILABLE_LOCALES = %w[en fr].freeze
  PENNYLANE_S3_URL = 'https://pennylane-interviewing-assets-20220328.s3.eu-west-1.amazonaws.com'

  desc 'Download recipes from Pennylane Server'
  task :download, [:locale] => :environment do |_t, args|
    args.with_defaults(locale: 'en')
    task_logger = Logger.new($stdout)

    unless AVAILABLE_LOCALES.include?(args[:locale])
      abort("Detected wrong locale: #{args.locale}. Pennylane only provides assets in following locale: #{AVAILABLE_LOCALES}}")
    end

    task_logger.info('Starting download of recipes from Pennylane S3 Server...')
    task_logger.info("Locale of the assets to be downloaded: #{args[:locale]}")

    sh "wget #{PENNYLANE_S3_URL}/recipes-#{args[:locale]}.json.gz -O tmp/recipes-#{args[:locale]}.json.gz && gzip -dc tmp/recipes-#{args[:locale]}.json.gz > tmp/recipes.json" do |ok, _res|
      if ok
        task_logger.info 'Download complete. Recipes assets to be found in tmp/recipes.json'
      else
        task_logger.error 'Failed to download asset files. Make sure you have wget and gzip installed'
      end
    end
  end

  desc 'Remove downloaded recipes files'
  task :clear, :environment do |_t, _args|
    Dir.glob('tmp/recipes*') { |f| File.delete(f) }
  end

  desc 'Generate Database seeds from downloaded files'
  task :generate_seeds, :environment do |t, args|
    begin
      file = File.read("tmp/recipes.json")
      data = JSON.parse(file)
    rescue => error
      abort(error) 
    end
    # TODO: 

    
  end
end

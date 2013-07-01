providers = %w(twitter facebook linkedin).inject([]) do |providers, provider|
  fpath = Rails.root.join('config', "#{provider}.yml")
 
  if File.exists?(fpath)
    begin
      config = YAML.load_file(fpath)
      providers << [ provider, config['consumer_key'], config['consumer_secret'] ]
    rescue Exception => exc
      puts "Warning,#{exc.message}"
    end
  end
 
  providers
end
 
raise 'You have not created config/twitter.yml or config/facebook.yml or config/linkedin.yml' if providers.empty?
 
Rails.application.config.middleware.use OmniAuth::Builder do
  providers.each do |p|
    provider *p
  end
end
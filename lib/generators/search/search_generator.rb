require 'rails/generators/named_base'

class SearchGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :model_name, type: :string, required: true
  argument :attributes, type: :hash, required: false
  
  def generate_searcher
    template  'searcher.rb', "app/searchers/#{model_name.underscore}_searcher.rb"
  end
  
  def generate_search_form
    template  'advanced_search.html.haml', "app/views/#{model_name.pluralize.underscore}/_advanced_search.html.haml"
  end
  
  def generate_yml_file
    template  'en.yml', "config/locales/models/#{model_name.underscore}/en.yml"
  end
  
  def inject_searcher_params
    inject_into_file("app/controllers/#{model_name.pluralize.underscore}_controller.rb", :after => 'private') do 
      searcher_params_content
    end
  end
  
  private

  def get_attributes
    @attributes ||= argument.collect do |attribute|
      Rails::Generator::GeneratedAttribute.new(*attribute.split(":"))
    end
  end
  
  def searcher_params_content
    buffer = <<-CONTENT
    
    def search_params
      params.require(:#{model_name.underscore}_searcher).permit( #{symbolize_attribute})
    end 
    CONTENT
    buffer
  end
  
  
  def symbolize_attribute
    f = ""
    get_attributes.each do |k, v|
      if k.include?("humanize_model@")
      elsif k.include?("bet1")
        k = k.chomp("bet1")
        f = f + ":from_#{k}, "
        f = f + ":to_#{k}, "
      elsif k.include?("bet$")
          k = k.chomp("bet$")
          f = f + ":from_#{k}, "
          f = f + ":to_#{k}, "
      elsif k.include?("e$")
        k = k.chomp("e$")
        f = f+":#{k}, "
      elsif k.include?("page@")
        k = k.chomp("@")
        f = f+":#{k}, "
      elsif k.include?("approval_status@")
        k = k.chomp("@")
        f = f+":#{k}, "
      else
        f = f+":#{k}, "
      end
    end
    f.chomp(", ")
  end
  
  
  def between_attributes
    between_attributes = []
    get_attributes.each do |k, v|
      if k.include?("bet1")
        k = k.chomp("bet1")
        between_attributes << ["#{k}", "from_#{k}" ,"to_#{k}"]
      end
    end
    between_attributes
  end
  
  def between_date_time_attributes
    between_date_time_attributes = []
    get_attributes.each do |k, v|
      if k.include?("bet$")
        k = k.chomp("bet$")
        between_date_time_attributes << ["#{k}", "from_#{k}" ,"to_#{k}"]
      end
    end
    between_date_time_attributes
  end
end

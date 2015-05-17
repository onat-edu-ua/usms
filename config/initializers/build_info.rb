Usms::Application.config.build_info =  YAML.load_file(File.join(Rails.root, 'version.yml')) rescue {}

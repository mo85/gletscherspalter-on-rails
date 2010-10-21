require "yaml"

# Load global configs
APP_CONFIG = YAML::load_file("#{Rails.root}/config/config.yml")
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{declarative_authorization}
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Steffen Bartsch"]
  s.date = %q{2010-09-12}
  s.email = %q{sbartsch@tzi.org}
  s.extra_rdoc_files = ["README.rdoc", "CHANGELOG"]
  s.files = ["CHANGELOG", "MIT-LICENSE", "README.rdoc", "Rakefile", "authorization_rules.dist.rb", "garlic_example.rb", "init.rb", "app/controllers/authorization_rules_controller.rb", "app/controllers/authorization_usages_controller.rb", "app/helpers/authorization_rules_helper.rb", "app/views/authorization_usages/index.html.erb", "app/views/authorization_rules/index.html.erb", "app/views/authorization_rules/_show_graph.erb", "app/views/authorization_rules/_change.erb", "app/views/authorization_rules/_suggestions.erb", "app/views/authorization_rules/graph.dot.erb", "app/views/authorization_rules/change.html.erb", "app/views/authorization_rules/graph.html.erb", "config/routes.rb", "lib/declarative_authorization.rb", "lib/declarative_authorization/in_controller.rb", "lib/declarative_authorization/reader.rb", "lib/declarative_authorization/rails_legacy.rb", "lib/declarative_authorization/obligation_scope.rb", "lib/declarative_authorization/railsengine.rb", "lib/declarative_authorization/in_model.rb", "lib/declarative_authorization/helper.rb", "lib/declarative_authorization/development_support/analyzer.rb", "lib/declarative_authorization/development_support/change_analyzer.rb", "lib/declarative_authorization/development_support/change_supporter.rb", "lib/declarative_authorization/development_support/development_support.rb", "lib/declarative_authorization/authorization.rb", "lib/declarative_authorization/maintenance.rb", "lib/tasks/authorization_tasks.rake", "test/authorization_test.rb", "test/schema.sql", "test/maintenance_test.rb", "test/model_test.rb", "test/controller_test.rb", "test/helper_test.rb", "test/dsl_reader_test.rb", "test/controller_filter_resource_access_test.rb", "test/test_helper.rb"]
  s.homepage = %q{http://github.com/stffn/declarative_authorization}
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.6")
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{declarative_authorization is a Rails plugin for authorization based on readable authorization rules.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

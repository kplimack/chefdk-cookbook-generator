
context = ChefDK::Generator.context
cookbook_dir = File.join(context.cookbook_root, context.cookbook_name)
test_cookbook_name = "#{context.cookbook_name}_test"

# cookbook root dir
directory cookbook_dir

# Testing Directories
directory "#{cookbook_dir}/spec/unit/recipes" do
  action :create
  recursive true
end
directory "#{cookbook_dir}/files/default/test/" do
  action :create
  recursive true
end
directory "#{cookbook_dir}/test/cookbooks/#{test_cookbook_name}/recipes" do
  action :create
  recursive true
end

# Test Files
template "#{cookbook_dir}/spec/unit/recipes/default_spec.rb" do
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end
template "#{cookbook_dir}/spec/spec_helper.rb" do
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end
template "#{cookbook_dir}/files/default/test/default_test.rb" do
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end
template "#{cookbook_dir}/files/default/test/minitest_helper.rb" do
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end
template "#{cookbook_dir}/test/cookbooks/#{test_cookbook_name}/recipes/default.rb" do
  source "default_recipe.rb.erb"
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
  variables cookbook_name: "#{test_cookbook_name}"
end
template "#{cookbook_dir}/test/cookbooks/#{test_cookbook_name}/metadata.rb" do
  source "test_cookbook_metadata.rb.erb"
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# metadata.rb
template "#{cookbook_dir}/metadata.rb" do
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# README
template "#{cookbook_dir}/README.md" do
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# Change Log
template "#{cookbook_dir}/CHANGELOG.md" do
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# chefignore
cookbook_file "#{cookbook_dir}/chefignore"

# Foodcritic customizations
cookbook_file "#{cookbook_dir}/.foodcritic"

# Berks
template "#{cookbook_dir}/Berksfile" do
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# TK
template "#{cookbook_dir}/.kitchen.yml" do
  source 'kitchen.yml.erb'
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# Bundler
cookbook_file "#{cookbook_dir}/Gemfile" do
  action :create_if_missing
end

# Rubocop
cookbook_file "#{cookbook_dir}/.rubocop.yml" do
  action :create_if_missing
end

# Recipes

directory "#{cookbook_dir}/recipes"

template "#{cookbook_dir}/recipes/default.rb" do
  source "default_recipe.rb.erb"
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

template "#{cookbook_dir}/LICENSE" do
  source "LICENSE.#{context.license}.erb"
  helpers(ChefDK::Generator::TemplateHelper)
  action :create_if_missing
end

# git
if context.have_git
  if !context.skip_git_init

    execute("initialize-git") do
      command("git init .")
      cwd cookbook_dir
    end
  end

  cookbook_file "#{cookbook_dir}/.gitignore" do
    source "gitignore"
  end
end

# frozen_string_literal: true

name 'pulledpork'

run_list 'test::default'

cookbook 'pulledpork', path: '.'
cookbook 'test', path: './test/fixtures/cookbooks/test'
cookbook 'ark',
         git: 'https://github.com/sous-chefs/ark.git',
         branch: 'main'
cookbook 'snort',
         git: 'https://github.com/sous-chefs/snort.git',
         branch: 'main'
cookbook 'seven_zip',
         git: 'https://github.com/sous-chefs/seven_zip.git',
         branch: 'main'
cookbook 'yum-epel',
         git: 'https://github.com/sous-chefs/yum-epel.git',
         branch: 'main'

Dir.children('./test/fixtures/cookbooks/test/recipes').grep(/\.rb\z/).sort.each do |recipe|
  recipe_name = File.basename(recipe, '.rb')

  named_run_list recipe_name.to_sym, "test::#{recipe_name}"
end

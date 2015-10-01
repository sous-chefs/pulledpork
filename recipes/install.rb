

# install packages needed by pulledpork
package node['pulledpork']['dependencies']

ark 'pulledpork' do
  url node['pulledpork']['artifact_url']
  version node['pulledpork']['version']
  has_binaries %w(pulledpork.pl)
end

# fix bad permissions in the tarball
file "/usr/local/pulledpork-#{node['pulledpork']['version']}/pulledpork.pl" do
  mode '0755'
end

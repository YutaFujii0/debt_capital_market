# Be sure to restart your server when you modify this file.

# ActiveSupport::Reloader.to_prepare do
#   ApplicationController.renderer.defaults.merge!(
#     http_host: 'example.org',
#     https: false
#   )
# end
ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.irregular 'tranche', 'tranches'
end

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
page '/*.atom', layout: false

activate :blog do |blog|
  blog.permalink = "{year}/{month}/{day}/{title}.html"
  blog.layout = 'blog_layout'
end

activate :directory_indexes

# the block config `activate :asset_hash do |opts|` doesn't work for
# `asset_hash` as the values are set after the config block is yielded.
activate :asset_hash, exts: config[:asset_extensions] - %w(.ico) + %w(.json)

activate :livereload

helpers do
  def inline_svg(name)
    File.read(File.join('source', 'images', "#{name}.svg"))
  end
end

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :gzip do |options|
    options.exts << '.json'
  end
  activate :imageoptim
end

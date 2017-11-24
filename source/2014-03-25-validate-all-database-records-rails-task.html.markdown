---
title: validate all database records rails task
date: 2014-03-25 08:43:56 UTC
---

Sometimes you need to validate all your active record entries in the database.
This may happen when you update validations in your models and you want to
check which models need an update. Or you have a legacy system that has invalid
records. Or some other system wrote to the database (without the rails
application’s validation).

Here’s a rake task that validates all database rows for all the `ActiveRecord`
models in your rails application.

<pre><code class="language-ruby">
namespace :db do
  namespace :data do
    desc 'Validates all records in the database'
    task :validate =&gt; :environment do
      original_log_level = ActiveRecord::Base.logger.level
      ActiveRecord::Base.logger.level = 1

      puts 'Validate database (this will take some time)...'

      Dir["#{Rails.root}/app/models/**/*.rb"].each { |f| require "#{ f }" }

      ActiveRecord::Base.subclasses.
        reject { |type| type.to_s.include? '::' }. # subclassed classes are not our own models
        each do |type|
          begin
            type.find_each do |record|
              unless record.valid?
                puts "#&lt;#{ type } id: #{ record.id }, errors: #{ record.errors.full_messages }&gt;"
              end
            end
          rescue Exception =&gt; e
            puts "An exception occurred: #{ e.message }"
          end
        end

      ActiveRecord::Base.logger.level = original_log_level
    end
  end
end
</code></pre>

And here’s the [whole thing as a
gist](https://gist.github.com/koffeinfrei/8931935).

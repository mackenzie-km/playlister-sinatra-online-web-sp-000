# require 'sinatra'
# require './config/environment'
#
# require_relative 'app/controllers/artists_controller'
# require_relative 'app/controllers/genres_controller'
# require_relative 'app/controllers/songs_controller'
# require_relative 'app/controllers/application_controller'
#
#
# begin
#   fi_check_migration
#
#   use Rack::MethodOverride
#   run ApplicationController
# rescue ActiveRecord::PendingMigrationError => err
#   STDERR.puts err
#   exit 1
# end
#
#
# use ArtistsController
# use GenresController
# use SongsController
# run ApplicationController

require './config/environment'

# if ActiveRecord::Migrator.needs_migration?
#   raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
# end

use Rack::MethodOverride
use ArtistsController
use GenresController
use SongsController
run ApplicationController

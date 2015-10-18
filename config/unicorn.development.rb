worker_processes 4
# listen "127.0.0.1:3000", backlog: 1024
timeout 60
pid "tmp/usms-unicorn.pid"
stderr_path "log/development.log"
stdout_path "log/development.log"
preload_app true

GC.copy_on_write_friendly = true if GC.respond_to?(:copy_on_write_friendly=)

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end


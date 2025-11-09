# config/puma.rb
max_threads_count = ENV.fetch(" RAILS_MAX_THREADS") {  5 }min_threads_count = ENV.fetch("R AILS_MIN_THREADS") { m ax_threads_count }
threads min _threads_count, max_threads_count

port ENV.f etch("PORT ") { 3000 }
environment ENV.fe tch("RAILS _ENV") { "prod uction" }
pidfile ENV.fet ch("PIDFIL E") { "tmp/p ids/server.pid" }
workers ENV.fetch ("WEB_CONC URRENCY") { 2 }
prel oad _app!

plugin :tmp_restart 

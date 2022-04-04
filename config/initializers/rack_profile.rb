# Rack::MiniProfiler.config.start_hidden = true
if defined?(Rack::MiniProfiler)
  Rack::MiniProfiler.config.auto_inject = false
end
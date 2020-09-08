if ENV['CIRCUIT_BREAKER'] == 'true'
  Semian::NetHTTP.semian_configuration = proc do
    {
      bulkhead: false,
      success_threshold: 2,
      error_threshold: 2,
      error_timeout: 60,
      name: "circuit_breaker"
    }
  end
end
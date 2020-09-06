class ApplicationController < ActionController::Base
  def slow_request
    log_around('Request HTTP Lenta') do
      RestClient.get('localhost:8080/slow')
    end
    render_response
  end

  def noop
    log_around('Operacion nula') do
      # Do nothing
    end
    render_response
  end

  def slow_calc
    log_around('Operación matemática lenta') do
      expensive_calculation
    end
    render_response
  end

  private

  def log(message)
    Rails.logger.info "[TID: #{Thread.current.object_id}] #{message}"
  end

  def log_around(message)
    log "Iniciando <#{message}>"
    yield
    log "<#{message}> finalizada"
  end

  def expensive_calculation
    100.times do |i|
      1000000.downto(1) do |j|
        Math.sqrt(j) * i / 0.2
      end
    end
  end

  def render_response
    render json: { thread: Thread.current.object_id }
  end
end

class ApplicationController < ActionController::Base
  def slow_request
    log_around('Request HTTP Lenta') do
      RestClient::Request.execute(method: :get, url: 'localhost:8080/slow', timeout: 6)
    end
    render_successful_response
    rescue StandardError => error
      render_error_response(error)
  end

  def noop
    log_around('Operacion nula') do
      # Do nothing
    end
    render_successful_response
  end

  def slow_calc
    log_around('Operación matemática lenta') do
      expensive_calculation
    end
    render_successful_response
  end

  private

  def log(message)
    Rails.logger.info "#{Time.now} - TID: #{Thread.current.object_id} - #{message}"
  end

  def log_around(message)
    log "Iniciando <#{message}>"
    yield
  ensure
    log "<#{message}> finalizada"
  end

  def expensive_calculation
    100.times do |i|
      1000000.downto(1) do |j|
        Math.sqrt(j) * i / 0.2
      end
    end
  end

  def render_successful_response
    render json: { success: true, thread: Thread.current.object_id }
  end

  def render_error_response(error)
    render status: :service_unavailable, json: { success: false, error: error.message, thread: Thread.current.object_id }
  end
end

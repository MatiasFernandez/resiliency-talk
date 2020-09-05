class ApplicationController < ActionController::Base
  def affected
    log 'Procesando /affected'
    log_around('Request HTPP') do
      RestClient.get('localhost:8080/slow')
    end
    render json: { success: true, thread: Thread.current.object_id }
  end

  def unaffected
    log 'Procesando /unaffected'
    render json: { success: true, thread: Thread.current.object_id }
  end

  private

  def log(message)
    Rails.logger.info "[TID: #{Thread.current.object_id}] #{message}"
  end

  def log_around(message)
    log "ANTES DE #{message}"
    yield
    log "DESPUES DE #{message}"
  end
end

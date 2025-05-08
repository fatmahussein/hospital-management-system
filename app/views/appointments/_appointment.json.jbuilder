json.extract! appointment, :id, :patient_id, :date, :time, :status, :reason, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)

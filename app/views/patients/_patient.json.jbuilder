json.extract! patient, :id, :name, :phone, :age, :gender, :created_at, :updated_at
json.url patient_url(patient, format: :json)

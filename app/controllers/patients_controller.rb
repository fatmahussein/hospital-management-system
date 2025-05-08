class PatientsController < ApplicationController
  before_action :set_patient, only: %i[ show edit update destroy ]

  # GET /patients or /patients.json
  def index
    @patients = Patient.all
    respond_to do |format|
      format.html # renders normally if not Turbo
      format.turbo_stream { render partial: "patients/index", layout: false } # optional fallback
    end
  end

  # GET /patients/1 or /patients/1.json
  def show
    @patient = Patient.find(params[:id])
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
  

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients or /patients.json
  def create
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.save
        format.html { redirect_to patients_path, notice: "Patient was successfully created." }
        format.turbo_stream do
          @patients = Patient.all
          render turbo_stream: turbo_stream.replace("main_content", partial: "patients/index", locals: { patients: @patients })
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1 or /patients/1.json
  def update
    if @patient.update(patient_params)
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace("main_content", partial: "patients/index", locals: { patients: Patient.all })
        }
        format.html { redirect_to patients_path, notice: "Patient updated successfully." }
      end
    else
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace("main_content", partial: "patients/form", locals: { patient: @patient })
        }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end
  

  # DELETE /patients/1 or /patients/1.json
  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy
  
    respond_to do |format|
      format.html { redirect_to patients_path, notice: "Patient was successfully deleted." }
      format.turbo_stream do
        @patients = Patient.all
        render turbo_stream: turbo_stream.replace("main_content", partial: "patients/index", locals: { patients: @patients })
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def patient_params
      params.expect(patient: [ :name, :phone, :age, :gender ])
    end
end

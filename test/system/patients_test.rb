require "application_system_test_case"

class PatientsTest < ApplicationSystemTestCase
  setup do
    @patient = patients(:one)
  end

  test "visiting the index" do
    visit patients_url
    assert_selector "h1", text: "Patients"
  end

  test "should create patient" do
    visit patients_url
    click_on "New patient"

    fill_in "Age", with: @patient.age
    fill_in "Gender", with: @patient.gender
    fill_in "Name", with: @patient.name
    fill_in "Phone", with: @patient.phone
    click_on "Create Patient"

    assert_text "Patient was successfully created"
    click_on "Back"
  end

  test "should update Patient" do
    visit patient_url(@patient)
    click_on "Edit this patient", match: :first

    fill_in "Age", with: @patient.age
    fill_in "Gender", with: @patient.gender
    fill_in "Name", with: @patient.name
    fill_in "Phone", with: @patient.phone
    click_on "Update Patient"

    assert_text "Patient was successfully updated"
    click_on "Back"
  end

  test "should destroy Patient" do
    visit patient_url(@patient)
    accept_confirm { click_on "Destroy this patient", match: :first }

    assert_text "Patient was successfully destroyed"
  end
end

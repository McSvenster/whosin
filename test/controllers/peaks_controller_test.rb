require 'test_helper'

class PeaksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @peak = peaks(:one)
  end

  test "should get index" do
    get peaks_url
    assert_response :success
  end

  test "should get new" do
    get new_peak_url
    assert_response :success
  end

  test "should create peak" do
    assert_difference('Peak.count') do
      post peaks_url, params: { peak: { participation_id: @peak.participation_id, peakformula: @peak.peakformula, peakimage: @peak.peakimage, peaksign: @peak.peaksign } }
    end

    assert_redirected_to peak_url(Peak.last)
  end

  test "should show peak" do
    get peak_url(@peak)
    assert_response :success
  end

  test "should get edit" do
    get edit_peak_url(@peak)
    assert_response :success
  end

  test "should update peak" do
    patch peak_url(@peak), params: { peak: { participation_id: @peak.participation_id, peakformula: @peak.peakformula, peakimage: @peak.peakimage, peaksign: @peak.peaksign } }
    assert_redirected_to peak_url(@peak)
  end

  test "should destroy peak" do
    assert_difference('Peak.count', -1) do
      delete peak_url(@peak)
    end

    assert_redirected_to peaks_url
  end
end

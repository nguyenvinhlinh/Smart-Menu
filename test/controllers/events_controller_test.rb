require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: { accept_email: @event.accept_email, address: @event.address, decline_email: @event.decline_email, host_email: @event.host_email, name: @event.name, occur_date: @event.occur_date, pending_email: @event.pending_email }
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event
    assert_response :success
  end

  test "should update event" do
    patch :update, id: @event, event: { accept_email: @event.accept_email, address: @event.address, decline_email: @event.decline_email, host_email: @event.host_email, name: @event.name, occur_date: @event.occur_date, pending_email: @event.pending_email }
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_path
  end
end

require 'test_helper'

class InquiriesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Inquiry.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Inquiry.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Inquiry.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to inquiry_url(assigns(:inquiry))
  end
  
  def test_edit
    get :edit, :id => Inquiry.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Inquiry.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Inquiry.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Inquiry.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Inquiry.first
    assert_redirected_to inquiry_url(assigns(:inquiry))
  end
  
  def test_destroy
    inquiry = Inquiry.first
    delete :destroy, :id => inquiry
    assert_redirected_to inquiries_url
    assert !Inquiry.exists?(inquiry.id)
  end
end

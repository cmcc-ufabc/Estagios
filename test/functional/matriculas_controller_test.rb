require 'test_helper'

class MatriculasControllerTest < ActionController::TestCase
  setup do
    @matricula = matriculas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:matriculas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create matricula" do
    assert_difference('Matricula.count') do
      post :create, matricula: { aluno_id: @matricula.aluno_id, disciplina_id: @matricula.disciplina_id, periodo_id: @matricula.periodo_id, situacao: @matricula.situacao }
    end

    assert_redirected_to matricula_path(assigns(:matricula))
  end

  test "should show matricula" do
    get :show, id: @matricula
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @matricula
    assert_response :success
  end

  test "should update matricula" do
    put :update, id: @matricula, matricula: { aluno_id: @matricula.aluno_id, disciplina_id: @matricula.disciplina_id, periodo_id: @matricula.periodo_id, situacao: @matricula.situacao }
    assert_redirected_to matricula_path(assigns(:matricula))
  end

  test "should destroy matricula" do
    assert_difference('Matricula.count', -1) do
      delete :destroy, id: @matricula
    end

    assert_redirected_to matriculas_path
  end
end

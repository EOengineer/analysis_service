defmodule AnalysisService.AnalysisControllerTest do
  use AnalysisService.ConnCase

  alias AnalysisService.Analysis
  @valid_attrs %{complete: true, data_tree: "some content", description: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, analysis_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    analysis = Repo.insert! %Analysis{}
    conn = get conn, analysis_path(conn, :show, analysis)
    assert json_response(conn, 200)["data"] == %{"id" => analysis.id,
      "data_tree" => analysis.data_tree,
      "description" => analysis.description,
      "complete" => analysis.complete}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, analysis_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, analysis_path(conn, :create), analysis: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Analysis, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, analysis_path(conn, :create), analysis: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    analysis = Repo.insert! %Analysis{}
    conn = put conn, analysis_path(conn, :update, analysis), analysis: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Analysis, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    analysis = Repo.insert! %Analysis{}
    conn = put conn, analysis_path(conn, :update, analysis), analysis: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    analysis = Repo.insert! %Analysis{}
    conn = delete conn, analysis_path(conn, :delete, analysis)
    assert response(conn, 204)
    refute Repo.get(Analysis, analysis.id)
  end
end

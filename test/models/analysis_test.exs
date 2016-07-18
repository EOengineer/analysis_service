defmodule AnalysisService.AnalysisTest do
  use AnalysisService.ModelCase

  alias AnalysisService.Analysis

  @valid_attrs %{complete: true, data_tree: "some content", description: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Analysis.changeset(%Analysis{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Analysis.changeset(%Analysis{}, @invalid_attrs)
    refute changeset.valid?
  end
end

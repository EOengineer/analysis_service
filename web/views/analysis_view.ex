defmodule AnalysisService.AnalysisView do
  use AnalysisService.Web, :view

  def render("index.json", %{analyses: analyses}) do
    %{data: render_many(analyses, AnalysisService.AnalysisView, "analysis.json")}
  end

  def render("show.json", %{analysis: analysis}) do
    %{data: render_one(analysis, AnalysisService.AnalysisView, "analysis.json")}
  end

  def render("analysis.json", %{analysis: analysis}) do
    %{id: analysis.id,
      data_tree: analysis.data_tree,
      description: analysis.description,
      complete: analysis.complete}
  end
end

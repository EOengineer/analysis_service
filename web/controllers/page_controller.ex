defmodule AnalysisService.PageController do
  use AnalysisService.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

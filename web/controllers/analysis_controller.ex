defmodule AnalysisService.AnalysisController do
  use AnalysisService.Web, :controller

  alias AnalysisService.Analysis

  plug :scrub_params, "analysis" when action in [:create, :update]

  def index(conn, _params) do
    analyses = Repo.all(Analysis)
    render(conn, "index.json", analyses: analyses)
  end

  def create(conn, %{"analysis" => analysis_params}) do
    changeset = Analysis.changeset(%Analysis{}, analysis_params)

    case Repo.insert(changeset) do
      {:ok, analysis} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", analysis_path(conn, :show, analysis))
        |> render("show.json", analysis: analysis)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(AnalysisService.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    analysis = Repo.get!(Analysis, id)
    render(conn, "show.json", analysis: analysis)
  end

  def update(conn, %{"id" => id, "analysis" => analysis_params}) do
    analysis = Repo.get!(Analysis, id)
    changeset = Analysis.changeset(analysis, analysis_params)

    case Repo.update(changeset) do
      {:ok, analysis} ->
        render(conn, "show.json", analysis: analysis)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(AnalysisService.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    analysis = Repo.get!(Analysis, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(analysis)

    send_resp(conn, :no_content, "")
  end
end

defmodule AnalysisService.Repo.Migrations.CreateAnalysis do
  use Ecto.Migration

  def change do
    create table(:analyses) do
      add :data_tree, :string
      add :description, :string
      add :complete, :boolean, default: false

      timestamps
    end

  end
end

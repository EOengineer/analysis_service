ExUnit.start

Mix.Task.run "ecto.create", ~w(-r AnalysisService.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r AnalysisService.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(AnalysisService.Repo)


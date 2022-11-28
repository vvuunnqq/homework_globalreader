defmodule Management.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :job_id, :string
      add :job_title, :string
      add :description, :string
      add :user_id, references(:users)

      timestamps()
    end

    create unique_index(:jobs, [:job_id])
  end
end

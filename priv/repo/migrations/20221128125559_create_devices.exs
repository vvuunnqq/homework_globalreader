defmodule Management.Repo.Migrations.CreateDevices do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :device_id, :string
      add :device_name, :string
      add :description, :string
      add :user_id, references(:users)

      timestamps()
    end

    create unique_index(:devices, [:device_id])
  end
end

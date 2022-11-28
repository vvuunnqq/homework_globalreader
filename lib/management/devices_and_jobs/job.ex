defmodule Management.DevicesAndJobs.Job do
  use Ecto.Schema
  import Ecto.Changeset

  schema "jobs" do
    field :description, :string
    field :job_id, :string
    field :job_title, :string
    belongs_to :user, Management.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(job, attrs) do
    job
    |> cast(attrs, [:job_id, :job_title, :description, :user_id])
    |> validate_required([:job_id, :job_title, :description, :user_id])
    |> unique_constraint(:job_id)
  end
end

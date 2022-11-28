defmodule Management.DevicesAndJobs.Device do
  use Ecto.Schema
  import Ecto.Changeset

  schema "devices" do
    field :description, :string
    field :device_id, :string
    field :device_name, :string
    belongs_to :user, Management.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(device, attrs) do
    device
    |> cast(attrs, [:device_id, :device_name, :description, :user_id])
    |> validate_required([:device_id, :device_name, :description, :user_id])
    |> unique_constraint(:device_id)
  end
end

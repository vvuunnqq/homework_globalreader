defmodule ManagementWeb.DeviceLive.FormComponent do
  use ManagementWeb, :live_component

  alias Management.DevicesAndJobs

  @impl true
  def update(%{device: device} = assigns, socket) do
    changeset = DevicesAndJobs.change_device(device)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"device" => device_params}, socket) do
    changeset =
      socket.assigns.device
      |> DevicesAndJobs.change_device(device_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"device" => device_params}, socket) do
      save_device(socket, socket.assigns.action, device_params)
  end

  defp save_device(socket, :edit, device_params) do
    case DevicesAndJobs.update_device(socket.assigns.device, device_params) do
      {:ok, _device} ->
        {:noreply,
         socket
         |> put_flash(:info, "Device updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_device(socket, :new, device_params) do
    case DevicesAndJobs.create_device(device_params) do
      {:ok, _device} ->
        {:noreply,
         socket
         |> put_flash(:info, "Device created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end

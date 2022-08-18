defmodule Budgeroo.Budget do
  @moduledoc """
  The Budget context.
  """

  import Ecto.Query, warn: false
  alias Budgeroo.Repo

  alias Budgeroo.Budget.Envelope

  @doc """
  Returns the list of envelopes.

  ## Examples

      iex> list_envelopes()
      [%Envelope{}, ...]

  """
  def list_envelopes do
    Repo.all(Envelope)
  end

  @doc """
  Gets a single envelope.

  Raises `Ecto.NoResultsError` if the Envelope does not exist.

  ## Examples

      iex> get_envelope!(123)
      %Envelope{}

      iex> get_envelope!(456)
      ** (Ecto.NoResultsError)

  """
  def get_envelope!(id), do: Repo.get!(Envelope, id)

  @doc """
  Creates a envelope.

  ## Examples

      iex> create_envelope(%{field: value})
      {:ok, %Envelope{}}

      iex> create_envelope(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_envelope(attrs \\ %{}) do
    %Envelope{}
    |> Envelope.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a envelope.

  ## Examples

      iex> update_envelope(envelope, %{field: new_value})
      {:ok, %Envelope{}}

      iex> update_envelope(envelope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_envelope(%Envelope{} = envelope, attrs) do
    envelope
    |> Envelope.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a envelope.

  ## Examples

      iex> delete_envelope(envelope)
      {:ok, %Envelope{}}

      iex> delete_envelope(envelope)
      {:error, %Ecto.Changeset{}}

  """
  def delete_envelope(%Envelope{} = envelope) do
    Repo.delete(envelope)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking envelope changes.

  ## Examples

      iex> change_envelope(envelope)
      %Ecto.Changeset{data: %Envelope{}}

  """
  def change_envelope(%Envelope{} = envelope, attrs \\ %{}) do
    Envelope.changeset(envelope, attrs)
  end
end

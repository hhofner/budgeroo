defmodule Budgeroo.BudgetFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Budgeroo.Budget` context.
  """

  @doc """
  Generate a envelope.
  """
  def envelope_fixture(attrs \\ %{}) do
    {:ok, envelope} =
      attrs
      |> Enum.into(%{
        amount: 42,
        goal: 42,
        group: "some group",
        name: "some name"
      })
      |> Budgeroo.Budget.create_envelope()

    envelope
  end
end

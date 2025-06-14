defmodule Pento.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pento.Catalog.Product

  alias Pento.Survey.Rating

  schema "products" do
    field(:description, :string)
    field(:name, :string)
    field(:sku, :integer)
    field(:unit_price, :float)
    field(:image_upload, :string)
    timestamps()
    has_many(:ratings, Rating)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :unit_price, :sku, :image_upload])
    |> validate_required([:name, :description, :unit_price, :sku])
    |> unique_constraint(:sku)
    |> validate_number(:sku, greater_than: 100_00)
    |> validate_number(:sku, less_than: 1_000_000)
    |> validate_number(:unit_price, greater_than: 0.0)
  end

  def markdown_product_changeset(%Product{unit_price: current_unit_price} = product, attrs) do
    product
    |> cast(attrs, [:unit_price])
    |> validate_required([:unit_price])
    |> validate_number(:unit_price, less_than: current_unit_price)
    |> validate_number(:unit_price, greater_than: 0.0)
  end
end

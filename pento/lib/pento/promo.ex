defmodule Pento.Promo do
  alias Pento.Promo.Recipient
  alias Pento.Accounts.UserNotifier

  def change_recipient(%Recipient{} = recipient, attrs \\ %{}) do
    Recipient.changeset(recipient, attrs)
  end

  def send_promo(recipient) do
    # send email to promo recipient
    # exercise for the reader
    IO.inspect(recipient)
    UserNotifier.deliver_promotion(recipient["recipient"]["email"])
    {:ok, %Recipient{}}
  end
end

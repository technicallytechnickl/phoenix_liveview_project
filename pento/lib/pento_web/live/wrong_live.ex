defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, session, socket) do
    # this code will replaced by on_mount later on in this chapter!
    {:ok, assign(socket, score: 0, message: "Make a guess:", time: time(), answer: 1..10|>Enum.random(),
      session_id: session["live_socket_id"])}
  end

  def render(assigns) do
  ~H"""
  <h1 class="mb-4 text-4xl font-extrabold">Your score: {@score}</h1>
  <h2>
  {@message}
  It's {@time}
  </h2>

  <br />
  <h2>
  <%= for n <- 1..10 do %>
  <.link
  class="bg-blue-500 hover:bg-blue-700
  text-white font-bold py-2 px-4 border border-blue-700 rounded m-1"
  phx-click="guess"
  phx-value-number={n}
  >
  {n}
  </.link>
  <% end %>
  </h2>
  <br />
  <pre>
  {@current_user.username}
  {@session_id}
  </pre>
  """
  end

  def time() do
  DateTime.utc_now |> to_string
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    time = time()
    answer = socket.assigns.answer
    score = socket.assigns.score
    {guess_int, _} = Integer.parse(guess)

    IO.inspect({guess_int, answer})

    cond do
      guess_int == answer ->
        message =
        "Your guess: #{guess}. Correct! Try again."
        answer = 1..10|>Enum.random()
        score = score + 10
        {
          :noreply,
          assign(
            socket,
            message: message,
            score: score,
            time: time,
            answer: answer
          )
        }
      true ->

        message =
        "Your guess: #{guess}. Wrong. Guess again. "
        score = socket.assigns.score - 1
        {
          :noreply,
          assign(
            socket,
            message: message,
            score: score,
            time: time,
            answer: answer
          )
        }
    end


  end

end

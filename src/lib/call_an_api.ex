defmodule CallAnApi do
  def run do

    # I realise that htis code is incredibly imperative. That's on purpose, I'll redo this more idiomatically in subsequent commits.
    url = "https://pokeapi.co/api/v2/pokedex/kanto/"

    response = HTTPoison.get!(url)
    decoded = JSON.decode!(response.body)
    IO.puts(decoded["name"])
    decoded["pokemon_entries"]
      |> Enum.map(fn entry -> "Entry: #{entry["entry_number"]} \nName: #{entry["pokemon_species"]["name"]} \n------------\n" end)
      |> IO.puts
  end
end

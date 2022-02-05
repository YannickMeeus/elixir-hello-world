defmodule CallAnApi do
  def run do
    with {:ok, response} <- HTTPoison.get("https://pokeapi.co/api/v2/pokedex/kanto/"),
         {:ok, pokemon} <- JSON.decode(response.body) do
      IO.puts(pokemon["name"])

      pokemon["pokemon_entries"]
      |> Enum.map(&pretty_format_pokemon/1)
      |> IO.puts()
    end
  end

  defp pretty_format_pokemon(entry) do
    "Entry: #{entry["entry_number"]} \nName: #{entry["pokemon_species"]["name"]} \n------------\n"
  end
end

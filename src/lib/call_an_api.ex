defmodule BunchOfPokemon do
  @derive [Poison.Encoder]
  defstruct [:name, :pokemon_entries]
  @type t :: %__MODULE__{
    name: String.t(),
    pokemon_entries: [Pokemon.t()],
  }
end

defmodule Pokemon do
  @derive [Poison.Encoder]
  defstruct [:entry_number, :pokemon_species]
  @type t :: %__MODULE__{
    entry_number: String.t(),
    pokemon_species: PokemonSpecies.t() ,
  }
end

defmodule PokemonSpecies do
  @derive [Poison.Encoder]
  defstruct [:name]
  @type t :: %__MODULE__{
    name: String.t(),
  }

end

defmodule CallAnApi do
  @spec run :: none
  def run do
    IO.puts("Calling pokemans api...")
    url = "https://pokeapi.co/api/v2/pokedex/kanto/"

    response = HTTPoison.get!(url)
    decoded = decode(response.body)
    IO.puts(decoded.name)
    decoded.pokemon_entries
      |> Enum.map(fn entry -> "Entry: #{entry.entry_number} \nName: #{entry.pokemon_species.name} \n------------\n" end)
      |> IO.puts
  end

  @spec decode(String.t) :: BunchOfPokemon.t
  defp decode(body) do
      Poison.decode!(body, as: %BunchOfPokemon{:name => :string, :pokemon_entries => [%Pokemon{:entry_number => :int, :pokemon_species => %PokemonSpecies{:name => :string}}]})
  end
end

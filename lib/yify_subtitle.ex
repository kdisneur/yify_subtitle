defmodule YifySubtitle do
  defstruct imdb_id: "", languages: []

  def search(imdb_id, languages \\ []) do
    %YifySubtitle{
      imdb_id:   imdb_id,
      languages: YifySubtitle.Adapters.InMemory.search(imdb_id, languages)
    }
  end
end

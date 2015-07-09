defmodule YifySubtitle do
   @adapter Application.get_env(:yify_subtitle, :adapter)

  defstruct imdb_id: "", languages: []

  def search(imdb_id, languages \\ []) do
    %YifySubtitle{
      imdb_id:   imdb_id,
      languages: @adapter.search(imdb_id, languages)
    }
  end
end

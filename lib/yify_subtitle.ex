defmodule YifySubtitle do
  defstruct imdb_id: "", languages: []

  def search(imdb_id, languages \\ []) do
    %YifySubtitle{
      imdb_id:   imdb_id,
      languages: adapter.search(imdb_id, languages)
    }
  end

  defp adapter, do: Application.get_env(:yify_subtitle, :adapter)
end

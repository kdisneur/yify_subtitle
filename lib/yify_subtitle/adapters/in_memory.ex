defmodule YifySubtitle.Adapters.InMemory do
  @url       "http://api.fake.com/"
  @languages [:english, :french, :spanish]

  def search(imdb_id, []), do: search(imdb_id, @languages)
  def search(imdb_id, languages) do
    languages
    |> filter_languages
    |> formalize_response(imdb_id)
    |> Enum.to_list
  end

  defp filter_languages(languages) do
    languages
    |> Stream.filter(&(Enum.member?(@languages, &1)))
  end

  defp formalize_response(languages, imdb_id) do
    languages
    |> Stream.map(&({&1, ["#{@url}#{imdb_id}/#{&1}.zip"]}))
  end
end

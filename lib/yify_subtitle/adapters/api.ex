defmodule YifySubtitle.Adapters.API do
  @url "http://api.yifysubtitles.com"

  def search(imdb_id, languages) do
    imdb_id
    |> build_url
    |> fetch_from_api
    |> transform_http_response_to_data
    |> filter_languages(languages)
    |> formalize_response
    |> Enum.to_list
  end

  defp build_url(imdb_id) do
    "#{@url}/subs/#{imdb_id}"
  end

  defp extract_urls_from_subtitle_infos(subtitles_infos) do
    subtitles_infos
    |> Enum.map(fn(%{"url" => path}) -> @url <> path end)
  end

  defp fetch_from_api(url) do
    case HTTPoison.get!(url) do
      %HTTPoison.Response{status_code: 200, body: body} -> Poison.Parser.parse!(body)
    end
  end

  defp filter_languages(subtitles, []), do: subtitles
  defp filter_languages(subtitles, expected_languages) do
    subtitles
    |> Stream.filter(fn({language, _}) -> Enum.member?(expected_languages, String.to_atom(language)) end)
  end

  defp transform_http_response_to_data(response) do
    case response do
      %{"success" => true, "subs" => results} ->
        [{_, subtitles}] = results |> Map.to_list
        subtitles
      %{"success" => true} -> %{}
    end
  end

  defp formalize_response(subtitles) do
    subtitles
    |> Stream.map(fn({language, subtitles_infos}) -> {String.to_atom(language), extract_urls_from_subtitle_infos(subtitles_infos)} end)
  end
end

defmodule YifySubtitle.Adapters.APITest do
  use ExUnit.Case, async: false

  import Mock

  test "search returns list of all available subtitles" do
    with_mock HTTPoison, [
      get!: fn("http://api.yifysubtitles.com/subs/tt0133093") ->
              %HTTPoison.Response{status_code: 200, body: File.read!("test/yify_subtitle/adapters/fixtures/tt0133093.json")}
            end
    ] do
      expected = [
        english: ["http://api.yifysubtitles.com/subtitle-api/the-matrix-yify-742.zip", "http://api.yifysubtitles.com/subtitle-api/the-matrix-yify-39316.zip"],
        french:  ["http://api.yifysubtitles.com/subtitle-api/the-matrix-yify-24107.zip"],
        spanish: ["http://api.yifysubtitles.com/subtitle-api/the-matrix-yify-4242.zip"]
      ]

      assert expected == YifySubtitle.Adapters.API.search("tt0133093", [])
    end
  end

  test "search returns only list of available subtitles" do
    with_mock HTTPoison, [
      get!: fn("http://api.yifysubtitles.com/subs/tt0133093") ->
              %HTTPoison.Response{status_code: 200, body: File.read!("test/yify_subtitle/adapters/fixtures/tt0133093.json")}
            end
    ] do
      expected = [
        english: ["http://api.yifysubtitles.com/subtitle-api/the-matrix-yify-742.zip", "http://api.yifysubtitles.com/subtitle-api/the-matrix-yify-39316.zip"]
      ]

      assert expected == YifySubtitle.Adapters.API.search("tt0133093", [:english, :dutch])
    end
  end
end

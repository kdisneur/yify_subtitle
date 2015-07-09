defmodule YifySubtitleTest do
  use ExUnit.Case

  setup do
    Application.put_env(:yify_subtitle, :adapter, YifySubtitle.Adapters.InMemory)
    {:ok, []}
  end

  test "search returns list of all available subtitles" do
    expected = %YifySubtitle{
      imdb_id:   "tt0133093",
      languages: [
        english: ["http://api.fake.com/tt0133093/english.zip"],
        french:  ["http://api.fake.com/tt0133093/french.zip"],
        spanish: ["http://api.fake.com/tt0133093/spanish.zip"]
      ]
    }

    assert expected == YifySubtitle.search("tt0133093")
  end

  test "search returns only list of available subtitles" do
    expected = %YifySubtitle{
      imdb_id:   "tt0133093",
      languages: [
        english: ["http://api.fake.com/tt0133093/english.zip"],
      ]
    }

    assert expected == YifySubtitle.search("tt0133093", [:english, :dutch])
  end
end

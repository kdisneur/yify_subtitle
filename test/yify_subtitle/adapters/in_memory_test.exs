defmodule YifySubtitle.Adapters.InMemoryTest do
  use ExUnit.Case

  test "search returns list of all available subtitles" do
    expected = [
      english: ["http://api.fake.com/tt0133093/english.zip"],
      french:  ["http://api.fake.com/tt0133093/french.zip"],
      spanish: ["http://api.fake.com/tt0133093/spanish.zip"]
    ]

    assert expected == YifySubtitle.Adapters.InMemory.search("tt0133093", [])
  end

  test "search returns only list of available subtitles" do
    expected = [
      english: ["http://api.fake.com/tt0133093/english.zip"],
    ]

    assert expected == YifySubtitle.Adapters.InMemory.search("tt0133093", [:english, :dutch])
  end
end

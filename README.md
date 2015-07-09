# Yify Subtitle

An Elixir wrapper around [Yify Subtitles](http://www.yifysubtitles.com/).

### Installation

First, add YifySubtitle to your `mix.exs` dependencies and register the app:

```elixir
def application do
  [
    mod: {DummyApp, []},
    applications: [:logger, :yify_subtitle]
  ]
end

def deps do
  [{:yify_subtitle, github: "kdisneur/yify_subtitle"}]
end
```

Then, update your dependencies:

```sh-session
$ mix deps.get
```

## Usage

### Search

By default the search will find all the available subtitles in all possible languages for a specific `IMDd ID`:

```elixir
YifySubtitle.search("tt0133093")
#=> %YifySubtitle{
#  imdb_id: "tt0133093",
#  languages: [
#    ...
#    english: [
#      "http://api.yifysubtitles.com/subtitle-api/the-matrix-yify-742.zip",
#      "http://api.yifysubtitles.com/subtitle-api/the-matrix-yify-39316.zip",
#      "http://api.yifysubtitles.com/subtitle-api/the-matrix-yify-52597.zip",
#      "http://api.yifysubtitles.com/subtitle-api/the-matrix-yify-40402.zip",
#      "http://api.yifysubtitles.com/subtitle-api/the-matrix-yify-52598.zip"
#    ],
#    french: ["http://api.yifysubtitles.com/subtitle-api/the-matrix-yify-24107.zip"],
#    ...
#  ]
#}
```

But you can change this behaviour and explicitly set the languages you want to search for:

```elixir
YifySubtitle.search("tt0133093", [:italian, :russian])
#=> %YifySubtitle{
#  imdb_id: "tt0133093",
#  languages: [
#    italian: ["http://api.yifysubtitles.com/subtitle-api/the-matrix-yify-12961.zip"],
#    russian: [
#      "http://api.yifysubtitles.com/subtitle-api/the-matrix-yify-41611.zip",
#      "http://api.yifysubtitles.com/subtitle-api/the-matrix-yify-41647.zip"
#    ]
#  ]
#}
```

### Adapters

It could be useful to avoid network access on development or test, so this library provides two different adapters:

* `API`: (default): call the Yify Subtitles API
* `InMemory`: fake the reply from the API. This adapter handles 3 different languages (english, french, spanish)

Example of configuration:

```elixir
# config/config.exs
use Mix.Config

config :yify_subtitle, :adapter, YifySubtitle.Adapters.API
# or
# config :yify_subtitle, :adapter, YifySubtitle.Adapters.InMemory
```

## License

Released under the [MIT License](https://github.com/kdisneur/yify_subtitle/blob/master/LICENSE)

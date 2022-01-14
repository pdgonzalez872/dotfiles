Mix.install([
  {:ecto, "~> 3.7.1"}
])

uuid = Ecto.UUID.generate()
date = Date.utc_today()

result = """
uuid:#{uuid}
date:#{date.year}#{date.month}#{date.day}
tags: aaaaa,aaaaaa


================================================================================
"""
|> String.trim()

IO.puts(result)

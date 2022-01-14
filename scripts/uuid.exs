Mix.install([
  {:ecto, "~> 3.7.1"}
])

uuid = Ecto.UUID.generate()
IO.puts("id: #{uuid}")

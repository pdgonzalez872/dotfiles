Mix.install([
  {:benchee, "~> 1.0"}
])

list = Enum.to_list(1..10_000)

Benchee.run(
  %{
    "Map.put syntax" => fn ->
      Enum.reduce(list, %{collection: []}, fn el, acc ->
        Map.put(acc, :collection, [el | acc.collection])
      end)
    end,
    "%{} syntax" => fn ->
      Enum.reduce(list, %{collection: []}, fn el, acc ->
        %{acc | collection: [el | acc.collection]}
      end)
    end
  }
)

Mix.install([
  {:ecto, "~> 3.7.1"}
])

uuid = Ecto.UUID.generate()
date = Date.utc_today()

result = """
### Summary:

uuid:#{uuid}


### Hypothesis:


### TODO:


### Notes:

================================================================================
"""
|> String.trim()

add_zero = fn integer ->
  if integer in 1..9 do
    "0#{integer}"
  else
    "#{integer}"
  end
end

filename = "999_#{date.year}#{add_zero.(date.month)}#{add_zero.(date.day)}_template.txt"
path = Path.join([File.cwd!(), "projects", "current", filename])

file = File.open!(path, [:write])
IO.binwrite(file, result)
File.close(file)

IO.puts("Done!, check #{path}")

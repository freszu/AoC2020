defmodule PuzzleInput do
  defstruct firstIndex: 0, secondIndex: 0, char: '', password: ""
end

defmodule Main do
  def main do
    parsed = File.read!("input.txt")
             |> String.split("\n")
             |> Enum.map(&Regex.named_captures(~r/(?<first>\d+)-(?<second>\d+) (?<char>\w): (?<password>\w+)/, &1))
             |> Enum.filter(&!is_nil(&1))
             |> Enum.map(
                  fn match ->
                    %PuzzleInput{
                      firstIndex: String.to_integer(match["first"]),
                      secondIndex: String.to_integer(match["second"]),
                      char: match["char"],
                      password: match["password"]
                    }
                  end
                )

    parsed
    |> Enum.map(
         fn input ->
           count = input.password
                   |> String.graphemes()
                   |> Enum.count(& &1 == input.char)
           count >= input.firstIndex && count <= input.secondIndex
         end
       )
    |> Enum.count(& &1)
    |> IO.inspect(limit: :infinity)

    parsed
    |> Enum.map(
         fn input ->
           first = input.firstIndex - 1
           second = input.secondIndex - 1
           firstChar = String.at(input.password, first)
           secondChar = String.at(input.password, second)
           firstChar != secondChar && (firstChar == input.char || secondChar == input.char)
         end
       )
    |> Enum.count(& &1)
    |> IO.inspect(limit: :infinity)

  end
end

Main.main()

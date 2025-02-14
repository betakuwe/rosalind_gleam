import gleam/dict
import gleam/int
import gleam/list
import gleam/option
import gleam/string
import simplifile

pub fn solution() {
  let assert Ok(data) = simplifile.read("./rosalind_dna.txt")
  let counts =
    string.to_graphemes(data)
    |> list.fold(dict.new(), fn(counts, nt) {
      dict.upsert(counts, nt, fn(count_option) {
        case count_option {
          option.None -> 1
          option.Some(count) -> count + 1
        }
      })
    })
  let assert Ok(ans_list) =
    list.try_map(["A", "C", "G", "T"], dict.get(counts, _))
  list.map(ans_list, int.to_string)
  |> string.join(" ")
}

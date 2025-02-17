import gleam/string
import simplifile

pub fn solution() {
  let assert Ok(data) = simplifile.read("src/rna/rosalind_rna.txt")
  string.replace(data, "T", "U")
}

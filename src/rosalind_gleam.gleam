import argv
import dna/dna
import gleam/dict
import gleam/io
import gleam/list

const solution_reference: List(#(SolutionCode, fn() -> Solution)) = [
  #("dna", dna.solution),
]

type SolutionCode =
  String

type Solution =
  String

type SolutionError {
  InvalidSolutionCode(code: String)
  NoArgumentsGiven
}

pub fn main() {
  let assert Ok(solution_code_pair) = case argv.load().arguments {
    [] -> Error(NoArgumentsGiven)
    args -> run_solutions(args)
  }
  list.each(solution_code_pair, fn(solution_code_pair) {
    let #(solution_code, solution) = solution_code_pair
    io.println("Solution to " <> solution_code <> ":\n" <> solution)
  })
}

fn run_solutions(
  solution_codes: List(String),
) -> Result(List(#(SolutionCode, Solution)), SolutionError) {
  let solutions_reference_dict = dict.from_list(solution_reference)
  list.try_map(solution_codes, fn(solution_code) {
    case dict.get(solutions_reference_dict, solution_code) {
      Ok(solution) -> #(solution_code, solution()) |> Ok
      Error(Nil) -> InvalidSolutionCode(solution_code) |> Error
    }
  })
}

import dna/dna
import rna/rna

pub type SolutionCode =
  String

pub type Solution =
  String

pub const solution_reference: List(#(SolutionCode, fn() -> Solution)) = [
  #("dna", dna.solution),
  #("rna", rna.solution),
]

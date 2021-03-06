open! Import

type t = bool [@@deriving_inline hash, sexp]
include
sig
  [@@@ocaml.warning "-32"]
  val t_of_sexp : Sexplib.Sexp.t -> t
  val sexp_of_t : t -> Sexplib.Sexp.t
  val hash_fold_t :
    Ppx_hash_lib.Std.Hash.state -> t -> Ppx_hash_lib.Std.Hash.state
  val hash : t -> Ppx_hash_lib.Std.Hash.hash_value
end
[@@@end]

include Comparable.S with type t := t
include Hashable.S   with type t := t
include Stringable.S with type t := t

(** - [to_int true = 1]
    - [to_int false = 0] *)
val to_int : t -> int

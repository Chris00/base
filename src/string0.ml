(* [String0] defines string functions that are primitives or can be simply defined in
   terms of [Caml.String].  [String0] is intended to completely express the part of
   [Caml.String] that [Base] uses -- no other file in Base other than string0.ml should
   use [Caml.String].  [String0] has few dependencies, and so is available early in Base's
   build order.  All Base files that need to use strings and come before [Base.String] in
   build order should do [module String = String0].  This includes uses of subscript
   syntax ([x.(i)], [x.(i) <- e]), which the OCaml parser desugars into calls to
   [String.get] and [String.set].  Defining [module String = String0] is also necessary
   because it prevents ocamldep from mistakenly causing a file to depend on
   [Base.String]. *)

open! Import0

module String = struct
  external create     : int           -> string       = "caml_create_string"
  external get        : string -> int -> char         = "%string_safe_get"
  external length     : string        -> int          = "%string_length"
  external set        : string -> int -> char -> unit = "%string_safe_set"
  external unsafe_get : string -> int -> char         = "%string_unsafe_get"
  external unsafe_set : string -> int -> char -> unit = "%string_unsafe_set"
end

include String

let max_length = Caml.Sys.max_string_length

let (^) = (^)

let blit            = Caml.String.blit
let capitalize      = Caml.String.capitalize
let compare         = Caml.String.compare
let copy            = Caml.String.copy
let escaped         = Caml.String.escaped
let fill            = Caml.String.fill
let index_exn       = Caml.String.index
let index_from_exn  = Caml.String.index_from
let lowercase       = Caml.String.lowercase
let make            = Caml.String.make
let rindex_exn      = Caml.String.rindex
let rindex_from_exn = Caml.String.rindex_from
let sub             = Caml.String.sub
let uncapitalize    = Caml.String.uncapitalize
let unsafe_blit     = Caml.String.unsafe_blit
let uppercase       = Caml.String.uppercase

let concat ?(sep = "") l = Caml.String.concat ~sep l

(* These are eta expanded in order to permute parameter order to follow Base
   conventions. *)
let iter t ~f = Caml.String.iter t ~f

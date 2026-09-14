type t =
  { occurrences : Query_protocol.occurrence list;
    status : Query_protocol.occurrences_status
  }

val locs_of :
  config:Mconfig.t ->
  env:Env.t ->
  typer_result:Mtyper.result ->
  pos:Lexing.position ->
  scope:[ `Project | `Buffer | `Renaming ] ->
  string ->
  t

type index_uid_tbl

val get_index_uid_tbl : config:Mconfig.t -> string -> index_uid_tbl

val find_in_index_uid_tbl : index_uid_tbl -> Shape.Uid.t -> Shape.Uid.t list

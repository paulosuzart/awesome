open Alcotest
module Github = Starred_ml.Github
open Github

let starred_eq a b = a = b

let starred_pp ppf i =
  List.iter
    (fun (t, p) ->
      List.iter (fun z -> Fmt.pf ppf "%s -> %s" t (show_starred z)) p)
    i

let starred_testable = Alcotest.testable starred_pp starred_eq

let test_group () =
  let sample_java_repo =
    {
      name = "Sample";
      description = Some "Description";
      topics = [ "Flow" ];
      language = Some "Java";
      url = "example.com";
    }
  and sample_ocaml_repo =
    {
      name = "Another Repo";
      description = Some "Description";
      topics = [ "Flow" ];
      language = Some "Ocaml";
      url = "example.com";
    }
  in
  Alcotest.(check starred_testable)
    "Repos are grouped by topic"
    [ ("Java", [ sample_java_repo ]); ("Ocaml", [ sample_ocaml_repo ]) ]
    (by_language [ sample_java_repo; sample_ocaml_repo ])

let () =
  run "Github" [ ("group_by-case", [ test_case "Group" `Quick test_group ]) ]

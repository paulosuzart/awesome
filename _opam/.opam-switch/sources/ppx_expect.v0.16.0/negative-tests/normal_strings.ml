let%expect_test _ =
  print_string "foo\nbar\n";
  [%expect ""]
;;

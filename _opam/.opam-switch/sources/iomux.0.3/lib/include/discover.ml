module C = Configurator.V1

let has_ppoll_code = {|
#define _GNU_SOURCE /* for linux */
#include <poll.h>
#include <stddef.h>
#include <strings.h>

int
main(void)
{
	struct pollfd fds;
	struct timespec ts;

	bzero(&fds, sizeof(fds));
	bzero(&ts, sizeof(ts));

	return (ppoll(&fds, 0, &ts, NULL));
}
|}

let () =
  C.main ~name:"discover" @@ fun c ->

  (* check for ppoll(2) *)
  let has_ppoll = C.c_test c has_ppoll_code in
  C.C_define.gen_header_file c ~fname:"config.h" [ "HAS_PPOLL", Switch has_ppoll ];
  let has_list = [ Printf.sprintf "let has_ppoll = %b" has_ppoll ] in

  (* general poll(2) definitions *)
  let defs =
    C.C_define.import c ~includes:["poll.h"]
      C.C_define.Type.[
        "POLLIN", Int;
        "POLLPRI", Int;
        "POLLOUT", Int;
        "POLLERR", Int;
        "POLLHUP", Int;
        "POLLNVAL", Int;
        "sizeof(struct pollfd)", Int;
      ]
    |> List.map (function
        | name, C.C_define.Value.Int v ->
          let name = 
            match name with
            | "sizeof(struct pollfd)" -> "sizeof_pollfd"
            | nm -> nm 
          in
          Printf.sprintf "let %s = 0x%x" (String.lowercase_ascii name) v
        | _ -> assert false
      )
  in
  C.Flags.write_lines "config.ml" (defs @ has_list)

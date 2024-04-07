open Import
module M =
  struct
    let attribute ~loc  ~name  ~payload  =
      { attr_name = name; attr_payload = payload; attr_loc = loc }
    let binding_op ~loc  ~op  ~pat  ~exp  =
      { pbop_op = op; pbop_pat = pat; pbop_exp = exp; pbop_loc = loc }
    let case ~lhs  ~guard  ~rhs  =
      { pc_lhs = lhs; pc_guard = guard; pc_rhs = rhs }
    let pcl_constr ~loc  x0 x1 =
      { pcl_attributes = []; pcl_loc = loc; pcl_desc = (Pcl_constr (x0, x1))
      }
    let pcl_structure ~loc  x0 =
      { pcl_attributes = []; pcl_loc = loc; pcl_desc = (Pcl_structure x0) }
    let pcl_fun ~loc  x0 x1 x2 x3 =
      {
        pcl_attributes = [];
        pcl_loc = loc;
        pcl_desc = (Pcl_fun (x0, x1, x2, x3))
      }
    let pcl_apply ~loc  x0 x1 =
      { pcl_attributes = []; pcl_loc = loc; pcl_desc = (Pcl_apply (x0, x1)) }
    let pcl_let ~loc  x0 x1 x2 =
      { pcl_attributes = []; pcl_loc = loc; pcl_desc = (Pcl_let (x0, x1, x2))
      }
    let pcl_constraint ~loc  x0 x1 =
      {
        pcl_attributes = [];
        pcl_loc = loc;
        pcl_desc = (Pcl_constraint (x0, x1))
      }
    let pcl_extension ~loc  x0 =
      { pcl_attributes = []; pcl_loc = loc; pcl_desc = (Pcl_extension x0) }
    let pcl_open ~loc  x0 x1 =
      { pcl_attributes = []; pcl_loc = loc; pcl_desc = (Pcl_open (x0, x1)) }
    let pcf_inherit ~loc  x0 x1 x2 =
      {
        pcf_attributes = [];
        pcf_loc = loc;
        pcf_desc = (Pcf_inherit (x0, x1, x2))
      }
    let pcf_val ~loc  x0 =
      { pcf_attributes = []; pcf_loc = loc; pcf_desc = (Pcf_val x0) }
    let pcf_method ~loc  x0 =
      { pcf_attributes = []; pcf_loc = loc; pcf_desc = (Pcf_method x0) }
    let pcf_constraint ~loc  x0 =
      { pcf_attributes = []; pcf_loc = loc; pcf_desc = (Pcf_constraint x0) }
    let pcf_initializer ~loc  x0 =
      { pcf_attributes = []; pcf_loc = loc; pcf_desc = (Pcf_initializer x0) }
    let pcf_attribute ~loc  x0 =
      { pcf_attributes = []; pcf_loc = loc; pcf_desc = (Pcf_attribute x0) }
    let pcf_extension ~loc  x0 =
      { pcf_attributes = []; pcf_loc = loc; pcf_desc = (Pcf_extension x0) }
    let class_infos ~loc  ~virt  ~params  ~name  ~expr  =
      {
        pci_virt = virt;
        pci_params = params;
        pci_name = name;
        pci_expr = expr;
        pci_loc = loc;
        pci_attributes = []
      }
    let class_signature ~self  ~fields  =
      { pcsig_self = self; pcsig_fields = fields }
    let class_structure ~self  ~fields  =
      { pcstr_self = self; pcstr_fields = fields }
    let pcty_constr ~loc  x0 x1 =
      {
        pcty_attributes = [];
        pcty_loc = loc;
        pcty_desc = (Pcty_constr (x0, x1))
      }
    let pcty_signature ~loc  x0 =
      { pcty_attributes = []; pcty_loc = loc; pcty_desc = (Pcty_signature x0)
      }
    let pcty_arrow ~loc  x0 x1 x2 =
      {
        pcty_attributes = [];
        pcty_loc = loc;
        pcty_desc = (Pcty_arrow (x0, x1, x2))
      }
    let pcty_extension ~loc  x0 =
      { pcty_attributes = []; pcty_loc = loc; pcty_desc = (Pcty_extension x0)
      }
    let pcty_open ~loc  x0 x1 =
      {
        pcty_attributes = [];
        pcty_loc = loc;
        pcty_desc = (Pcty_open (x0, x1))
      }
    let pctf_inherit ~loc  x0 =
      { pctf_attributes = []; pctf_loc = loc; pctf_desc = (Pctf_inherit x0) }
    let pctf_val ~loc  x0 =
      { pctf_attributes = []; pctf_loc = loc; pctf_desc = (Pctf_val x0) }
    let pctf_method ~loc  x0 =
      { pctf_attributes = []; pctf_loc = loc; pctf_desc = (Pctf_method x0) }
    let pctf_constraint ~loc  x0 =
      {
        pctf_attributes = [];
        pctf_loc = loc;
        pctf_desc = (Pctf_constraint x0)
      }
    let pctf_attribute ~loc  x0 =
      { pctf_attributes = []; pctf_loc = loc; pctf_desc = (Pctf_attribute x0)
      }
    let pctf_extension ~loc  x0 =
      { pctf_attributes = []; pctf_loc = loc; pctf_desc = (Pctf_extension x0)
      }
    let constructor_declaration ~loc  ~name  ~vars  ~args  ~res  =
      {
        pcd_name = name;
        pcd_vars = vars;
        pcd_args = args;
        pcd_res = res;
        pcd_loc = loc;
        pcd_attributes = []
      }
    let ptyp_any ~loc  =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = Ptyp_any
      }
    let ptyp_var ~loc  x0 =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = (Ptyp_var x0)
      }
    let ptyp_arrow ~loc  x0 x1 x2 =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = (Ptyp_arrow (x0, x1, x2))
      }
    let ptyp_tuple ~loc  x0 =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = (Ptyp_tuple x0)
      }
    let ptyp_constr ~loc  x0 x1 =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = (Ptyp_constr (x0, x1))
      }
    let ptyp_object ~loc  x0 x1 =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = (Ptyp_object (x0, x1))
      }
    let ptyp_class ~loc  x0 x1 =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = (Ptyp_class (x0, x1))
      }
    let ptyp_alias ~loc  x0 x1 =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = (Ptyp_alias (x0, x1))
      }
    let ptyp_variant ~loc  x0 x1 x2 =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = (Ptyp_variant (x0, x1, x2))
      }
    let ptyp_poly ~loc  x0 x1 =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = (Ptyp_poly (x0, x1))
      }
    let ptyp_package ~loc  x0 =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = (Ptyp_package x0)
      }
    let ptyp_extension ~loc  x0 =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = (Ptyp_extension x0)
      }
    let pdir_string ~loc  x0 =
      { pdira_loc = loc; pdira_desc = (Pdir_string x0) }
    let pdir_int ~loc  x0 x1 =
      { pdira_loc = loc; pdira_desc = (Pdir_int (x0, x1)) }
    let pdir_ident ~loc  x0 =
      { pdira_loc = loc; pdira_desc = (Pdir_ident x0) }
    let pdir_bool ~loc  x0 = { pdira_loc = loc; pdira_desc = (Pdir_bool x0) }
    let pexp_ident ~loc  x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_ident x0)
      }
    let pexp_constant ~loc  x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_constant x0)
      }
    let pexp_let ~loc  x0 x1 x2 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_let (x0, x1, x2))
      }
    let pexp_function ~loc  x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_function x0)
      }
    let pexp_fun ~loc  x0 x1 x2 x3 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_fun (x0, x1, x2, x3))
      }
    let pexp_apply ~loc  x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_apply (x0, x1))
      }
    let pexp_match ~loc  x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_match (x0, x1))
      }
    let pexp_try ~loc  x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_try (x0, x1))
      }
    let pexp_tuple ~loc  x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_tuple x0)
      }
    let pexp_construct ~loc  x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_construct (x0, x1))
      }
    let pexp_variant ~loc  x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_variant (x0, x1))
      }
    let pexp_record ~loc  x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_record (x0, x1))
      }
    let pexp_field ~loc  x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_field (x0, x1))
      }
    let pexp_setfield ~loc  x0 x1 x2 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_setfield (x0, x1, x2))
      }
    let pexp_array ~loc  x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_array x0)
      }
    let pexp_ifthenelse ~loc  x0 x1 x2 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_ifthenelse (x0, x1, x2))
      }
    let pexp_sequence ~loc  x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_sequence (x0, x1))
      }
    let pexp_while ~loc  x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_while (x0, x1))
      }
    let pexp_for ~loc  x0 x1 x2 x3 x4 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_for (x0, x1, x2, x3, x4))
      }
    let pexp_constraint ~loc  x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_constraint (x0, x1))
      }
    let pexp_coerce ~loc  x0 x1 x2 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_coerce (x0, x1, x2))
      }
    let pexp_send ~loc  x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_send (x0, x1))
      }
    let pexp_new ~loc  x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_new x0)
      }
    let pexp_setinstvar ~loc  x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_setinstvar (x0, x1))
      }
    let pexp_override ~loc  x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_override x0)
      }
    let pexp_letmodule ~loc  x0 x1 x2 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_letmodule (x0, x1, x2))
      }
    let pexp_letexception ~loc  x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_letexception (x0, x1))
      }
    let pexp_assert ~loc  x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_assert x0)
      }
    let pexp_lazy ~loc  x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_lazy x0)
      }
    let pexp_poly ~loc  x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_poly (x0, x1))
      }
    let pexp_object ~loc  x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_object x0)
      }
    let pexp_newtype ~loc  x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_newtype (x0, x1))
      }
    let pexp_pack ~loc  x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_pack x0)
      }
    let pexp_open ~loc  x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_open (x0, x1))
      }
    let pexp_letop ~loc  x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_letop x0)
      }
    let pexp_extension ~loc  x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_extension x0)
      }
    let pexp_unreachable ~loc  =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = Pexp_unreachable
      }
    let extension_constructor ~loc  ~name  ~kind  =
      {
        pext_name = name;
        pext_kind = kind;
        pext_loc = loc;
        pext_attributes = []
      }
    let include_infos ~loc  mod_ =
      { pincl_mod = mod_; pincl_loc = loc; pincl_attributes = [] }
    let label_declaration ~loc  ~name  ~mutable_  ~type_  =
      {
        pld_name = name;
        pld_mutable = mutable_;
        pld_type = type_;
        pld_loc = loc;
        pld_attributes = []
      }
    let letop ~let_  ~ands  ~body  = { let_; ands; body }
    let location ~start  ~end_  ~ghost  =
      { loc_start = start; loc_end = end_; loc_ghost = ghost }
    let module_binding ~loc  ~name  ~expr  =
      { pmb_name = name; pmb_expr = expr; pmb_attributes = []; pmb_loc = loc
      }
    let module_declaration ~loc  ~name  ~type_  =
      { pmd_name = name; pmd_type = type_; pmd_attributes = []; pmd_loc = loc
      }
    let pmod_ident ~loc  x0 =
      { pmod_attributes = []; pmod_loc = loc; pmod_desc = (Pmod_ident x0) }
    let pmod_structure ~loc  x0 =
      { pmod_attributes = []; pmod_loc = loc; pmod_desc = (Pmod_structure x0)
      }
    let pmod_functor ~loc  x0 x1 =
      {
        pmod_attributes = [];
        pmod_loc = loc;
        pmod_desc = (Pmod_functor (x0, x1))
      }
    let pmod_apply ~loc  x0 x1 =
      {
        pmod_attributes = [];
        pmod_loc = loc;
        pmod_desc = (Pmod_apply (x0, x1))
      }
    let pmod_constraint ~loc  x0 x1 =
      {
        pmod_attributes = [];
        pmod_loc = loc;
        pmod_desc = (Pmod_constraint (x0, x1))
      }
    let pmod_unpack ~loc  x0 =
      { pmod_attributes = []; pmod_loc = loc; pmod_desc = (Pmod_unpack x0) }
    let pmod_extension ~loc  x0 =
      { pmod_attributes = []; pmod_loc = loc; pmod_desc = (Pmod_extension x0)
      }
    let module_substitution ~loc  ~name  ~manifest  =
      {
        pms_name = name;
        pms_manifest = manifest;
        pms_attributes = [];
        pms_loc = loc
      }
    let pmty_ident ~loc  x0 =
      { pmty_attributes = []; pmty_loc = loc; pmty_desc = (Pmty_ident x0) }
    let pmty_signature ~loc  x0 =
      { pmty_attributes = []; pmty_loc = loc; pmty_desc = (Pmty_signature x0)
      }
    let pmty_functor ~loc  x0 x1 =
      {
        pmty_attributes = [];
        pmty_loc = loc;
        pmty_desc = (Pmty_functor (x0, x1))
      }
    let pmty_with ~loc  x0 x1 =
      {
        pmty_attributes = [];
        pmty_loc = loc;
        pmty_desc = (Pmty_with (x0, x1))
      }
    let pmty_typeof ~loc  x0 =
      { pmty_attributes = []; pmty_loc = loc; pmty_desc = (Pmty_typeof x0) }
    let pmty_extension ~loc  x0 =
      { pmty_attributes = []; pmty_loc = loc; pmty_desc = (Pmty_extension x0)
      }
    let pmty_alias ~loc  x0 =
      { pmty_attributes = []; pmty_loc = loc; pmty_desc = (Pmty_alias x0) }
    let module_type_declaration ~loc  ~name  ~type_  =
      {
        pmtd_name = name;
        pmtd_type = type_;
        pmtd_attributes = [];
        pmtd_loc = loc
      }
    let otag ~loc  x0 x1 =
      { pof_attributes = []; pof_loc = loc; pof_desc = (Otag (x0, x1)) }
    let oinherit ~loc  x0 =
      { pof_attributes = []; pof_loc = loc; pof_desc = (Oinherit x0) }
    let open_infos ~loc  ~expr  ~override  =
      {
        popen_expr = expr;
        popen_override = override;
        popen_loc = loc;
        popen_attributes = []
      }
    let ppat_any ~loc  =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = Ppat_any
      }
    let ppat_var ~loc  x0 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_var x0)
      }
    let ppat_alias ~loc  x0 x1 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_alias (x0, x1))
      }
    let ppat_constant ~loc  x0 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_constant x0)
      }
    let ppat_interval ~loc  x0 x1 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_interval (x0, x1))
      }
    let ppat_tuple ~loc  x0 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_tuple x0)
      }
    let ppat_construct ~loc  x0 x1 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_construct (x0, x1))
      }
    let ppat_variant ~loc  x0 x1 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_variant (x0, x1))
      }
    let ppat_record ~loc  x0 x1 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_record (x0, x1))
      }
    let ppat_array ~loc  x0 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_array x0)
      }
    let ppat_or ~loc  x0 x1 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_or (x0, x1))
      }
    let ppat_constraint ~loc  x0 x1 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_constraint (x0, x1))
      }
    let ppat_type ~loc  x0 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_type x0)
      }
    let ppat_lazy ~loc  x0 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_lazy x0)
      }
    let ppat_unpack ~loc  x0 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_unpack x0)
      }
    let ppat_exception ~loc  x0 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_exception x0)
      }
    let ppat_extension ~loc  x0 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_extension x0)
      }
    let ppat_open ~loc  x0 x1 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_open (x0, x1))
      }
    let position ~fname  ~lnum  ~bol  ~cnum  =
      { pos_fname = fname; pos_lnum = lnum; pos_bol = bol; pos_cnum = cnum }
    let rtag ~loc  x0 x1 x2 =
      { prf_attributes = []; prf_loc = loc; prf_desc = (Rtag (x0, x1, x2)) }
    let rinherit ~loc  x0 =
      { prf_attributes = []; prf_loc = loc; prf_desc = (Rinherit x0) }
    let psig_value ~loc  x0 = { psig_loc = loc; psig_desc = (Psig_value x0) }
    let psig_type ~loc  x0 x1 =
      { psig_loc = loc; psig_desc = (Psig_type (x0, x1)) }
    let psig_typesubst ~loc  x0 =
      { psig_loc = loc; psig_desc = (Psig_typesubst x0) }
    let psig_typext ~loc  x0 =
      { psig_loc = loc; psig_desc = (Psig_typext x0) }
    let psig_exception ~loc  x0 =
      { psig_loc = loc; psig_desc = (Psig_exception x0) }
    let psig_module ~loc  x0 =
      { psig_loc = loc; psig_desc = (Psig_module x0) }
    let psig_modsubst ~loc  x0 =
      { psig_loc = loc; psig_desc = (Psig_modsubst x0) }
    let psig_recmodule ~loc  x0 =
      { psig_loc = loc; psig_desc = (Psig_recmodule x0) }
    let psig_modtype ~loc  x0 =
      { psig_loc = loc; psig_desc = (Psig_modtype x0) }
    let psig_modtypesubst ~loc  x0 =
      { psig_loc = loc; psig_desc = (Psig_modtypesubst x0) }
    let psig_open ~loc  x0 = { psig_loc = loc; psig_desc = (Psig_open x0) }
    let psig_include ~loc  x0 =
      { psig_loc = loc; psig_desc = (Psig_include x0) }
    let psig_class ~loc  x0 = { psig_loc = loc; psig_desc = (Psig_class x0) }
    let psig_class_type ~loc  x0 =
      { psig_loc = loc; psig_desc = (Psig_class_type x0) }
    let psig_attribute ~loc  x0 =
      { psig_loc = loc; psig_desc = (Psig_attribute x0) }
    let psig_extension ~loc  x0 x1 =
      { psig_loc = loc; psig_desc = (Psig_extension (x0, x1)) }
    let pstr_eval ~loc  x0 x1 =
      { pstr_loc = loc; pstr_desc = (Pstr_eval (x0, x1)) }
    let pstr_value ~loc  x0 x1 =
      { pstr_loc = loc; pstr_desc = (Pstr_value (x0, x1)) }
    let pstr_primitive ~loc  x0 =
      { pstr_loc = loc; pstr_desc = (Pstr_primitive x0) }
    let pstr_type ~loc  x0 x1 =
      { pstr_loc = loc; pstr_desc = (Pstr_type (x0, x1)) }
    let pstr_typext ~loc  x0 =
      { pstr_loc = loc; pstr_desc = (Pstr_typext x0) }
    let pstr_exception ~loc  x0 =
      { pstr_loc = loc; pstr_desc = (Pstr_exception x0) }
    let pstr_module ~loc  x0 =
      { pstr_loc = loc; pstr_desc = (Pstr_module x0) }
    let pstr_recmodule ~loc  x0 =
      { pstr_loc = loc; pstr_desc = (Pstr_recmodule x0) }
    let pstr_modtype ~loc  x0 =
      { pstr_loc = loc; pstr_desc = (Pstr_modtype x0) }
    let pstr_open ~loc  x0 = { pstr_loc = loc; pstr_desc = (Pstr_open x0) }
    let pstr_class ~loc  x0 = { pstr_loc = loc; pstr_desc = (Pstr_class x0) }
    let pstr_class_type ~loc  x0 =
      { pstr_loc = loc; pstr_desc = (Pstr_class_type x0) }
    let pstr_include ~loc  x0 =
      { pstr_loc = loc; pstr_desc = (Pstr_include x0) }
    let pstr_attribute ~loc  x0 =
      { pstr_loc = loc; pstr_desc = (Pstr_attribute x0) }
    let pstr_extension ~loc  x0 x1 =
      { pstr_loc = loc; pstr_desc = (Pstr_extension (x0, x1)) }
    let toplevel_directive ~loc  ~name  ~arg  =
      { pdir_name = name; pdir_arg = arg; pdir_loc = loc }
    let type_declaration ~loc  ~name  ~params  ~cstrs  ~kind  ~private_ 
      ~manifest  =
      {
        ptype_name = name;
        ptype_params = params;
        ptype_cstrs = cstrs;
        ptype_kind = kind;
        ptype_private = private_;
        ptype_manifest = manifest;
        ptype_attributes = [];
        ptype_loc = loc
      }
    let type_exception ~loc  constructor =
      {
        ptyexn_constructor = constructor;
        ptyexn_loc = loc;
        ptyexn_attributes = []
      }
    let type_extension ~loc  ~path  ~params  ~constructors  ~private_  =
      {
        ptyext_path = path;
        ptyext_params = params;
        ptyext_constructors = constructors;
        ptyext_private = private_;
        ptyext_loc = loc;
        ptyext_attributes = []
      }
    let value_binding ~loc  ~pat  ~expr  =
      { pvb_pat = pat; pvb_expr = expr; pvb_attributes = []; pvb_loc = loc }
    let value_description ~loc  ~name  ~type_  ~prim  =
      {
        pval_name = name;
        pval_type = type_;
        pval_prim = prim;
        pval_attributes = [];
        pval_loc = loc
      }
  end
module Make(Loc:sig val loc : Location.t end) =
  struct
    let loc = Loc.loc
    let attribute ~name  ~payload  =
      { attr_name = name; attr_payload = payload; attr_loc = loc }
    let binding_op ~op  ~pat  ~exp  =
      { pbop_op = op; pbop_pat = pat; pbop_exp = exp; pbop_loc = loc }
    let case ~lhs  ~guard  ~rhs  =
      { pc_lhs = lhs; pc_guard = guard; pc_rhs = rhs }
    let pcl_constr x0 x1 =
      { pcl_attributes = []; pcl_loc = loc; pcl_desc = (Pcl_constr (x0, x1))
      }
    let pcl_structure x0 =
      { pcl_attributes = []; pcl_loc = loc; pcl_desc = (Pcl_structure x0) }
    let pcl_fun x0 x1 x2 x3 =
      {
        pcl_attributes = [];
        pcl_loc = loc;
        pcl_desc = (Pcl_fun (x0, x1, x2, x3))
      }
    let pcl_apply x0 x1 =
      { pcl_attributes = []; pcl_loc = loc; pcl_desc = (Pcl_apply (x0, x1)) }
    let pcl_let x0 x1 x2 =
      { pcl_attributes = []; pcl_loc = loc; pcl_desc = (Pcl_let (x0, x1, x2))
      }
    let pcl_constraint x0 x1 =
      {
        pcl_attributes = [];
        pcl_loc = loc;
        pcl_desc = (Pcl_constraint (x0, x1))
      }
    let pcl_extension x0 =
      { pcl_attributes = []; pcl_loc = loc; pcl_desc = (Pcl_extension x0) }
    let pcl_open x0 x1 =
      { pcl_attributes = []; pcl_loc = loc; pcl_desc = (Pcl_open (x0, x1)) }
    let pcf_inherit x0 x1 x2 =
      {
        pcf_attributes = [];
        pcf_loc = loc;
        pcf_desc = (Pcf_inherit (x0, x1, x2))
      }
    let pcf_val x0 =
      { pcf_attributes = []; pcf_loc = loc; pcf_desc = (Pcf_val x0) }
    let pcf_method x0 =
      { pcf_attributes = []; pcf_loc = loc; pcf_desc = (Pcf_method x0) }
    let pcf_constraint x0 =
      { pcf_attributes = []; pcf_loc = loc; pcf_desc = (Pcf_constraint x0) }
    let pcf_initializer x0 =
      { pcf_attributes = []; pcf_loc = loc; pcf_desc = (Pcf_initializer x0) }
    let pcf_attribute x0 =
      { pcf_attributes = []; pcf_loc = loc; pcf_desc = (Pcf_attribute x0) }
    let pcf_extension x0 =
      { pcf_attributes = []; pcf_loc = loc; pcf_desc = (Pcf_extension x0) }
    let class_infos ~virt  ~params  ~name  ~expr  =
      {
        pci_virt = virt;
        pci_params = params;
        pci_name = name;
        pci_expr = expr;
        pci_loc = loc;
        pci_attributes = []
      }
    let class_signature ~self  ~fields  =
      { pcsig_self = self; pcsig_fields = fields }
    let class_structure ~self  ~fields  =
      { pcstr_self = self; pcstr_fields = fields }
    let pcty_constr x0 x1 =
      {
        pcty_attributes = [];
        pcty_loc = loc;
        pcty_desc = (Pcty_constr (x0, x1))
      }
    let pcty_signature x0 =
      { pcty_attributes = []; pcty_loc = loc; pcty_desc = (Pcty_signature x0)
      }
    let pcty_arrow x0 x1 x2 =
      {
        pcty_attributes = [];
        pcty_loc = loc;
        pcty_desc = (Pcty_arrow (x0, x1, x2))
      }
    let pcty_extension x0 =
      { pcty_attributes = []; pcty_loc = loc; pcty_desc = (Pcty_extension x0)
      }
    let pcty_open x0 x1 =
      {
        pcty_attributes = [];
        pcty_loc = loc;
        pcty_desc = (Pcty_open (x0, x1))
      }
    let pctf_inherit x0 =
      { pctf_attributes = []; pctf_loc = loc; pctf_desc = (Pctf_inherit x0) }
    let pctf_val x0 =
      { pctf_attributes = []; pctf_loc = loc; pctf_desc = (Pctf_val x0) }
    let pctf_method x0 =
      { pctf_attributes = []; pctf_loc = loc; pctf_desc = (Pctf_method x0) }
    let pctf_constraint x0 =
      {
        pctf_attributes = [];
        pctf_loc = loc;
        pctf_desc = (Pctf_constraint x0)
      }
    let pctf_attribute x0 =
      { pctf_attributes = []; pctf_loc = loc; pctf_desc = (Pctf_attribute x0)
      }
    let pctf_extension x0 =
      { pctf_attributes = []; pctf_loc = loc; pctf_desc = (Pctf_extension x0)
      }
    let constructor_declaration ~name  ~vars  ~args  ~res  =
      {
        pcd_name = name;
        pcd_vars = vars;
        pcd_args = args;
        pcd_res = res;
        pcd_loc = loc;
        pcd_attributes = []
      }
    let ptyp_any =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = Ptyp_any
      }
    let ptyp_var x0 =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = (Ptyp_var x0)
      }
    let ptyp_arrow x0 x1 x2 =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = (Ptyp_arrow (x0, x1, x2))
      }
    let ptyp_tuple x0 =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = (Ptyp_tuple x0)
      }
    let ptyp_constr x0 x1 =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = (Ptyp_constr (x0, x1))
      }
    let ptyp_object x0 x1 =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = (Ptyp_object (x0, x1))
      }
    let ptyp_class x0 x1 =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = (Ptyp_class (x0, x1))
      }
    let ptyp_alias x0 x1 =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = (Ptyp_alias (x0, x1))
      }
    let ptyp_variant x0 x1 x2 =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = (Ptyp_variant (x0, x1, x2))
      }
    let ptyp_poly x0 x1 =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = (Ptyp_poly (x0, x1))
      }
    let ptyp_package x0 =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = (Ptyp_package x0)
      }
    let ptyp_extension x0 =
      {
        ptyp_loc_stack = [];
        ptyp_attributes = [];
        ptyp_loc = loc;
        ptyp_desc = (Ptyp_extension x0)
      }
    let pdir_string x0 = { pdira_loc = loc; pdira_desc = (Pdir_string x0) }
    let pdir_int x0 x1 =
      { pdira_loc = loc; pdira_desc = (Pdir_int (x0, x1)) }
    let pdir_ident x0 = { pdira_loc = loc; pdira_desc = (Pdir_ident x0) }
    let pdir_bool x0 = { pdira_loc = loc; pdira_desc = (Pdir_bool x0) }
    let pexp_ident x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_ident x0)
      }
    let pexp_constant x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_constant x0)
      }
    let pexp_let x0 x1 x2 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_let (x0, x1, x2))
      }
    let pexp_function x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_function x0)
      }
    let pexp_fun x0 x1 x2 x3 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_fun (x0, x1, x2, x3))
      }
    let pexp_apply x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_apply (x0, x1))
      }
    let pexp_match x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_match (x0, x1))
      }
    let pexp_try x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_try (x0, x1))
      }
    let pexp_tuple x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_tuple x0)
      }
    let pexp_construct x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_construct (x0, x1))
      }
    let pexp_variant x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_variant (x0, x1))
      }
    let pexp_record x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_record (x0, x1))
      }
    let pexp_field x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_field (x0, x1))
      }
    let pexp_setfield x0 x1 x2 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_setfield (x0, x1, x2))
      }
    let pexp_array x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_array x0)
      }
    let pexp_ifthenelse x0 x1 x2 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_ifthenelse (x0, x1, x2))
      }
    let pexp_sequence x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_sequence (x0, x1))
      }
    let pexp_while x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_while (x0, x1))
      }
    let pexp_for x0 x1 x2 x3 x4 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_for (x0, x1, x2, x3, x4))
      }
    let pexp_constraint x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_constraint (x0, x1))
      }
    let pexp_coerce x0 x1 x2 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_coerce (x0, x1, x2))
      }
    let pexp_send x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_send (x0, x1))
      }
    let pexp_new x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_new x0)
      }
    let pexp_setinstvar x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_setinstvar (x0, x1))
      }
    let pexp_override x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_override x0)
      }
    let pexp_letmodule x0 x1 x2 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_letmodule (x0, x1, x2))
      }
    let pexp_letexception x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_letexception (x0, x1))
      }
    let pexp_assert x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_assert x0)
      }
    let pexp_lazy x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_lazy x0)
      }
    let pexp_poly x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_poly (x0, x1))
      }
    let pexp_object x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_object x0)
      }
    let pexp_newtype x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_newtype (x0, x1))
      }
    let pexp_pack x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_pack x0)
      }
    let pexp_open x0 x1 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_open (x0, x1))
      }
    let pexp_letop x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_letop x0)
      }
    let pexp_extension x0 =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = (Pexp_extension x0)
      }
    let pexp_unreachable =
      {
        pexp_loc_stack = [];
        pexp_attributes = [];
        pexp_loc = loc;
        pexp_desc = Pexp_unreachable
      }
    let extension_constructor ~name  ~kind  =
      {
        pext_name = name;
        pext_kind = kind;
        pext_loc = loc;
        pext_attributes = []
      }
    let include_infos mod_ =
      { pincl_mod = mod_; pincl_loc = loc; pincl_attributes = [] }
    let label_declaration ~name  ~mutable_  ~type_  =
      {
        pld_name = name;
        pld_mutable = mutable_;
        pld_type = type_;
        pld_loc = loc;
        pld_attributes = []
      }
    let letop ~let_  ~ands  ~body  = { let_; ands; body }
    let location ~start  ~end_  ~ghost  =
      { loc_start = start; loc_end = end_; loc_ghost = ghost }
    let module_binding ~name  ~expr  =
      { pmb_name = name; pmb_expr = expr; pmb_attributes = []; pmb_loc = loc
      }
    let module_declaration ~name  ~type_  =
      { pmd_name = name; pmd_type = type_; pmd_attributes = []; pmd_loc = loc
      }
    let pmod_ident x0 =
      { pmod_attributes = []; pmod_loc = loc; pmod_desc = (Pmod_ident x0) }
    let pmod_structure x0 =
      { pmod_attributes = []; pmod_loc = loc; pmod_desc = (Pmod_structure x0)
      }
    let pmod_functor x0 x1 =
      {
        pmod_attributes = [];
        pmod_loc = loc;
        pmod_desc = (Pmod_functor (x0, x1))
      }
    let pmod_apply x0 x1 =
      {
        pmod_attributes = [];
        pmod_loc = loc;
        pmod_desc = (Pmod_apply (x0, x1))
      }
    let pmod_constraint x0 x1 =
      {
        pmod_attributes = [];
        pmod_loc = loc;
        pmod_desc = (Pmod_constraint (x0, x1))
      }
    let pmod_unpack x0 =
      { pmod_attributes = []; pmod_loc = loc; pmod_desc = (Pmod_unpack x0) }
    let pmod_extension x0 =
      { pmod_attributes = []; pmod_loc = loc; pmod_desc = (Pmod_extension x0)
      }
    let module_substitution ~name  ~manifest  =
      {
        pms_name = name;
        pms_manifest = manifest;
        pms_attributes = [];
        pms_loc = loc
      }
    let pmty_ident x0 =
      { pmty_attributes = []; pmty_loc = loc; pmty_desc = (Pmty_ident x0) }
    let pmty_signature x0 =
      { pmty_attributes = []; pmty_loc = loc; pmty_desc = (Pmty_signature x0)
      }
    let pmty_functor x0 x1 =
      {
        pmty_attributes = [];
        pmty_loc = loc;
        pmty_desc = (Pmty_functor (x0, x1))
      }
    let pmty_with x0 x1 =
      {
        pmty_attributes = [];
        pmty_loc = loc;
        pmty_desc = (Pmty_with (x0, x1))
      }
    let pmty_typeof x0 =
      { pmty_attributes = []; pmty_loc = loc; pmty_desc = (Pmty_typeof x0) }
    let pmty_extension x0 =
      { pmty_attributes = []; pmty_loc = loc; pmty_desc = (Pmty_extension x0)
      }
    let pmty_alias x0 =
      { pmty_attributes = []; pmty_loc = loc; pmty_desc = (Pmty_alias x0) }
    let module_type_declaration ~name  ~type_  =
      {
        pmtd_name = name;
        pmtd_type = type_;
        pmtd_attributes = [];
        pmtd_loc = loc
      }
    let otag x0 x1 =
      { pof_attributes = []; pof_loc = loc; pof_desc = (Otag (x0, x1)) }
    let oinherit x0 =
      { pof_attributes = []; pof_loc = loc; pof_desc = (Oinherit x0) }
    let open_infos ~expr  ~override  =
      {
        popen_expr = expr;
        popen_override = override;
        popen_loc = loc;
        popen_attributes = []
      }
    let ppat_any =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = Ppat_any
      }
    let ppat_var x0 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_var x0)
      }
    let ppat_alias x0 x1 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_alias (x0, x1))
      }
    let ppat_constant x0 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_constant x0)
      }
    let ppat_interval x0 x1 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_interval (x0, x1))
      }
    let ppat_tuple x0 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_tuple x0)
      }
    let ppat_construct x0 x1 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_construct (x0, x1))
      }
    let ppat_variant x0 x1 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_variant (x0, x1))
      }
    let ppat_record x0 x1 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_record (x0, x1))
      }
    let ppat_array x0 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_array x0)
      }
    let ppat_or x0 x1 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_or (x0, x1))
      }
    let ppat_constraint x0 x1 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_constraint (x0, x1))
      }
    let ppat_type x0 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_type x0)
      }
    let ppat_lazy x0 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_lazy x0)
      }
    let ppat_unpack x0 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_unpack x0)
      }
    let ppat_exception x0 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_exception x0)
      }
    let ppat_extension x0 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_extension x0)
      }
    let ppat_open x0 x1 =
      {
        ppat_loc_stack = [];
        ppat_attributes = [];
        ppat_loc = loc;
        ppat_desc = (Ppat_open (x0, x1))
      }
    let position ~fname  ~lnum  ~bol  ~cnum  =
      { pos_fname = fname; pos_lnum = lnum; pos_bol = bol; pos_cnum = cnum }
    let rtag x0 x1 x2 =
      { prf_attributes = []; prf_loc = loc; prf_desc = (Rtag (x0, x1, x2)) }
    let rinherit x0 =
      { prf_attributes = []; prf_loc = loc; prf_desc = (Rinherit x0) }
    let psig_value x0 = { psig_loc = loc; psig_desc = (Psig_value x0) }
    let psig_type x0 x1 =
      { psig_loc = loc; psig_desc = (Psig_type (x0, x1)) }
    let psig_typesubst x0 =
      { psig_loc = loc; psig_desc = (Psig_typesubst x0) }
    let psig_typext x0 = { psig_loc = loc; psig_desc = (Psig_typext x0) }
    let psig_exception x0 =
      { psig_loc = loc; psig_desc = (Psig_exception x0) }
    let psig_module x0 = { psig_loc = loc; psig_desc = (Psig_module x0) }
    let psig_modsubst x0 = { psig_loc = loc; psig_desc = (Psig_modsubst x0) }
    let psig_recmodule x0 =
      { psig_loc = loc; psig_desc = (Psig_recmodule x0) }
    let psig_modtype x0 = { psig_loc = loc; psig_desc = (Psig_modtype x0) }
    let psig_modtypesubst x0 =
      { psig_loc = loc; psig_desc = (Psig_modtypesubst x0) }
    let psig_open x0 = { psig_loc = loc; psig_desc = (Psig_open x0) }
    let psig_include x0 = { psig_loc = loc; psig_desc = (Psig_include x0) }
    let psig_class x0 = { psig_loc = loc; psig_desc = (Psig_class x0) }
    let psig_class_type x0 =
      { psig_loc = loc; psig_desc = (Psig_class_type x0) }
    let psig_attribute x0 =
      { psig_loc = loc; psig_desc = (Psig_attribute x0) }
    let psig_extension x0 x1 =
      { psig_loc = loc; psig_desc = (Psig_extension (x0, x1)) }
    let pstr_eval x0 x1 =
      { pstr_loc = loc; pstr_desc = (Pstr_eval (x0, x1)) }
    let pstr_value x0 x1 =
      { pstr_loc = loc; pstr_desc = (Pstr_value (x0, x1)) }
    let pstr_primitive x0 =
      { pstr_loc = loc; pstr_desc = (Pstr_primitive x0) }
    let pstr_type x0 x1 =
      { pstr_loc = loc; pstr_desc = (Pstr_type (x0, x1)) }
    let pstr_typext x0 = { pstr_loc = loc; pstr_desc = (Pstr_typext x0) }
    let pstr_exception x0 =
      { pstr_loc = loc; pstr_desc = (Pstr_exception x0) }
    let pstr_module x0 = { pstr_loc = loc; pstr_desc = (Pstr_module x0) }
    let pstr_recmodule x0 =
      { pstr_loc = loc; pstr_desc = (Pstr_recmodule x0) }
    let pstr_modtype x0 = { pstr_loc = loc; pstr_desc = (Pstr_modtype x0) }
    let pstr_open x0 = { pstr_loc = loc; pstr_desc = (Pstr_open x0) }
    let pstr_class x0 = { pstr_loc = loc; pstr_desc = (Pstr_class x0) }
    let pstr_class_type x0 =
      { pstr_loc = loc; pstr_desc = (Pstr_class_type x0) }
    let pstr_include x0 = { pstr_loc = loc; pstr_desc = (Pstr_include x0) }
    let pstr_attribute x0 =
      { pstr_loc = loc; pstr_desc = (Pstr_attribute x0) }
    let pstr_extension x0 x1 =
      { pstr_loc = loc; pstr_desc = (Pstr_extension (x0, x1)) }
    let toplevel_directive ~name  ~arg  =
      { pdir_name = name; pdir_arg = arg; pdir_loc = loc }
    let type_declaration ~name  ~params  ~cstrs  ~kind  ~private_  ~manifest 
      =
      {
        ptype_name = name;
        ptype_params = params;
        ptype_cstrs = cstrs;
        ptype_kind = kind;
        ptype_private = private_;
        ptype_manifest = manifest;
        ptype_attributes = [];
        ptype_loc = loc
      }
    let type_exception constructor =
      {
        ptyexn_constructor = constructor;
        ptyexn_loc = loc;
        ptyexn_attributes = []
      }
    let type_extension ~path  ~params  ~constructors  ~private_  =
      {
        ptyext_path = path;
        ptyext_params = params;
        ptyext_constructors = constructors;
        ptyext_private = private_;
        ptyext_loc = loc;
        ptyext_attributes = []
      }
    let value_binding ~pat  ~expr  =
      { pvb_pat = pat; pvb_expr = expr; pvb_attributes = []; pvb_loc = loc }
    let value_description ~name  ~type_  ~prim  =
      {
        pval_name = name;
        pval_type = type_;
        pval_prim = prim;
        pval_attributes = [];
        pval_loc = loc
      }
  end

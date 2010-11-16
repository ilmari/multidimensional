#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "hook_op_check.h"

#define __PACKAGE__ "multidimensional"

STATIC OP *multidimensional_helem_check_op (pTHX_ OP *op, void *user_data) {
    SV **hint = hv_fetchs(GvHV(PL_hintgv), __PACKAGE__, 0);

    PERL_UNUSED_ARG(user_data);

    if (!hint || !SvOK(*hint))
	return op;

    const OP *last = ((BINOP*)op)->op_first->op_sibling;
    if (last && last->op_type == OP_JOIN) {
	const OP *first = ((LISTOP*)last)->op_first;
	const OP *next = first->op_sibling;
	if (first && first->op_type == OP_PUSHMARK
	    && next && next->op_type == OP_RV2SV
	) {
	    const OP *child = ((UNOP*)next)->op_first;
	    if (child->op_type == OP_GV
		&& GvSV(cGVOPx_gv(child)) == get_sv(";", 0)
	    ) {
		croak("Use of multidimensional array emulation");
	    }
	}
    }
    return op;
}

STATIC hook_op_check_id multidimensional_hook_id = 0;

MODULE = multidimensional PACKAGE = multidimensional

PROTOTYPES: ENABLE

BOOT:
    if(!multidimensional_hook_id)
	multidimensional_hook_id = hook_op_check(OP_HELEM, multidimensional_helem_check_op, NULL);


    /* TODO?
    hook_op_check_remove(OP_HELEM, multidimensional_hook_id);
    multidimensional_hook_id = 0;
    */

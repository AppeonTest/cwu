﻿$PBExportHeader$w_hgm000h.srw
$PBExportComments$품목(중분류) 조회 response
forward
global type w_hgm000h from w_response
end type
type dw_head from datawindow within w_hgm000h
end type
type gb_1 from groupbox within w_hgm000h
end type
type gb_2 from groupbox within w_hgm000h
end type
end forward

global type w_hgm000h from w_response
integer width = 2994
integer height = 1684
string title = "품목(중분류) 조회"
dw_head dw_head
gb_1 gb_1
gb_2 gb_2
end type
global w_hgm000h w_hgm000h

forward prototypes
public subroutine wf_ok (integer ai_row)
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_ok (integer ai_row);
gstru_uid_uname.s_parm[1] = dw_responst.object.item_middle[ai_row]
gstru_uid_uname.s_parm[2] = dw_responst.object.midd_name[ai_row]


end subroutine

public subroutine wf_retrieve ();
string ls_large_code, ls_large_name, ls_midd_code, ls_midd_name

dw_head.accepttext()

ls_large_code = trim(dw_head.object.c_large_code[1]) + '%'
ls_large_name = trim(dw_head.object.c_large_name[1]) + '%'
ls_midd_code = trim(dw_head.object.c_midd_code[1]) + '%'
ls_midd_name = trim(dw_head.object.c_midd_name[1]) + '%'

IF ISNULL(ls_large_code) THEN ls_large_code = '%'
IF ISNULL(ls_large_name) THEN ls_large_name = '%'
IF ISNULL(ls_midd_code) THEN ls_midd_code = '%'
IF ISNULL(ls_midd_name) THEN ls_midd_name = '%'

dw_responst.setredraw(false)
dw_responst.retrieve( ls_large_code, ls_large_name, ls_midd_code, ls_midd_name  ) 
dw_responst.setredraw(true)
dw_responst.setfocus()
end subroutine

on w_hgm000h.create
int iCurrent
call super::create
this.dw_head=create dw_head
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_head
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.gb_2
end on

on w_hgm000h.destroy
call super::destroy
destroy(this.dw_head)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;dw_head.reset()
dw_head.insertrow(0)

dw_head.object.c_midd_name[1] = message.stringparm

dw_responst.reset()


wf_retrieve()



end event

event show;/*		 OVERRIDING   */
end event

type pb_cancel from w_response`pb_cancel within w_hgm000h
integer x = 2665
integer y = 1480
integer taborder = 40
end type

type pb_ok from w_response`pb_ok within w_hgm000h
integer x = 2377
integer y = 1480
integer taborder = 30
end type

event pb_ok::clicked;call super::clicked;
int li_row

IF dw_responst.rowcount() <> 0 THEN

	li_row   = dw_responst.getrow()  
	
	wf_ok(li_row)
	
	closewithreturn(parent,'O')

END IF
end event

type st_sttitle00001 from w_response`st_sttitle00001 within w_hgm000h
integer y = 1480
integer width = 2354
integer height = 92
end type

type dw_responst from w_response`dw_responst within w_hgm000h
integer x = 46
integer y = 268
integer width = 2880
integer height = 1156
string dataobject = "d_hgm000h_2"
end type

event dw_responst::key_enter;call super::key_enter;
int li_row

IF dw_responst.rowcount() <> 0 THEN

	li_row   = this.getrow() 
	
	wf_ok(li_row)
	
	closewithreturn(parent,'O')

END IF
end event

event dw_responst::doubleclicked;call super::doubleclicked;
IF dw_responst.rowcount() <> 0 THEN

	wf_ok(row)
	
	closewithreturn(parent,'O')

END IF

end event

event dw_responst::rowfocuschanged;call super::rowfocuschanged;//this.selectrow( 0, false )
//this.selectrow( currentrow, true )
end event

type dw_head from datawindow within w_hgm000h
event ue_keydown pbm_dwnprocessenter
integer x = 59
integer y = 92
integer width = 2839
integer height = 92
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_hgm000h_1"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;
wf_retrieve()
end event

type gb_1 from groupbox within w_hgm000h
integer x = 32
integer y = 28
integer width = 2889
integer height = 176
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8388608
string text = "조회조건"
end type

type gb_2 from groupbox within w_hgm000h
integer x = 27
integer y = 216
integer width = 2917
integer height = 1252
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = styleraised!
end type


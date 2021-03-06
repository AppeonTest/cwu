﻿$PBExportHeader$w_master_tab.srw
$PBExportComments$Single Master, tab Detail Window
forward
global type w_master_tab from w_window
end type
type dw_con from uo_dw within w_master_tab
end type
type dw_main from uo_dw within w_master_tab
end type
type uc_row_insert from u_picture within w_master_tab
end type
type uc_row_delete from u_picture within w_master_tab
end type
type tab_1 from tab within w_master_tab
end type
type tabpage_1 from userobject within tab_1
end type
type st_tab1_line from statictext within tabpage_1
end type
type dw_tab1 from uo_grid within tabpage_1
end type
type tabpage_1 from userobject within tab_1
st_tab1_line st_tab1_line
dw_tab1 dw_tab1
end type
type tabpage_2 from userobject within tab_1
end type
type st_tab2_line from statictext within tabpage_2
end type
type dw_tab2 from uo_grid within tabpage_2
end type
type tabpage_2 from userobject within tab_1
st_tab2_line st_tab2_line
dw_tab2 dw_tab2
end type
type tabpage_3 from userobject within tab_1
end type
type st_tab3_line from statictext within tabpage_3
end type
type dw_tab3 from uo_grid within tabpage_3
end type
type tabpage_3 from userobject within tab_1
st_tab3_line st_tab3_line
dw_tab3 dw_tab3
end type
type tab_1 from tab within w_master_tab
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type uo_1 from u_tab within w_master_tab
end type
type p_2 from picture within w_master_tab
end type
type st_detail from statictext within w_master_tab
end type
type p_1 from picture within w_master_tab
end type
type st_main from statictext within w_master_tab
end type
end forward

global type w_master_tab from w_window
dw_con dw_con
dw_main dw_main
uc_row_insert uc_row_insert
uc_row_delete uc_row_delete
tab_1 tab_1
uo_1 uo_1
p_2 p_2
st_detail st_detail
p_1 p_1
st_main st_main
end type
global w_master_tab w_master_tab

type variables
DataWindow	idw_tab[]

end variables

forward prototypes
public function integer wf_validall ()
end prototypes

public function integer wf_validall ();Integer	li_rtn, i

For I = 1 To UpperBound(idw_update)
	If func.of_checknull(idw_update[i]) = -1 Then
		Return -1
	End If
Next

end function

on w_master_tab.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
this.uc_row_insert=create uc_row_insert
this.uc_row_delete=create uc_row_delete
this.tab_1=create tab_1
this.uo_1=create uo_1
this.p_2=create p_2
this.st_detail=create st_detail
this.p_1=create p_1
this.st_main=create st_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
this.Control[iCurrent+3]=this.uc_row_insert
this.Control[iCurrent+4]=this.uc_row_delete
this.Control[iCurrent+5]=this.tab_1
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.p_2
this.Control[iCurrent+8]=this.st_detail
this.Control[iCurrent+9]=this.p_1
this.Control[iCurrent+10]=this.st_main
end on

on w_master_tab.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
destroy(this.uc_row_insert)
destroy(this.uc_row_delete)
destroy(this.tab_1)
destroy(this.uo_1)
destroy(this.p_2)
destroy(this.st_detail)
destroy(this.p_1)
destroy(this.st_main)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
func.of_design_dw( dw_main )

This.Event ue_resize_dw( tab_1.tabpage_1.st_tab1_line, tab_1.tabpage_1.dw_tab1 )
This.Event ue_resize_dw( tab_1.tabpage_2.st_tab2_line, tab_1.tabpage_2.dw_tab2 )
This.Event ue_resize_dw( tab_1.tabpage_3.st_tab3_line, tab_1.tabpage_3.dw_tab3 )
//만일 dw_tab1, dw_tab2, dw_tab3가 Single Row이면 uo_dw를 사용하여
//dw_tab1, dw_tab2, dw_tab3를 만들고
//func.of_design_dw( tab_1.tabpage_1.dw_tab1 )
//func.of_design_dw( tab_1.tabpage_2.dw_tab2 )
//func.of_design_dw( tab_1.tabpage_3.dw_tab3 )

dw_con.insertrow(0)

idw_update[1]	= dw_main
idw_update[2]	= tab_1.tabpage_1.dw_tab1
idw_update[3]	= tab_1.tabpage_2.dw_tab2
idw_update[4]	= tab_1.tabpage_3.dw_tab3
//만일 update dw와 변경 여부 check하는 dw가 다른 경우에는
//idw_modified[1]	= dw_save

//Excel 저장할 DataWindow가 있으면 지정
//idw_Toexcel[1]	= dw_main
//idw_Toexcel[2]	= tab_1.tabpage_1.dw_tab1
//idw_Toexcel[3]	= tab_1.tabpage_2.dw_tab2
//idw_Toexcel[4]	= tab_1.tabpage_3.dw_tab3

idw_tab[1] = tab_1.tabpage_1.dw_tab1
idw_tab[2] = tab_1.tabpage_2.dw_tab2
idw_tab[3] = tab_1.tabpage_3.dw_tab3

tab_1.tabpage_1.dw_tab1.iw_parent = This
tab_1.tabpage_2.dw_tab2.iw_parent = This
tab_1.tabpage_3.dw_tab3.iw_parent = This

tab_1.tabpage_1.dw_tab1.Width	= tab_1.Width	- 60
tab_1.tabpage_2.dw_tab2.Width	= tab_1.Width	- 60
tab_1.tabpage_3.dw_tab3.Width	= tab_1.Width	- 60
tab_1.tabpage_1.dw_tab1.Height	= tab_1.Height	- 144
tab_1.tabpage_2.dw_tab2.Height	= tab_1.Height	- 144
tab_1.tabpage_3.dw_tab3.Height	= tab_1.Height	- 144

//wait 화면을 표시하고 싶은 처리에 한해 지정
//ib_save_wait		= TRUE		//저장 시
//ib_retrieve_wait	= TRUE		//조회 시
//ib_excel_wait		= TRUE		//엑셀 다운로드 시
//ib_excelload_wait	= TRUE		//엑셀 upload 시
//ib_spcall_wait		= TRUE		//Stored Procedure Call 시

end event

event ue_insert;call super::ue_insert;Long		ll_rv
String		ls_txt

ll_rv = dw_main.Event ue_InsertRow()

ls_txt = "[신규] "
If ll_rv = 1 Then
	f_set_message(ls_txt + '신규 행이 추가 되었습니다.', '', parentwin)
ElseIf ll_rv = 0 Then
	
Else
	f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
End If

end event

event ue_delete;call super::ue_delete;String		ls_txt

ls_txt = "[삭제] "
If dw_main.RowCount() > 0 Then
	If dw_main.Event ue_deleterow() > 0 Then
		tab_1.tabpage_1.dw_tab1.uf_DeleteAll()
		tab_1.tabpage_2.dw_tab2.uf_DeleteAll()
		tab_1.tabpage_3.dw_tab3.uf_DeleteAll()
		If Trigger Event ue_save() <> 1 Then
			f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
		Else
			f_set_message(ls_txt + '정상적으로 삭제되었습니다.', '', parentwin)
		End If
	Else
		f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
	End If
End If

end event

event ue_inquiry;call super::ue_inquiry;Long		ll_rv

ll_rv = This.Event ue_updatequery() 
If ll_rv <> 1 And ll_rv <> 2 Then RETURN -1

SetPointer(HourGlass!)
If ib_retrieve_wait Then
	gf_openwait()
End If
ll_rv = dw_main.Event ue_Retrieve()
If ll_rv > 0 Then
	f_set_message("[조회] " + '자료가 조회되었습니다.', '', parentwin)
ElseIf ll_rv = 0 Then
	f_set_message("[조회] " + '자료가 없습니다.', '', parentwin)
Else
	f_set_message("[조회] " + '오류가 발생했습니다.', '', parentwin)
End If
If ib_retrieve_wait Then
	gf_closewait()
End If
SetPointer(Arrow!)
ib_excl_yn = FALSE

RETURN ll_rv

end event

event ue_button_set;call super::ue_button_set;If uc_row_insert.Enabled Then
	uc_row_insert.Visible	= TRUE
Else
	uc_row_insert.Visible	= FALSE
End If

If uc_row_delete.Enabled Then
	uc_row_delete.Visible	= TRUE
Else
	uc_row_delete.Visible	= FALSE
End If

end event

type ln_templeft from w_window`ln_templeft within w_master_tab
end type

type ln_tempright from w_window`ln_tempright within w_master_tab
end type

type ln_temptop from w_window`ln_temptop within w_master_tab
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_master_tab
end type

type ln_tempbutton from w_window`ln_tempbutton within w_master_tab
end type

type ln_tempstart from w_window`ln_tempstart within w_master_tab
end type

type uc_retrieve from w_window`uc_retrieve within w_master_tab
integer width = 274
end type

type uc_insert from w_window`uc_insert within w_master_tab
integer width = 274
end type

type uc_delete from w_window`uc_delete within w_master_tab
integer width = 274
end type

type uc_save from w_window`uc_save within w_master_tab
integer width = 274
end type

type uc_excel from w_window`uc_excel within w_master_tab
integer width = 274
end type

type uc_print from w_window`uc_print within w_master_tab
integer width = 274
end type

type st_line1 from w_window`st_line1 within w_master_tab
end type

type st_line2 from w_window`st_line2 within w_master_tab
end type

type st_line3 from w_window`st_line3 within w_master_tab
end type

type uc_excelroad from w_window`uc_excelroad within w_master_tab
integer width = 393
end type

type dw_con from uo_dw within w_master_tab
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_dw within w_master_tab
event type long ue_retrieve ( )
integer x = 50
integer y = 416
integer width = 4389
integer height = 696
integer taborder = 11
boolean border = false
end type

event type long ue_Retrieve();String		ls_arg1
String		ls_arg2
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_arg1 = dw_con.object.arg1[dw_con.GetRow()]
ls_arg2 = dw_con.object.arg2[dw_con.GetRow()]

ll_rv = This.Retrieve(ls_arg1, ls_arg2)
If ll_rv > 0 Then
	tab_1.selectTab(1)
	tab_1.tabpage_1.dw_tab1.Retrieve(ls_arg1, ls_arg2)
	tab_1.tabpage_2.dw_tab2.Retrieve(ls_arg1, ls_arg2)
	tab_1.tabpage_3.dw_tab3.Retrieve(ls_arg1, ls_arg2)
Else
	tab_1.tabpage_1.dw_tab1.Reset()
	tab_1.tabpage_2.dw_tab2.Reset()
	tab_1.tabpage_3.dw_tab3.Reset()
End If

RETURN ll_rv

end event

event ue_deleteend;call super::ue_deleteend;If tab_1.tabpage_1.dw_tab1.uf_DeleteAll() < 0 Then RETURN -1
If tab_1.tabpage_2.dw_tab2.uf_DeleteAll() < 0 Then RETURN -1
If tab_1.tabpage_3.dw_tab3.uf_DeleteAll() < 0 Then RETURN -1

RETURN 1

end event

event ue_insertstart;call super::ue_insertstart;If AncestorReturnValue = 1 Then
	tab_1.tabpage_1.dw_tab1.Reset()
	tab_1.tabpage_2.dw_tab2.Reset()
	tab_1.tabpage_3.dw_tab3.Reset()
End If

RETURN AncestorReturnValue

end event

type uc_row_insert from u_picture within w_master_tab
integer x = 3890
integer y = 1132
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_input.gif"
end type

event clicked;call super::clicked;Integer		li_selectedtab

li_SelectedTab = tab_1.SelectedTab

If dw_main.RowCount() > 0 Then
//	tab_1.Control[li_SelectedTab].PostEvent("ue_InsertRow")
	idw_tab[li_SelectedTab].PostEvent("ue_InsertRow")
End If

end event

type uc_row_delete from u_picture within w_master_tab
integer x = 4169
integer y = 1132
integer width = 274
integer height = 84
boolean bringtotop = true
string picturename = "..\img\button\topBtn_delete.gif"
end type

event clicked;call super::clicked;Integer		li_selectedtab

li_SelectedTab = tab_1.SelectedTab

//tab_1.Control[li_SelectedTab].PostEvent("ue_DeleteRow")
idw_tab[li_SelectedTab].PostEvent("ue_DeleteRow")


end event

type tab_1 from tab within w_master_tab
integer x = 50
integer y = 1220
integer width = 4389
integer height = 1044
integer taborder = 31
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
boolean raggedright = true
boolean showpicture = false
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4352
integer height = 932
long backcolor = 16777215
string text = "tab1"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
st_tab1_line st_tab1_line
dw_tab1 dw_tab1
end type

on tabpage_1.create
this.st_tab1_line=create st_tab1_line
this.dw_tab1=create dw_tab1
this.Control[]={this.st_tab1_line,&
this.dw_tab1}
end on

on tabpage_1.destroy
destroy(this.st_tab1_line)
destroy(this.dw_tab1)
end on

type st_tab1_line from statictext within tabpage_1
boolean visible = false
integer x = 105
integer y = 24
integer width = 55
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
long bordercolor = 16777215
boolean focusrectangle = false
end type

type dw_tab1 from uo_grid within tabpage_1
integer x = 5
integer y = 16
integer width = 4329
integer height = 916
integer taborder = 20
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event constructor;call super::constructor;iw_parent = Parent.GetParent().GetParent()

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4352
integer height = 932
long backcolor = 16777215
string text = "tab2"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
st_tab2_line st_tab2_line
dw_tab2 dw_tab2
end type

on tabpage_2.create
this.st_tab2_line=create st_tab2_line
this.dw_tab2=create dw_tab2
this.Control[]={this.st_tab2_line,&
this.dw_tab2}
end on

on tabpage_2.destroy
destroy(this.st_tab2_line)
destroy(this.dw_tab2)
end on

type st_tab2_line from statictext within tabpage_2
boolean visible = false
integer x = 123
integer y = 32
integer width = 55
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
long bordercolor = 16777215
boolean focusrectangle = false
end type

type dw_tab2 from uo_grid within tabpage_2
integer x = 5
integer y = 16
integer width = 4329
integer height = 668
integer taborder = 30
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event ue_constructor;call super::ue_constructor;iw_parent = Parent.GetParent().GetParent()

end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4352
integer height = 932
long backcolor = 16777215
string text = "tab3"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
st_tab3_line st_tab3_line
dw_tab3 dw_tab3
end type

on tabpage_3.create
this.st_tab3_line=create st_tab3_line
this.dw_tab3=create dw_tab3
this.Control[]={this.st_tab3_line,&
this.dw_tab3}
end on

on tabpage_3.destroy
destroy(this.st_tab3_line)
destroy(this.dw_tab3)
end on

type st_tab3_line from statictext within tabpage_3
boolean visible = false
integer x = 178
integer y = 40
integer width = 55
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
long bordercolor = 16777215
boolean focusrectangle = false
end type

type dw_tab3 from uo_grid within tabpage_3
integer x = 5
integer y = 16
integer width = 4329
integer height = 668
integer taborder = 10
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event ue_constructor;call super::ue_constructor;iw_parent = Parent.GetParent().GetParent()

end event

type uo_1 from u_tab within w_master_tab
integer x = 558
integer y = 1208
integer taborder = 21
boolean bringtotop = true
end type

on uo_1.destroy
call u_tab::destroy
end on

type p_2 from picture within w_master_tab
integer x = 50
integer y = 1144
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_detail from statictext within w_master_tab
integer x = 114
integer y = 1132
integer width = 1051
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 27678488
long backcolor = 16777215
string text = "detail desc"
boolean focusrectangle = false
end type

type p_1 from picture within w_master_tab
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_master_tab
integer x = 114
integer y = 312
integer width = 1051
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 27678488
long backcolor = 16777215
string text = "main desc"
boolean focusrectangle = false
end type


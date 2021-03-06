﻿$PBExportHeader$w_hfn306q.srw
$PBExportComments$삭제전표 List 조회
forward
global type w_hfn306q from w_msheet
end type
type tab_1 from tab within w_hfn306q
end type
type tabpage_1 from userobject within tab_1
end type
type dw_list from cuo_dwwindow_one_hin within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_list dw_list
end type
type tabpage_2 from userobject within tab_1
end type
type dw_print from uo_dwfree within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
end type
type tab_1 from tab within w_hfn306q
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_acct_class from datawindow within w_hfn306q
end type
type dw_con from uo_dwfree within w_hfn306q
end type
type uo_tab from u_tab within w_hfn306q
end type
end forward

global type w_hfn306q from w_msheet
integer height = 2616
string title = "삭제전표리스트"
tab_1 tab_1
dw_acct_class dw_acct_class
dw_con dw_con
uo_tab uo_tab
end type
global w_hfn306q w_hfn306q

type variables
datawindow	idw_list
end variables

on w_hfn306q.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.dw_acct_class=create dw_acct_class
this.dw_con=create dw_con
this.uo_tab=create uo_tab
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_acct_class
this.Control[iCurrent+3]=this.dw_con
this.Control[iCurrent+4]=this.uo_tab
end on

on w_hfn306q.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.dw_acct_class)
destroy(this.dw_con)
destroy(this.uo_tab)
end on

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////
////	작성목적 : 삭제 전표 내역을 조회
////	작 성 인 : 이현수
////	작성일자 : 2002.11
////	변 경 인 : 
////	변경일자 : 
//// 변경사유 :
////////////////////////////////////////////////////////////////////////////////////////////
//datawindowchild	ldwc_temp
//string				ls_str_date, ls_last_date
//
//idw_list  = tab_1.tabpage_1.dw_list
//idw_print = tab_1.tabpage_2.dw_print
//
//idw_print.sharedata(idw_list)
//
//idw_print.object.datawindow.print.preview = true
//
//// 초기값처리
//dw_acct_class.GetChild('code',ldwc_Temp)
//ldwc_Temp.SetTransObject(SQLCA)
//IF ldwc_Temp.Retrieve('acct_class',1) = 0 THEN
//	ldwc_Temp.InsertRow(0)
//END IF
//
//dw_acct_class.InsertRow(0)
//dw_acct_class.Object.code[1] = '1'
//
//ls_str_date  = f_today()
//ls_last_date = f_lastdate(f_today())
//
//em_fr_date.Text = left(ls_str_date,4) + '/' + mid(ls_str_date,5,2) + '/' + right(ls_str_date,2)
//em_to_date.Text = left(ls_last_date,4) + '/' + mid(ls_last_date,5,2) + '/' + right(ls_last_date,2)
//
end event

event ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
integer	li_acct_class
string	ls_from_date, ls_to_date
String	ls_Msg
date		ld_date

wf_SetMsg('조회조건 체크 중입니다...')

dw_con.accepttext()

// 전표기간 입력여부 체크

ls_from_date = TRIM(string(dw_con.object.fr_date[1], 'yyyymmdd'))
IF NOT f_isDate(ls_from_date) THEN
	MessageBox('확인','전표기간(FROM)을 올바르게 입력하시기 바랍니다.')
	dw_con.SetFocus()
	dw_con.setcolumn('fr_date')
	return -1
END IF


ls_to_date = TRIM(string(dw_con.object.to_date[1], 'yyyymmdd'))
IF NOT f_isDate(ls_to_date) THEN
	MessageBox('확인','전표기간(TO)를 올바르게 입력하시기 바랍니다.')
	dw_con.SetFocus()
	dw_con.setcolumn('to_date')
	return -1
END IF

IF ls_from_date > ls_to_date THEN
	MessageBox('확인','전표기간 올바르지 않습니다.')
	dw_con.SetFocus()
	dw_con.setcolumn('to_date')
	return -1
END IF


idw_list.retrieve(gi_acct_class, ls_from_date, ls_to_date) 



end event

event ue_print;call super::ue_print;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_print
////	기 능 설 명: 조회된 자료를 출력한다.
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//f_print(idw_print)
//
end event

event ue_postopen;call super::ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////
//	작성목적 : 삭제 전표 내역을 조회
//	작 성 인 : 이현수
//	작성일자 : 2002.11
//	변 경 인 : 
//	변경일자 : 
// 변경사유 :
//////////////////////////////////////////////////////////////////////////////////////////
datawindowchild	ldwc_temp
string				ls_str_date, ls_last_date

idw_list  = tab_1.tabpage_1.dw_list
idw_print = tab_1.tabpage_2.dw_print

idw_print.sharedata(idw_list)

idw_print.object.datawindow.print.preview = true

// 초기값처리
ls_str_date  = f_today()
ls_last_date = f_lastdate(f_today())

dw_con.object.fr_date[1] = date(left(ls_str_date,4) + '/' + mid(ls_str_date,5,2) + '/' + right(ls_str_date,2))
dw_con.object.to_date[1] = date(left(ls_last_date,4) + '/' + mid(ls_last_date,5,2) + '/' + right(ls_last_date,2))

end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "출력물 Title")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hfn306q
end type

type ln_tempright from w_msheet`ln_tempright within w_hfn306q
end type

type ln_temptop from w_msheet`ln_temptop within w_hfn306q
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hfn306q
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hfn306q
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hfn306q
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hfn306q
end type

type uc_insert from w_msheet`uc_insert within w_hfn306q
end type

type uc_delete from w_msheet`uc_delete within w_hfn306q
end type

type uc_save from w_msheet`uc_save within w_hfn306q
end type

type uc_excel from w_msheet`uc_excel within w_hfn306q
end type

type uc_print from w_msheet`uc_print within w_hfn306q
end type

type st_line1 from w_msheet`st_line1 within w_hfn306q
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line2 from w_msheet`st_line2 within w_hfn306q
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type st_line3 from w_msheet`st_line3 within w_hfn306q
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 1073741824
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hfn306q
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hfn306q
end type

type tab_1 from tab within w_hfn306q
integer x = 50
integer y = 320
integer width = 4384
integer height = 2040
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
alignment alignment = center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;//choose case newindex
//	case 1
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('PRINT',		FALSE)
//	case else
//		wf_setMenu('RETRIEVE',	TRUE)
//		wf_setMenu('PRINT',		TRUE)
//end choose
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1920
string text = "삭제전표 리스트"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_list dw_list
end type

on tabpage_1.create
this.dw_list=create dw_list
this.Control[]={this.dw_list}
end on

on tabpage_1.destroy
destroy(this.dw_list)
end on

type dw_list from cuo_dwwindow_one_hin within tabpage_1
integer y = 8
integer width = 4352
integer height = 1908
integer taborder = 20
string dataobject = "d_hfn306q_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event rowfocuschanged;// override
if currentrow < 1 then return

//selectrow(0,false)
//selectrow(currentrow,true)
//
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1920
string text = "삭제전표 리스트내역"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_print dw_print
end type

on tabpage_2.create
this.dw_print=create dw_print
this.Control[]={this.dw_print}
end on

on tabpage_2.destroy
destroy(this.dw_print)
end on

type dw_print from uo_dwfree within tabpage_2
integer width = 4347
integer height = 1912
integer taborder = 190
string dataobject = "d_hfn306q_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
end event

type dw_acct_class from datawindow within w_hfn306q
boolean visible = false
integer x = 3419
integer y = 80
integer width = 421
integer height = 80
integer taborder = 60
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "ddw_common_code"
boolean border = false
boolean livescroll = true
end type

type dw_con from uo_dwfree within w_hfn306q
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 180
boolean bringtotop = true
string dataobject = "d_hfn306q_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;settransobject(sqlca)
func.of_design_con(dw_con)
This.insertrow(0)
end event

event itemchanged;call super::itemchanged;parent.triggerevent('ue_retrieve')
end event

type uo_tab from u_tab within w_hfn306q
event destroy ( )
integer x = 1582
integer y = 304
integer taborder = 130
boolean bringtotop = true
long backcolor = 1073741824
string selecttabobject = "tab_1"
end type

on uo_tab.destroy
call u_tab::destroy
end on


﻿$PBExportHeader$w_hac703p.srw
$PBExportComments$추경 자금 예산서(예산부서용)
forward
global type w_hac703p from w_print_form1
end type
type st_2 from statictext within w_hac703p
end type
end forward

global type w_hac703p from w_print_form1
string title = "추경 자금 예산서(예산부서용)"
st_2 st_2
end type
global w_hac703p w_hac703p

forward prototypes
public subroutine wf_retrieve ()
end prototypes

public subroutine wf_retrieve ();// ==========================================================================================
// 기    능 : 	retrieve
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 함수원형 : 	wf_retrieve()
// 인    수 :
// 되 돌 림 :
// 주의사항 :
// 수정사항 :
// ==========================================================================================
String ls_bdgt_year, ls_slip_class
Integer	li_bdgt_class
dw_con.accepttext()

ls_bdgt_year = String(dw_con.object.year[1], 'yyyy')
ls_slip_class = dw_con.object.slip_class[1]
If ls_slip_class = '' Or isnull(ls_slip_class) Then ls_slip_class = ''
li_bdgt_class = Integer(dw_con.object.bdgt_class[1])


dw_print.retrieve(ls_bdgt_year, gi_acct_class, ls_slip_class, li_bdgt_class, is_amt_gubun)

end subroutine

on w_hac703p.create
int iCurrent
call super::create
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
end on

on w_hac703p.destroy
call super::destroy
destroy(this.st_2)
end on

event ue_open;call super::ue_open;//// ==========================================================================================
//// 작성목정 :	Window Open
//// 작 성 인 : 	이현수
//// 작성일자 : 	2002.10
//// 변 경 인 :
//// 변경일자 :
//// 변경사유 :
//// ==========================================================================================
//
//
//
//is_amt_gubun	=	'3'
//
end event

event ue_postopen;call super::ue_postopen;// ==========================================================================================
// 작성목정 :	Window Open
// 작 성 인 : 	이현수
// 작성일자 : 	2002.10
// 변 경 인 :
// 변경일자 :
// 변경사유 :
// ==========================================================================================


dw_con.object.year[1] = date(string(f_today(), '@@@@/@@/@@'))
dw_con.getchild('bdgt_class', idw_child)
idw_child.settransobject(sqlca)
if idw_child.retrieve('bdgt_class', 1) < 1 then
	idw_child.reset()
	idw_child.insertrow(0)
	return	
end if

dw_con.object.bdgt_class[1] = '0'
is_amt_gubun	=	'3'
idw_print = dw_print

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

type ln_templeft from w_print_form1`ln_templeft within w_hac703p
end type

type ln_tempright from w_print_form1`ln_tempright within w_hac703p
end type

type ln_temptop from w_print_form1`ln_temptop within w_hac703p
end type

type ln_tempbuttom from w_print_form1`ln_tempbuttom within w_hac703p
end type

type ln_tempbutton from w_print_form1`ln_tempbutton within w_hac703p
end type

type ln_tempstart from w_print_form1`ln_tempstart within w_hac703p
end type

type uc_retrieve from w_print_form1`uc_retrieve within w_hac703p
end type

type uc_insert from w_print_form1`uc_insert within w_hac703p
end type

type uc_delete from w_print_form1`uc_delete within w_hac703p
end type

type uc_save from w_print_form1`uc_save within w_hac703p
end type

type uc_excel from w_print_form1`uc_excel within w_hac703p
end type

type uc_print from w_print_form1`uc_print within w_hac703p
end type

type st_line1 from w_print_form1`st_line1 within w_hac703p
end type

type st_line2 from w_print_form1`st_line2 within w_hac703p
end type

type st_line3 from w_print_form1`st_line3 within w_hac703p
end type

type uc_excelroad from w_print_form1`uc_excelroad within w_hac703p
end type

type ln_dwcon from w_print_form1`ln_dwcon within w_hac703p
end type

type uo_slip_class from w_print_form1`uo_slip_class within w_hac703p
boolean visible = false
end type

type rb_3 from w_print_form1`rb_3 within w_hac703p
boolean visible = false
end type

type rb_2 from w_print_form1`rb_2 within w_hac703p
boolean visible = false
end type

type rb_1 from w_print_form1`rb_1 within w_hac703p
boolean visible = false
end type

type gb_1 from w_print_form1`gb_1 within w_hac703p
boolean visible = false
integer x = 1938
end type

type uo_bdgt_year from w_print_form1`uo_bdgt_year within w_hac703p
boolean visible = false
integer x = 69
end type

type gb_3 from w_print_form1`gb_3 within w_hac703p
boolean visible = false
end type

type st_back from w_print_form1`st_back within w_hac703p
boolean visible = false
end type

type dw_print from w_print_form1`dw_print within w_hac703p
string dataobject = "d_hac703p_1_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_con from w_print_form1`dw_con within w_hac703p
string dataobject = "d_hac703p_con"
end type

event dw_con::constructor;call super::constructor;st_2.setposition(totop!)
end event

type st_2 from statictext within w_hac703p
integer x = 2834
integer y = 196
integer width = 736
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 18751006
long backcolor = 31112622
string text = "※ 반드시 조회를 해주세요."
boolean focusrectangle = false
end type


﻿$PBExportHeader$w_hdr303p.srw
$PBExportComments$[청운대]미등록명단
forward
global type w_hdr303p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hdr303p
end type
type dw_con from uo_dwfree within w_hdr303p
end type
end forward

global type w_hdr303p from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hdr303p w_hdr303p

on w_hdr303p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hdr303p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_retrieve;string 	ls_year, ls_hakgi, ls_gwa, ls_gubun
long 		ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwa    	=	func.of_nvl(dw_con.Object.gwa[1], '%') + '%'
ls_gubun		=	dw_con.Object.gubun[1]

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return -1
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

if ls_gubun = '1' Then
	dw_main.dataobject = 'd_hdr303p_1'
	dw_main.settransobject(sqlca)
	ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwa)
elseif ls_gubun = '2' Then
	dw_main.dataobject = 'd_hdr303p_2'
	dw_main.settransobject(sqlca)
	ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwa)
end if	

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwa)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1
end event

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

String ls_year, ls_hakgi

SELECT	NEXT_YEAR, NEXT_HAKGI
INTO		:ls_year,       :ls_hakgi
FROM		HAKSA.HAKSA_ILJUNG
WHERE	SIJUM_FLAG = 'Y'
USING SQLCA ;

dw_con.Object.year[1]   = ls_year
dw_con.Object.hakgi[1]	= ls_hakgi
end event

type ln_templeft from w_condition_window`ln_templeft within w_hdr303p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hdr303p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hdr303p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hdr303p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hdr303p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hdr303p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hdr303p
end type

type uc_insert from w_condition_window`uc_insert within w_hdr303p
end type

type uc_delete from w_condition_window`uc_delete within w_hdr303p
end type

type uc_save from w_condition_window`uc_save within w_hdr303p
end type

type uc_excel from w_condition_window`uc_excel within w_hdr303p
end type

type uc_print from w_condition_window`uc_print within w_hdr303p
end type

type st_line1 from w_condition_window`st_line1 within w_hdr303p
end type

type st_line2 from w_condition_window`st_line2 within w_hdr303p
end type

type st_line3 from w_condition_window`st_line3 within w_hdr303p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hdr303p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hdr303p
end type

type gb_1 from w_condition_window`gb_1 within w_hdr303p
end type

type gb_2 from w_condition_window`gb_2 within w_hdr303p
end type

type dw_main from uo_search_dwc within w_hdr303p
integer x = 50
integer y = 300
integer width = 4379
integer height = 1964
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hdr303p_1"
end type

type dw_con from uo_dwfree within w_hdr303p
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 130
boolean bringtotop = true
string dataobject = "d_hdr303p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;
Choose Case dwo.name
	Case 'gubun'
		If data = '1' Then
			dw_main.dataobject = 'd_hdr303p_1'	
			dw_main.settransobject(sqlca)
		ElseIf data = '2' Then
			dw_main.dataobject = 'd_hdr303p_2'	
			dw_main.settransobject(sqlca)
		End If
		
End Choose

	
end event


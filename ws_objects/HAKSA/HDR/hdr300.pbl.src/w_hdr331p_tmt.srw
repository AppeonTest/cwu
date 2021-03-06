﻿$PBExportHeader$w_hdr331p_tmt.srw
$PBExportComments$[청운대]분납고지서출력(신규)
forward
global type w_hdr331p_tmt from w_condition_window
end type
type dw_main from uo_search_dwc within w_hdr331p_tmt
end type
type dw_con from uo_dwfree within w_hdr331p_tmt
end type
type uo_1 from uo_imgbtn within w_hdr331p_tmt
end type
end forward

global type w_hdr331p_tmt from w_condition_window
dw_main dw_main
dw_con dw_con
uo_1 uo_1
end type
global w_hdr331p_tmt w_hdr331p_tmt

on w_hdr331p_tmt.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.uo_1
end on

on w_hdr331p_tmt.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.uo_1)
end on

event ue_retrieve;string 	ls_year, ls_hakgi, ls_hakyun, ls_gwa, ls_hakbun
long 		ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_gwa		=	func.of_nvl(dw_con.Object.gwa[1], '%')
ls_hakbun   =  func.of_nvl(dw_con.Object.hakbun[1], '%')

if ls_year = '' or isnull(ls_year) or ls_hakgi = '' or isnull(ls_hakgi) then
	messagebox("확인","년도, 학기를 입력하세요.")
	return -1
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi, ls_gwa, ls_hakbun)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

dw_main.Object.DataWindow.Zoom = 50
dw_main.modify("DataWindow.Print.Preview = yes")

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

type ln_templeft from w_condition_window`ln_templeft within w_hdr331p_tmt
end type

type ln_tempright from w_condition_window`ln_tempright within w_hdr331p_tmt
end type

type ln_temptop from w_condition_window`ln_temptop within w_hdr331p_tmt
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hdr331p_tmt
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hdr331p_tmt
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hdr331p_tmt
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hdr331p_tmt
end type

type uc_insert from w_condition_window`uc_insert within w_hdr331p_tmt
end type

type uc_delete from w_condition_window`uc_delete within w_hdr331p_tmt
end type

type uc_save from w_condition_window`uc_save within w_hdr331p_tmt
end type

type uc_excel from w_condition_window`uc_excel within w_hdr331p_tmt
end type

type uc_print from w_condition_window`uc_print within w_hdr331p_tmt
end type

type st_line1 from w_condition_window`st_line1 within w_hdr331p_tmt
end type

type st_line2 from w_condition_window`st_line2 within w_hdr331p_tmt
end type

type st_line3 from w_condition_window`st_line3 within w_hdr331p_tmt
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hdr331p_tmt
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hdr331p_tmt
end type

type gb_1 from w_condition_window`gb_1 within w_hdr331p_tmt
end type

type gb_2 from w_condition_window`gb_2 within w_hdr331p_tmt
end type

type dw_main from uo_search_dwc within w_hdr331p_tmt
integer x = 50
integer y = 300
integer width = 4384
integer height = 1964
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hdr331p_3"
end type

type dw_con from uo_dwfree within w_hdr331p_tmt
integer x = 55
integer y = 168
integer width = 4379
integer height = 112
integer taborder = 150
boolean bringtotop = true
string dataobject = "d_hdr331p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type uo_1 from uo_imgbtn within w_hdr331p_tmt
integer x = 745
integer y = 40
integer width = 471
integer taborder = 20
boolean bringtotop = true
string btnname = "공지사항등록"
end type

event clicked;call super::clicked;string ls_year, ls_hakgi

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

openwithparm(w_hdr204pp_1, ls_year + ls_hakgi)
end event

on uo_1.destroy
call uo_imgbtn::destroy
end on


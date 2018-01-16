﻿$PBExportHeader$w_hjk804p.srw
$PBExportComments$[청운대]졸업생명단출력
forward
global type w_hjk804p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hjk804p
end type
type dw_con from uo_dwfree within w_hjk804p
end type
end forward

global type w_hjk804p from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_hjk804p w_hjk804p

type variables
datawindowchild ldwc_hjmod
end variables

on w_hjk804p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_hjk804p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1] = func.of_get_sdate('YYYY')
end event

event ue_retrieve;int		li_row
string 	ls_year

dw_con.AcceptText()

ls_year  = dw_con.Object.year[1]
	
li_row = dw_main.retrieve(ls_year)	

if li_row = 0 then
	uf_messagebox(7)
	
elseif li_row = -1 then
	uf_messagebox(8)
end if

dw_main.setfocus()

Return 1

end event

type ln_templeft from w_condition_window`ln_templeft within w_hjk804p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hjk804p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hjk804p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hjk804p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hjk804p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hjk804p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hjk804p
end type

type uc_insert from w_condition_window`uc_insert within w_hjk804p
end type

type uc_delete from w_condition_window`uc_delete within w_hjk804p
end type

type uc_save from w_condition_window`uc_save within w_hjk804p
end type

type uc_excel from w_condition_window`uc_excel within w_hjk804p
end type

type uc_print from w_condition_window`uc_print within w_hjk804p
end type

type st_line1 from w_condition_window`st_line1 within w_hjk804p
end type

type st_line2 from w_condition_window`st_line2 within w_hjk804p
end type

type st_line3 from w_condition_window`st_line3 within w_hjk804p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hjk804p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hjk804p
end type

type gb_1 from w_condition_window`gb_1 within w_hjk804p
end type

type gb_2 from w_condition_window`gb_2 within w_hjk804p
end type

type dw_main from uo_search_dwc within w_hjk804p
integer x = 50
integer y = 296
integer width = 4379
integer height = 1968
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hjk804p_1"
end type

type dw_con from uo_dwfree within w_hjk804p
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_hjk804p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type


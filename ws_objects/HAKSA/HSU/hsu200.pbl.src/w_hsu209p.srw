﻿$PBExportHeader$w_hsu209p.srw
$PBExportComments$[청운대]대체강의신청서_조회,출력
forward
global type w_hsu209p from w_condition_window
end type
type dw_main from uo_search_dwc within w_hsu209p
end type
type dw_con from uo_dwfree within w_hsu209p
end type
type dw_search from uo_dwfree within w_hsu209p
end type
end forward

global type w_hsu209p from w_condition_window
dw_main dw_main
dw_con dw_con
dw_search dw_search
end type
global w_hsu209p w_hsu209p

type variables
datawindowchild ldwc_hjmod
end variables

forward prototypes
public subroutine wf_siganpyo (string as_year, string as_hakgi, string as_sigan, string as_sigan_value, integer al_row, string as_head_1, string as_head_2)
end prototypes

public subroutine wf_siganpyo (string as_year, string as_hakgi, string as_sigan, string as_sigan_value, integer al_row, string as_head_1, string as_head_2);//시간표에 Setting		   
string ls_sigan, ls_set

dw_main.object.t_year.text		=	as_year
dw_main.object.t_hakgi.text	=	as_hakgi

dw_main.object.head_1[al_row]	=	as_head_1
dw_main.object.head_2[al_row]	=	as_head_2

ls_sigan = dw_main.GetItemString(al_row, as_sigan)

If isNull(ls_sigan) Or ls_sigan = '' Then
	ls_set	= as_sigan_value
Else
	ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
End If		

dw_main.SetItem(al_row, as_sigan, ls_set)

//CHOOSE CASE as_sigan	
//		
//	CASE 'a1'
//		ls_sigan = dw_main.object.a1[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		
//		dw_main.object.a1[al_row] =  ls_set
//		
//	CASE 'a2'
//		ls_sigan = dw_main.object.a2[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		
//	 	dw_main.object.a2[al_row] =  ls_set
//
//	CASE 'a3'
//		ls_sigan = dw_main.object.a3[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.a3[al_row] =  ls_set
//		
//	CASE 'a4'
//		ls_sigan = dw_main.object.a4[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.a4[al_row] =  ls_set
//		
//	CASE 'a5'
//		ls_sigan = dw_main.object.a5[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.a5[al_row] =  ls_set
//		
//	CASE 'a6'
//		ls_sigan = dw_main.object.a6[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.a6[al_row] =  ls_set
//		
//	CASE 'a7'
//		ls_sigan = dw_main.object.a7[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.a7[al_row] =  ls_set
//		
//	CASE 'a8'
//		ls_sigan = dw_main.object.a8[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.a8[al_row] =  ls_set
//		
//	CASE 'a9'
//		ls_sigan = dw_main.object.a9[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.a9[al_row] =  ls_set
//		
//	CASE 'a10'
//		ls_sigan = dw_main.object.a10[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.a10[al_row] =  ls_set
//		
//	CASE 'a11'
//		ls_sigan = dw_main.object.a11[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.a11[al_row] =  ls_set
//		
//	CASE 'a12'
//		ls_sigan = dw_main.object.a12[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.a12[al_row] =  ls_set
//		
//	CASE 'a13'
//		ls_sigan = dw_main.object.a13[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.a13[al_row] =  ls_set
//		
//	CASE 'a14'
//		ls_sigan = dw_main.object.a4[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.a14[al_row] =  ls_set
//	
//	CASE 'b1'
//		ls_sigan = dw_main.object.b1[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b1[al_row] =  ls_set
//		
//	CASE 'b2'
//		ls_sigan = dw_main.object.b2[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b2[al_row] =  ls_set
//		
//	CASE 'b3'
//		ls_sigan = dw_main.object.b3[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b3[al_row] =  ls_set
//		
//	CASE 'b4'
//		ls_sigan = dw_main.object.b4[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b4[al_row] =  ls_set
//		
//	CASE 'b5'
//		ls_sigan = dw_main.object.b5[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b5[al_row] =  ls_set
//		
//	CASE 'b6'
//		ls_sigan = dw_main.object.b6[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b6[al_row] =  ls_set
//		
//	CASE 'b7'
//		ls_sigan = dw_main.object.b7[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b7[al_row] =  ls_set
//		
//	CASE 'b8'
//		ls_sigan = dw_main.object.b8[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b8[al_row] =  ls_set
//		
//	CASE 'b9'
//		ls_sigan = dw_main.object.b9[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b9[al_row] =  ls_set
//		
//	CASE 'b10'
//		ls_sigan = dw_main.object.b10[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b10[al_row] =  ls_set
//		
//	CASE 'b11'
//		ls_sigan = dw_main.object.b11[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b11[al_row] =  ls_set
//		
//	CASE 'b12'
//		ls_sigan = dw_main.object.b12[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b12[al_row] =  ls_set
//		
//	CASE 'b13'
//		ls_sigan = dw_main.object.b13[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b13[al_row] =  ls_set
//		
//	CASE 'b14'
//		ls_sigan = dw_main.object.b14[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.b14[al_row] =  ls_set	
//		
//	CASE 'c1'
//		ls_sigan = dw_main.object.c1[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.c1[al_row] =  ls_set
//		
//	CASE 'c2'
//		ls_sigan = dw_main.object.c2[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.c2[al_row] =  ls_set
//		
//	CASE 'c3'
//		ls_sigan = dw_main.object.c3[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.c3[al_row] =  ls_set
//		
//	CASE 'c4'
//		ls_sigan = dw_main.object.c4[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.c4[al_row] =  ls_set
//		
//	CASE 'c5'
//		ls_sigan = dw_main.object.c5[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.c5[al_row] =  ls_set
//		
//	CASE 'c6'
//		ls_sigan = dw_main.object.c6[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if		
//		dw_main.object.c6[al_row] =  ls_set
//		
//	CASE 'c7'
//		ls_sigan = dw_main.object.c7[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.c7[al_row] =   ls_set
//		
//	CASE 'c8'
//		ls_sigan = dw_main.object.c8[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.c8[al_row] =  ls_set
//		
//	CASE 'c9'
//		ls_sigan = dw_main.object.c9[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.c9[al_row] =  ls_set
//		
//	CASE 'c10'
//		ls_sigan = dw_main.object.c10[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.c10[al_row] =  ls_set
//		
//	CASE 'c11'
//		ls_sigan = dw_main.object.c11[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.c11[al_row] =  ls_set
//		
//	CASE 'c12'
//		ls_sigan = dw_main.object.c12[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.c12[al_row] =  ls_set
//		
//	CASE 'c13'
//		ls_sigan = dw_main.object.c13[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.c13[al_row] =  ls_set
//		
//	CASE 'c14'
//		ls_sigan = dw_main.object.c14[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.c14[al_row] =  ls_set
//		
//	
//	CASE 'd1'
//		ls_sigan = dw_main.object.d1[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d1[al_row] =  ls_set
//		
//	CASE 'd2'
//		ls_sigan = dw_main.object.d2[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d2[al_row] =  ls_set
//		
//	CASE 'd3'
//		ls_sigan = dw_main.object.d3[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d3[al_row] =  ls_set
//		
//	CASE 'd4'
//		ls_sigan = dw_main.object.d4[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d4[al_row] =  ls_set
//		
//	CASE 'd5'
//		ls_sigan = dw_main.object.d5[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d5[al_row] =  ls_set
//		
//	CASE 'd6'
//		ls_sigan = dw_main.object.d6[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d6[al_row] =  ls_set
//		
//	CASE 'd7'
//		ls_sigan = dw_main.object.d7[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d7[al_row] =  ls_set
//		
//	CASE 'd8'
//		ls_sigan = dw_main.object.d8[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d8[al_row] =  ls_set
//		
//	CASE 'd9'
//		ls_sigan = dw_main.object.d9[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d9[al_row] =  ls_set
//		
//	CASE 'd10'
//		ls_sigan = dw_main.object.d10[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d10[al_row] =  ls_set
//		
//	CASE 'd11'
//		ls_sigan = dw_main.object.d11[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d11[al_row] =  ls_set
//		
//	CASE 'd12'
//		ls_sigan = dw_main.object.d12[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d12[al_row] =  ls_set
//		
//	CASE 'd13'
//		ls_sigan = dw_main.object.d13[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d13[al_row] =  ls_set
//		
//	CASE 'd14'
//		ls_sigan = dw_main.object.d14[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.d14[al_row] =  ls_set
//		
//		
//	CASE 'e1'
//		ls_sigan = dw_main.object.e1[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e1[al_row] =  ls_set
//		
//	CASE 'e2'
//		ls_sigan = dw_main.object.e2[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e2[al_row] =  ls_set
//		
//	CASE 'e3'
//		ls_sigan = dw_main.object.e3[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e3[al_row] =  ls_set
//		
//	CASE 'e4'
//		ls_sigan = dw_main.object.e4[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e4[al_row] =  ls_set
//		
//	CASE 'e5'	
//		ls_sigan = dw_main.object.e5[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e5[al_row] =  ls_set
//		
//	CASE 'e6'
//		ls_sigan = dw_main.object.e6[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e6[al_row] =  ls_set
//		
//	CASE 'e7'
//		ls_sigan = dw_main.object.e7[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e7[al_row] =  ls_set
//		
//	CASE 'e8'
//		ls_sigan = dw_main.object.e8[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e8[al_row] =  ls_set
//		
//	CASE 'e9'
//		ls_sigan = dw_main.object.e9[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e9[al_row] =  ls_set
//		
//	CASE 'e10'
//		ls_sigan = dw_main.object.e10[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e10[al_row] =  ls_set
//		
//	CASE 'e11'
//		ls_sigan = dw_main.object.e11[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e11[al_row] =  ls_set
//		
//	CASE 'e12'
//		ls_sigan = dw_main.object.e12[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e12[al_row] =  ls_set
//		
//	CASE 'e13'
//		ls_sigan = dw_main.object.e13[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e13[al_row] =  ls_set
//		
//	CASE 'e14'
//		ls_sigan = dw_main.object.e14[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.e14[al_row] =  ls_set
//	
//	CASE 'f1'
//		ls_sigan = dw_main.object.f1[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f1[al_row] =  ls_set
//		
//	CASE 'f2'
//		ls_sigan = dw_main.object.f2[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f2[al_row] =  ls_set
//		
//	CASE 'f3'
//		ls_sigan = dw_main.object.f3[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f3[al_row] =  ls_set
//		
//	CASE 'f4'
//		ls_sigan = dw_main.object.f4[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f4[al_row] =  ls_set
//		
//	CASE 'f5'
//		ls_sigan = dw_main.object.f5[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f5[al_row] =  ls_set
//		
//	CASE 'f6'
//		ls_sigan = dw_main.object.f6[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//	  	dw_main.object.f6[al_row] =  ls_set
//		  
//	CASE 'f7'
//		ls_sigan = dw_main.object.f7[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//	  	dw_main.object.f7[al_row] =  ls_set
//		  
//	CASE 'f6'
//		ls_sigan = dw_main.object.f8[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f8[al_row] =  ls_set
//		
//	CASE 'f9'
//		ls_sigan = dw_main.object.f9[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f9[al_row] =  ls_set
//		
//	CASE 'f10'
//		ls_sigan = dw_main.object.f10[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f10[al_row] =  ls_set
//		
//	CASE 'f11'
//		ls_sigan = dw_main.object.f11[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f11[al_row] =  ls_set
//		
//	CASE 'f12'
//		ls_sigan = dw_main.object.f12[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f12[al_row] =  ls_set
//		
//	CASE 'f13'
//		ls_sigan = dw_main.object.f13[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f13[al_row] =  ls_set
//		
//	CASE 'f14'
//		ls_sigan = dw_main.object.f14[al_row]
//		
//		if isnull(ls_sigan) or ls_sigan = '' then
//			ls_set	= as_sigan_value
//		else
//			ls_set	=	ls_sigan + '~r~n~r~n' + as_sigan_value
//		end if
//		dw_main.object.f14[al_row] =  ls_set	
//		
//		
//END CHOOSE
end subroutine

on w_hsu209p.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
this.dw_search=create dw_search
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.dw_search
end on

on w_hsu209p.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
destroy(this.dw_search)
end on

event open;call super::open;idw_print = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

dw_con.Object.year[1]   = f_haksa_iljung_year()
dw_con.Object.hakgi[1]	= f_haksa_iljung_hakgi()

//사용자가 교수이면 검색조건의 교수를 ENABLED
if f_enabled_chk(gs_empcode) = 1 then
	dw_con.Object.prof_no[1] = gs_empcode
    dw_con.Object.prof_no.Protect = 0
	
end if

if gs_empcode	=	'A0002' then
	dw_con.Object.prof_no.Protect = 1
end if
end event

event ue_retrieve;string	ls_year, ls_hakgi, ls_member_no
long		li_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_member_no	=  func.of_nvl(dw_con.Object.prof_no[1], '%')

if	ls_year = "" or isnull(ls_year) then
	uf_messagebox(12)
	dw_con.SetFocus()
	dw_con.SetColumn("year")
	return -1
elseif ls_hakgi = "" or isnull(ls_hakgi) then
	uf_messagebox(14)
	dw_con.SetFocus()
	dw_con.SetColumn("hakgi")
	return -1
end if

li_ans	=	dw_search.retrieve(ls_year,	ls_hakgi,   ls_member_no)

if li_ans = 0 then
	dw_search.reset()
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
	return 1
elseif li_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)	
	return 1
else
	dw_search.setfocus()
end if

Return 1
end event

type ln_templeft from w_condition_window`ln_templeft within w_hsu209p
end type

type ln_tempright from w_condition_window`ln_tempright within w_hsu209p
end type

type ln_temptop from w_condition_window`ln_temptop within w_hsu209p
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_hsu209p
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_hsu209p
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_hsu209p
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_hsu209p
end type

type uc_insert from w_condition_window`uc_insert within w_hsu209p
end type

type uc_delete from w_condition_window`uc_delete within w_hsu209p
end type

type uc_save from w_condition_window`uc_save within w_hsu209p
end type

type uc_excel from w_condition_window`uc_excel within w_hsu209p
end type

type uc_print from w_condition_window`uc_print within w_hsu209p
end type

type st_line1 from w_condition_window`st_line1 within w_hsu209p
end type

type st_line2 from w_condition_window`st_line2 within w_hsu209p
end type

type st_line3 from w_condition_window`st_line3 within w_hsu209p
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_hsu209p
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_hsu209p
end type

type gb_1 from w_condition_window`gb_1 within w_hsu209p
end type

type gb_2 from w_condition_window`gb_2 within w_hsu209p
end type

type dw_main from uo_search_dwc within w_hsu209p
integer x = 55
integer y = 1300
integer width = 4379
integer height = 964
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_hsu209p"
end type

type dw_con from uo_dwfree within w_hsu209p
integer x = 50
integer y = 164
integer width = 4384
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hsu208p_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_search from uo_dwfree within w_hsu209p
integer x = 55
integer y = 292
integer width = 4379
integer height = 1000
integer taborder = 31
boolean bringtotop = true
string dataobject = "d_hsu209p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event doubleclicked;call super::doubleclicked;string	ls_year, ls_hakgi, ls_member_no, ls_sinchung_gwamok_id
long		li_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]
ls_member_no	=  func.of_nvl(dw_con.Object.prof_no[1], '%')

ls_sinchung_gwamok_id	=	this.object.sinchung_gwamok_id[row]

li_ans	=	dw_main.retrieve(ls_year,	ls_hakgi, ls_member_no, ls_sinchung_gwamok_id)

if li_ans = 0 then
	dw_main.reset()
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
	return 1
elseif li_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)	
	return 1
else
	dw_main.setfocus()
end if


end event

event constructor;call super::constructor;This.SetTransObject(sqlca)
end event


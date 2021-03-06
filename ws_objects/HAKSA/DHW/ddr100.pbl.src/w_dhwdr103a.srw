﻿$PBExportHeader$w_dhwdr103a.srw
$PBExportComments$[대학원장학] 외부장학생관리
forward
global type w_dhwdr103a from w_condition_window
end type
type dw_main from uo_input_dwc within w_dhwdr103a
end type
type dw_con from uo_dwfree within w_dhwdr103a
end type
end forward

global type w_dhwdr103a from w_condition_window
dw_main dw_main
dw_con dw_con
end type
global w_dhwdr103a w_dhwdr103a

on w_dhwdr103a.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_con=create dw_con
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_con
end on

on w_dhwdr103a.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_con)
end on

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_hakgi, ls_gwajung, ls_hakgwa, ls_jungong
long ll_ans

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return -1
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ll_ans = dw_main.retrieve(ls_year, ls_hakgi)

if ll_ans = 0 then
	//조회한 자료가 없을때 메세지 출력
	uf_messagebox(7)
elseif ll_ans = -1 then
	//조회시 오류가 발생했을때 메세지 출력
	uf_messagebox(8)
end if

Return 1

end event

event ue_insert;call super::ue_insert;string ls_year, ls_hakgi, ls_dhw, ls_hakgwa, ls_gwajung
long ll_line

dw_con.AcceptText()

ls_year		=	dw_con.Object.year[1]
ls_hakgi		=	dw_con.Object.hakgi[1]

if ls_year =''or isnull(ls_year) or ls_hakgi ='' or isnull(ls_hakgi) then
	messagebox('확인', "년도, 학기를 입력하세요.")
	return 
	dw_con.setfocus()
	dw_con.SetColumn("year")
end if

ll_line = dw_main.insertrow(0)
dw_main.scrolltorow(ll_line)

dw_main.object.d_janghak_wibu_year[ll_line]	=	ls_year
dw_main.object.d_janghak_wibu_hakgi[ll_line]	=	ls_hakgi
	
dw_main.SetColumn('d_janghak_wibu_year')
dw_main.setfocus()
end event

event ue_delete;call super::ue_delete;int li_ans

//삭제확인
if uf_messagebox(4) = 2 then return

dw_main.deleterow(0)
li_ans = dw_main.update()								

if li_ans = -1 then
	//저장 오류 메세지 출력
	uf_messagebox(6)
	rollback USING SQLCA;
else	
	commit USING SQLCA;
	//저장확인 메세지 출력
	uf_messagebox(5)
end if
end event

event open;call super::open;string	ls_hakgi, ls_year

idw_update[1] = dw_main

dw_con.SetTransObject(sqlca)
dw_con.InsertRow(0)

SELECT	YEAR,      HAKGI
INTO		:ls_year, :ls_hakgi  
FROM		HAKSA.D_HAKSA_ILJUNG  
WHERE	SIJUM_FLAG = '1'
USING SQLCA ;

dw_con.Object.year[1]	= ls_year
dw_con.Object.hakgi[1]	= ls_hakgi 
end event

type ln_templeft from w_condition_window`ln_templeft within w_dhwdr103a
end type

type ln_tempright from w_condition_window`ln_tempright within w_dhwdr103a
end type

type ln_temptop from w_condition_window`ln_temptop within w_dhwdr103a
end type

type ln_tempbuttom from w_condition_window`ln_tempbuttom within w_dhwdr103a
end type

type ln_tempbutton from w_condition_window`ln_tempbutton within w_dhwdr103a
end type

type ln_tempstart from w_condition_window`ln_tempstart within w_dhwdr103a
end type

type uc_retrieve from w_condition_window`uc_retrieve within w_dhwdr103a
end type

type uc_insert from w_condition_window`uc_insert within w_dhwdr103a
end type

type uc_delete from w_condition_window`uc_delete within w_dhwdr103a
end type

type uc_save from w_condition_window`uc_save within w_dhwdr103a
end type

type uc_excel from w_condition_window`uc_excel within w_dhwdr103a
end type

type uc_print from w_condition_window`uc_print within w_dhwdr103a
end type

type st_line1 from w_condition_window`st_line1 within w_dhwdr103a
end type

type st_line2 from w_condition_window`st_line2 within w_dhwdr103a
end type

type st_line3 from w_condition_window`st_line3 within w_dhwdr103a
end type

type uc_excelroad from w_condition_window`uc_excelroad within w_dhwdr103a
end type

type ln_dwcon from w_condition_window`ln_dwcon within w_dhwdr103a
end type

type gb_1 from w_condition_window`gb_1 within w_dhwdr103a
end type

type gb_2 from w_condition_window`gb_2 within w_dhwdr103a
end type

type dw_main from uo_input_dwc within w_dhwdr103a
integer x = 50
integer y = 300
integer width = 4379
integer height = 1960
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dhwdr103a"
end type

event itemchanged;call super::itemchanged;string ls_gwajung, ls_jungong, ls_hakgwa, ls_hname
string ls_gwamok
int i, li_null

setnull(li_null)

this.AcceptText()

CHOOSE CASE	DWO.NAME
	//학번이 입력되면 기본사항을 가져온다.
	CASE	'd_janghak_wibu_hakbun'
		
		SELECT	GWAJUNG_ID,
					GWA_ID,
					JUNGONG_ID,
					HNAME
		INTO	:ls_gwajung,
				:ls_hakgwa,
				:ls_jungong,
				:ls_hname
		FROM	HAKSA.D_HAKJUK
		WHERE	HAKBUN	=	:data	
		USING SQLCA ;
		
		if sqlca.sqlcode <> 0 then
			messagebox("오류","잘못된 학번입니다.")
			this.object.d_jonghap_hakbun[row]	=	''
			return 1
			
		else
			this.object.d_hakjuk_hname[row]			=	ls_hname
			this.object.d_hakjuk_gwajung_id[row]	=	ls_gwajung
			this.object.d_hakjuk_gwa_id[row]			=	ls_hakgwa
			this.object.d_hakjuk_jungong_id[row]	=	ls_jungong
			
		end if
		
			
END CHOOSE
		
end event

event itemerror;call super::itemerror;return 2
end event

type dw_con from uo_dwfree within w_dhwdr103a
integer x = 55
integer y = 168
integer width = 4379
integer height = 116
integer taborder = 130
boolean bringtotop = true
string dataobject = "d_dhwdr103a_c1"
boolean border = false
borderstyle borderstyle = stylebox!
end type


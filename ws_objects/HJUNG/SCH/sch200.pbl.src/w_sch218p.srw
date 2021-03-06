﻿$PBExportHeader$w_sch218p.srw
$PBExportComments$[w_print] 수납집계표
forward
global type w_sch218p from w_window
end type
type dw_con from uo_dwfree within w_sch218p
end type
type dw_main from datawindow within w_sch218p
end type
end forward

global type w_sch218p from w_window
dw_con dw_con
dw_main dw_main
end type
global w_sch218p w_sch218p

event ue_postopen;call super::ue_postopen;func.of_design_con( dw_con )
This.Event ue_resize_dw( st_line1, dw_main )

dw_con.settransobject(sqlca)
dw_con.insertrow(0)


Vector lvc_data
lvc_data = Create Vector
lvc_data.setProperty('column1', 'house_gb')  //기숙사구분
lvc_data.setProperty('key1', 'SAZ01')
lvc_data.setProperty('column2', 'door_gb')  //인실구분
lvc_data.setProperty('key2', 'SAZ36')
func.of_dddw( dw_con,lvc_data)

dw_con.object.fr_dt[1] = func.of_get_sdate('YYYYMM') + '01'
dw_con.object.to_dt[1] = func.of_get_sdate('YYYYMMDD') 

dw_main.Modify("DataWindow.Print.Preview=Yes")

ib_retrieve_wait = True

idw_print = dw_main
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
	f_set_message("[조회] " + String(ll_rv) + '건의 자료가 조회되었습니다.', '', parentwin)
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

on w_sch218p.create
int iCurrent
call super::create
this.dw_con=create dw_con
this.dw_main=create dw_main
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con
this.Control[iCurrent+2]=this.dw_main
end on

on w_sch218p.destroy
call super::destroy
destroy(this.dw_con)
destroy(this.dw_main)
end on

event ue_printstart;call super::ue_printstart;// 출력물 설정
avc_data.SetProperty('title', "수납집계표")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
//
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_window`ln_templeft within w_sch218p
end type

type ln_tempright from w_window`ln_tempright within w_sch218p
end type

type ln_temptop from w_window`ln_temptop within w_sch218p
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_sch218p
end type

type ln_tempbutton from w_window`ln_tempbutton within w_sch218p
end type

type ln_tempstart from w_window`ln_tempstart within w_sch218p
end type

type uc_retrieve from w_window`uc_retrieve within w_sch218p
end type

type uc_insert from w_window`uc_insert within w_sch218p
end type

type uc_delete from w_window`uc_delete within w_sch218p
end type

type uc_save from w_window`uc_save within w_sch218p
end type

type uc_excel from w_window`uc_excel within w_sch218p
end type

type uc_print from w_window`uc_print within w_sch218p
end type

type st_line1 from w_window`st_line1 within w_sch218p
end type

type st_line2 from w_window`st_line2 within w_sch218p
end type

type st_line3 from w_window`st_line3 within w_sch218p
end type

type uc_excelroad from w_window`uc_excelroad within w_sch218p
end type

type dw_con from uo_dwfree within w_sch218p
integer x = 50
integer y = 176
integer width = 4379
integer height = 176
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sch218p_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;If dwo.name = 'p_search' Then
	
s_insa_com	lstr_com
String		ls_KName, ls_hakbun
This.accepttext()
ls_KName =  trim(this.object.kname[1])



OpenWithParm(w_hsg_hakjuk,ls_kname)


lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
	dw_con.SetFocus()
	dw_con.setcolumn('kname')
	RETURN
END IF

ls_kname               = lstr_com.ls_item[2]	//성명
ls_hakbun            = lstr_com.ls_item[1]	//학번
this.object.kname[1]        = ls_kname					//성명
This.object.hakbun[1]     = ls_hakbun				//개인번호
Parent.post event ue_inquiry()	
return 1
End If
end event

event itemchanged;call super::itemchanged;String		ls_hakbun, ls_kname

This.accepttext()
Choose Case	dwo.name
	Case	'hakbun','kname'
		If dwo.name = 'hakbun' Then	ls_hakbun = data
		If dwo.name = 'kname' Then	ls_kname = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'hakbun'	, '')
			This.Post SetItem(row, 'kname'	, '')			
			RETURN
		End If
		
		SELECT HAKBUN, HNAME
		INTO :ls_hakbun , :ls_kname
		FROM  (	SELECT	A.HAKBUN			HAKBUN,
							A.HNAME			HNAME
				FROM		HAKSA.JAEHAK_HAKJUK A
				UNION ALL
				SELECT	A.HAKBUN			HAKBUN,
							A.HNAME			HNAME
				FROM		HAKSA.JOLUP_HAKJUK A
				UNION ALL
				SELECT	A.HAKBUN			HAKBUN,
							A.HNAME			HNAME
				FROM		HAKSA.D_HAKJUK	A	)	A
		WHERE  HAKBUN LIKE :ls_hakbun || '%'
		AND HNAME LIKE :ls_kname || '%'
		USING SQLCA;
		
		If SQLCA.SQLCODE = 0 AND SQLCA.SQLNROWS = 1 Then
			This.object.hakbun[row] = ls_hakbun
			This.object.kname[row] = ls_kname
			Parent.post event ue_inquiry()	
			
		Else
			This.Trigger Event clicked(-1, 0, row, This.object.p_search)
			return 1
			
		End If	
End Choose


end event

type dw_main from datawindow within w_sch218p
event type long ue_retrieve ( )
integer x = 50
integer y = 368
integer width = 4379
integer height = 1884
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_sch218p_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event type long ue_retrieve();Long		ll_rv
string     ls_house_gb, ls_door_gb, ls_fr_dt, ls_to_dt, ls_gwa, ls_hakyun, ls_gb

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_house_gb = dw_con.object.house_gb[dw_con.GetRow()]
ls_door_gb = func.of_nvl(dw_con.object.door_gb[dw_con.GetRow()], '%')
ls_fr_dt = dw_con.object.fr_dt[dw_con.getrow()]
ls_to_dt = dw_con.object.to_dt[dw_con.getrow()]
ls_gwa = func.of_nvl(dw_con.object.gwa[dw_con.getrow()], '%') + '%'
ls_hakyun = func.of_nvl(dw_con.object.hakyun[dw_con.getrow()] , '%')
ls_gb = dw_con.object.gubun[dw_con.getrow()]


IF isnull(ls_house_gb) OR ls_house_gb = '' THEN
	messagebox("조회", ' 기숙사구분을 선택한 후 조회하시기 바랍니다.')
	return -1
END IF

If isnull(ls_fr_dt) or ls_fr_dt = '' then
	Messagebox("알림", "조회기간(fr)을 확인하세요!")
	RETURN -1
End If
If isnull(ls_to_dt) or ls_to_dt = '' then
	Messagebox("알림", "조회기간(to)을 확인하세요!")
	RETURN -1
End If

If ls_fr_dt > ls_to_dt Then
	Messagebox("알림", "조회기간 시작일자가 종료일자보다 클 수 없습니다!")
	RETURN -1
End If






ll_rv = THIS.Retrieve(ls_house_gb, ls_door_gb, ls_fr_dt, ls_to_dt, ls_gwa, ls_hakyun, ls_gb)


RETURN ll_rv

end event

event constructor;this.SetTransObject(Sqlca)
end event


﻿$PBExportHeader$w_hyd203a.srw
$PBExportComments$[w_list_master] 지식재산권내역등록
forward
global type w_hyd203a from w_window
end type
type dw_list from uo_grid within w_hyd203a
end type
type dw_con from uo_dw within w_hyd203a
end type
type dw_main from uo_dw within w_hyd203a
end type
type p_1 from picture within w_hyd203a
end type
type st_main from statictext within w_hyd203a
end type
type p_2 from picture within w_hyd203a
end type
type st_detail from statictext within w_hyd203a
end type
type uo_app from uo_imgbtn within w_hyd203a
end type
end forward

global type w_hyd203a from w_window
event type long ue_row_updatequery ( )
dw_list dw_list
dw_con dw_con
dw_main dw_main
p_1 p_1
st_main st_main
p_2 p_2
st_detail st_detail
uo_app uo_app
end type
global w_hyd203a w_hyd203a

type variables
Long		il_rv
Long		il_ret
Boolean	ib_list_chk	=	FALSE

end variables

forward prototypes
public function integer wf_validall ()
end prototypes

event type long ue_row_updatequery();Long				ll_rv
Long				ll_cnt = 0
Long				ll_i
DataWindow	ldw_modified[]
Long				ll_dw_cnt

If Not uc_save.Enabled Then RETURN 1

If UpperBound(idw_modified) = 0 Then
	ldw_modified = idw_update
Else
	ldw_modified = idw_modified
End If

ll_dw_cnt = UpperBound(ldw_modified)

For ll_i = 1 To ll_dw_cnt
	If ib_list_chk	=	FALSE and ldw_modified[ll_i] = dw_list Then Continue
	ldw_modified[ll_i].AcceptText()
//	ll_cnt += ldw_modified[ll_i].uf_ModifiedCount()
	ll_cnt += (ldw_modified[ll_i].ModifiedCount() + ldw_modified[ll_i].DeletedCount())
Next

If ll_cnt > 0 Then
	ll_rv = gf_message(parentwin, 2, '0007', '', '')
	Choose Case ll_rv
		Case 1
			If This.Event ue_save() = 1 Then 
				RETURN 1
			Else
				RETURN -1
			End IF
		Case 2
			If ib_updatequery_resetupdate Then
				ll_cnt = UpperBound(idw_update)
				For ll_i =  1 TO ll_cnt
					If ib_list_chk	=	FALSE and idw_update[ll_i] = dw_list Then Continue
					idw_update[ll_i].resetUpdate()
				Next
				ll_cnt = UpperBound(idw_modified)
				For ll_i =  1 TO ll_cnt
					If ib_list_chk	=	FALSE and idw_modified[ll_i] = dw_list Then Continue
					idw_modified[ll_i].resetUpdate()
				Next
			End If
			RETURN 2			
		Case 3
			RETURN 3
	End Choose 	
Else
	RETURN 1
End If

RETURN 1

end event

public function integer wf_validall ();//Integer	li_rtn, i
//
//For I = 1 To UpperBound(idw_update)
//	If func.of_checknull(idw_update[i]) = -1 Then
//		Return -1
//	End If
//Next
//

return 1
end function

on w_hyd203a.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.dw_con=create dw_con
this.dw_main=create dw_main
this.p_1=create p_1
this.st_main=create st_main
this.p_2=create p_2
this.st_detail=create st_detail
this.uo_app=create uo_app
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.dw_main
this.Control[iCurrent+4]=this.p_1
this.Control[iCurrent+5]=this.st_main
this.Control[iCurrent+6]=this.p_2
this.Control[iCurrent+7]=this.st_detail
this.Control[iCurrent+8]=this.uo_app
end on

on w_hyd203a.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.dw_con)
destroy(this.dw_main)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.p_2)
destroy(this.st_detail)
destroy(this.uo_app)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
func.of_design_dw( dw_main )
This.Event ue_resize_dw( st_line1, dw_list )
dw_con.settransobject(sqlca)
dw_con.insertrow(0)
dw_main.insertrow(0)

dw_con.object.std_ym[dw_con.getrow()] = func.of_get_sdate('yyyy') + '01'
dw_con.object.std_ym_to[dw_con.getrow()] = func.of_get_sdate('yyyymm')
idw_update[1]	= dw_main

idw_print = dw_list


Vector lvc_data
lvc_data = Create Vector

lvc_data.setProperty('column1', 'itl_ppr_rgt_dvs_cd')  //지식재산권구분코드
lvc_data.setProperty('key1', 'HYD1080')
lvc_data.setProperty('column2', 'acqs_ntn_dvs_cd')  //취득국가구분코드
lvc_data.setProperty('key2', 'HYD1140')
lvc_data.setProperty('column3', 'acqs_dvs_cd')  //취득구분코드
lvc_data.setProperty('key3', 'HYD1090')
lvc_data.setProperty('column4', 'acqs_dtl_dvs_cd')  //취득상세구분코드
lvc_data.setProperty('key4', 'HYD1430')
lvc_data.setProperty('column5', 'pat_cls_cd')  //기술분류코드
lvc_data.setProperty('key5', 'HYD1710')
lvc_data.setProperty('column6', 'appl_reg_ntn_cd')  //출원등록국가코드
lvc_data.setProperty('key6', 'HYD2000')

func.of_dddw( dw_main,lvc_data)


//만일 update dw와 변경 여부 check하는 dw가 다른 경우에는
//idw_modified[1]	= dw_save

//Excel 저장할 DataWindow가 있으면 지정
//idw_Toexcel[1]	= dw_list
//idw_Toexcel[2]	= dw_main

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

event ue_delete;call super::ue_delete;Long		ll_rv
String		ls_txt
Long		ll_row

ll_rv = dw_main.Event ue_DeleteRow()

ls_txt = "[삭제] "
If ll_rv = 1 Then
	If Trigger Event ue_save() <> 1 Then
		f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
	Else
		ll_row = dw_list.GetRow()
		If ll_row > 0 Then
			dw_list.DeleteRow(ll_row)
		End If
		f_set_message(ls_txt + '정상적으로 삭제되었습니다.', '', parentwin)
	End If
ElseIf ll_rv = 0 Then
	
Else
	f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
End If

end event

event ue_inquiry;call super::ue_inquiry;Long		ll_rv

ll_rv = This.Event ue_updatequery() 
If ll_rv <> 1 And ll_rv <> 2 Then RETURN -1

SetPointer(HourGlass!)
If ib_retrieve_wait Then
	gf_openwait()
End If
ll_rv = dw_list.Event ue_Retrieve()
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

event ue_save;call super::ue_save;If Ancestorreturnvalue = 1 Then this.event ue_inquiry()

return Ancestorreturnvalue
end event

event ue_printstart;call super::ue_printstart;//// 출력물 설정

if idw_print.rowcount()=0 then return -1

avc_data.SetProperty('title', "출력물 Title")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)
////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1
end event

type ln_templeft from w_window`ln_templeft within w_hyd203a
end type

type ln_tempright from w_window`ln_tempright within w_hyd203a
end type

type ln_temptop from w_window`ln_temptop within w_hyd203a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_hyd203a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_hyd203a
end type

type ln_tempstart from w_window`ln_tempstart within w_hyd203a
end type

type uc_retrieve from w_window`uc_retrieve within w_hyd203a
end type

type uc_insert from w_window`uc_insert within w_hyd203a
end type

type uc_delete from w_window`uc_delete within w_hyd203a
end type

type uc_save from w_window`uc_save within w_hyd203a
end type

type uc_excel from w_window`uc_excel within w_hyd203a
end type

type uc_print from w_window`uc_print within w_hyd203a
end type

type st_line1 from w_window`st_line1 within w_hyd203a
end type

type st_line2 from w_window`st_line2 within w_hyd203a
end type

type st_line3 from w_window`st_line3 within w_hyd203a
end type

type uc_excelroad from w_window`uc_excelroad within w_hyd203a
end type

type dw_list from uo_grid within w_hyd203a
event type long ue_retrieve ( )
integer x = 50
integer y = 320
integer width = 4389
integer height = 1104
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hyd203a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event type long ue_retrieve();String		ls_std_ym, ls_gwa, ls_member_no, ls_appr_dvs_cd, ls_std_ym_to
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_std_ym = dw_con.object.std_ym[dw_con.GetRow()]
ls_std_ym_to = dw_con.object.std_ym_to[dw_con.GetRow()]
ls_gwa = func.of_nvl(dw_con.object.gwa[dw_con.GetRow()], '%')
ls_member_no = func.of_nvl(dw_con.object.member_no[dw_con.GetRow()], '%')
ls_appr_dvs_cd = func.of_nvl(dw_con.object.appr_dvs_cd[dw_con.Getrow()], '%')

If ls_std_ym = '' or isnull(ls_std_ym) Then
	Messagebox("알림", "기준년월(FR)을 입력하세요!")
	dw_con.setfocus()
	dw_con.setcolumn('std_ym')
	RETURN -1
End If


If ls_std_ym_to = '' or isnull(ls_std_ym_to) Then
	Messagebox("알림", "기준년월(TO)을 입력하세요!")
	dw_con.setfocus()
	dw_con.setcolumn('std_ym_to')
	RETURN -1
End If

If ls_std_ym > ls_std_ym_to Then
	Messagebox("알림", "기준년월 범위를 확인하세요!")
	dw_con.setfocus()
	dw_con.setcolumn('std_ym')
	RETURN -1
End If

//If ls_case_tp = '' or isnull(ls_case_tp) Then 
//	Messagebox("알림", "상담구분을 입력하세요!")
//	RETURN -1
//End If

ll_rv = This.Retrieve(ls_std_ym,ls_std_ym_to,  ls_gwa, ls_member_no ,ls_appr_dvs_cd )

If ll_rv = 0 Then
	
//	dw_main.Reset()
	dw_main.event ue_insertrow()

Else

	
End If

RETURN ll_rv
end event

event rowfocuschanged;call super::rowfocuschanged;Long		ll_rv

This.AcceptText()

ll_rv = Parent.Event ue_row_updatequery() 

If currentrow > 0 And (ll_rv = 1 or ll_rv = 2) Then
	If dw_list.GetItemStatus(currentrow, 0, Primary!) <> New! THEN 
		dw_main.Post Event ue_Retrieve()
	Else
		//dw_main.Post Event ue_InsertRow()
	End If
End If

il_rv = 0

end event

event rowfocuschanging;call super::rowfocuschanging;If newrow > 0 Then
	If il_rv = 0 Then
		il_ret = Parent.Event ue_row_updatequery()
		Choose Case il_ret
			Case 3, -1
				il_rv ++
				If il_rv > 1 Then
					il_rv = 0
				End If
				RETURN 1
			Case 2
				il_rv = 0
				RETURN 0
			Case Else
				il_rv = 0
				RETURN 0
		End Choose
	Else
		Choose Case il_ret
			Case 3, -1
				il_rv ++
				If il_rv > 1 Then
					il_rv = 0
				End If
				RETURN 1
			Case 2
				il_rv = 0
				RETURN 0
			Case Else
				il_rv = 0
				RETURN 0
		End Choose
	End If
Else
	il_rv = 0
	RETURN 0
End If

end event

type dw_con from uo_dw within w_hyd203a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hyd203a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;If dwo.name = 'p_search' Then
	
s_insa_com	lstr_com
String		ls_KName, ls_member_no
This.accepttext()
ls_KName =  trim(this.object.kname[1])

lstr_com.ls_item[1] = ls_KName		//성명
lstr_com.ls_item[2] = ''				//개인번호
lstr_com.ls_item[3] = '1'//교직원구분 -교원

OpenWithParm(w_hin000h,lstr_com)


lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
	dw_con.SetFocus()
	dw_con.setcolumn('kname')
	RETURN
END IF

ls_kname               = lstr_com.ls_item[01]	//성명
ls_Member_No            = lstr_com.ls_item[02]	//개인번호
this.object.kname[1]        = ls_kname					//성명
This.object.member_no[1]     = ls_Member_No				//개인번호
Parent.post event ue_inquiry()	
return 1
End If
end event

event itemchanged;call super::itemchanged;String		ls_member_no	,ls_h01knm


This.accepttext()
Choose Case	dwo.name
	Case	'member_no','kname'
		If dwo.name = 'member_no' Then	ls_member_no = data
		If dwo.name = 'kname' Then	ls_h01knm = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'member_no'	, '')
			This.Post SetItem(row, 'kname'	, '')			
			RETURN
		End If
		
		SELECT MEMBER_NO, NAME
		INTO :ls_member_no , :ls_h01knm
		FROM INDB.HIN001M
		WHERE  MEMBER_NO LIKE :ls_member_no || '%'
		AND NAME LIKE :ls_h01knm || '%'
		USING SQLCA;
		
		If SQLCA.SQLCODE = 0 AND SQLCA.SQLNROWS = 1 Then
			This.object.member_no[row] = ls_member_no
			This.object.kname[row] = ls_h01knm
			Parent.post event ue_inquiry()	
			
		Else
			This.Trigger Event clicked(-1, 0, row, This.object.p_search)
			return 1
			
		End If	
		
	

End Choose

//Destroy lvc_data
//Destroy lvc_hirfunc
end event

type dw_main from uo_dw within w_hyd203a
event type long ue_retrieve ( )
integer x = 50
integer y = 1436
integer width = 4389
integer height = 828
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_hyd203a_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_row
String		ls_std_ym, ls_member_no, ls_mng_no
Long		ll_rv

ll_row = dw_list.GetRow()
If ll_row <= 0 Then RETURN -1

ls_std_ym = dw_list.object.std_ym[ll_row]
ls_member_no = dw_list.object.member_no[ll_row]
ls_mng_no = dw_list.object.mng_no[ll_row]

ll_rv = dw_main.Retrieve(ls_std_ym, ls_member_no, ls_mng_no)

RETURN ll_rv

end event

event ue_insertend;call super::ue_insertend;//String ls_std_ym
//
//dw_con.accepttext()
//
//ls_std_ym = dw_con.object.std_ym[1]
//
//If ls_std_ym = '' or isnull(ls_std_ym) then
//	Messagebox("알림", "기준년월을 확인하세요!")
//	dw_con.setfocus()
//	dw_con.setcolumn('std_ym')
//	RETURN -1
//End If
//
//This.object.std_ym[al_row] = ls_std_ym
RETURN 1
end event

event clicked;call super::clicked;If dwo.name = 'p_search' Then
	
s_insa_com	lstr_com
String		ls_KName, ls_member_no
This.accepttext()
ls_KName =  trim(this.object.kname[1])

lstr_com.ls_item[1] = ls_KName		//성명
lstr_com.ls_item[2] = ''				//개인번호
lstr_com.ls_item[3] = '1'//교직원구분 -교원

OpenWithParm(w_hin000h,lstr_com)


lstr_com = Message.PowerObjectParm
IF NOT isValid(lstr_com) THEN
	dw_con.SetFocus()
	dw_con.setcolumn('kname')
	RETURN
END IF

ls_kname               = lstr_com.ls_item[01]	//성명
ls_Member_No            = lstr_com.ls_item[02]	//개인번호
this.object.kname[1]        = ls_kname					//성명
This.object.member_no[1]     = ls_Member_No				//개인번호

End If
end event

event itemchanged;call super::itemchanged;
String		ls_h01nno	,ls_h01knm


This.accepttext()
Choose Case	dwo.name
	Case	'member_no','kname'
		If dwo.name = 'member_no' Then	ls_h01nno = data
		If dwo.name = 'kname' Then	ls_h01knm = data
		
		If func.of_nvl(data,'') = '' Then
			This.Post SetItem(row, 'member_no'	, '')
			This.Post SetItem(row, 'kname'	, '')			
			RETURN
		End If
		
		SELECT MEMBER_NO, NAME
		INTO :ls_h01nno , :ls_h01knm
		FROM INDB.HIN001M
		WHERE  MEMBER_NO LIKE :ls_h01nno || '%'
		AND NAME LIKE :ls_h01knm || '%'
		USING SQLCA;
		
		If SQLCA.SQLCODE = 0 AND SQLCA.SQLNROWS = 1 Then
			This.object.member_no[row] = ls_h01nno
			This.object.kname[row] = ls_h01knm
			Parent.post event ue_inquiry()	
			
		Else
			This.Trigger Event clicked(-1, 0, row, This.object.p_search)
			return 1
			
		End If	
		
	

End Choose

//Destroy lvc_data
//Destroy lvc_hirfunc
end event

type p_1 from picture within w_hyd203a
boolean visible = false
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean enabled = false
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_hyd203a
boolean visible = false
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
boolean enabled = false
string text = "main desc"
boolean focusrectangle = false
end type

type p_2 from picture within w_hyd203a
boolean visible = false
integer x = 50
integer y = 1144
integer width = 46
integer height = 40
boolean bringtotop = true
boolean enabled = false
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_detail from statictext within w_hyd203a
boolean visible = false
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
boolean enabled = false
string text = "detail desc"
boolean focusrectangle = false
end type

type uo_app from uo_imgbtn within w_hyd203a
integer x = 50
integer y = 36
integer taborder = 30
boolean bringtotop = true
string btnname = "특허경비신청"
end type

event clicked;call super::clicked;Vector	lvc_data
String ls_std_ym, ls_member_no, ls_mng_no

lvc_data = Create Vector

dw_list.accepttext()
If dw_list.rowcount() = 0 Then RETURN 

ls_std_ym = dw_list.object.std_ym[dw_list.getrow()]
ls_member_no = dw_list.object.member_no[dw_list.getrow()]
ls_mng_no = dw_list.object.mng_no[dw_list.getrow()]

lvc_data.setproperty("std_ym", ls_std_ym)
lvc_data.setproperty("member_no", ls_member_no)
lvc_data.setproperty("mng_no", ls_mng_no)
lvc_data.setproperty("support_gb", '5')

OpenWithParm(w_hyd200_pop,lvc_data)

return 


end event

on uo_app.destroy
call uo_imgbtn::destroy
end on


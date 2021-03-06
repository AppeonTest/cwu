﻿$PBExportHeader$w_sch307a.srw
$PBExportComments$프로그램신청등록
forward
global type w_sch307a from w_window
end type
type dw_list from uo_grid within w_sch307a
end type
type dw_con from uo_dw within w_sch307a
end type
type dw_main from uo_dw within w_sch307a
end type
type uc_row_insert from u_picture within w_sch307a
end type
type uc_row_delete from u_picture within w_sch307a
end type
type dw_sub from uo_grid within w_sch307a
end type
type st_main from statictext within w_sch307a
end type
type st_detail from statictext within w_sch307a
end type
type p_2 from picture within w_sch307a
end type
type p_1 from picture within w_sch307a
end type
type p_3 from picture within w_sch307a
end type
type st_sub from statictext within w_sch307a
end type
end forward

global type w_sch307a from w_window
event type long ue_row_updatequery ( )
dw_list dw_list
dw_con dw_con
dw_main dw_main
uc_row_insert uc_row_insert
uc_row_delete uc_row_delete
dw_sub dw_sub
st_main st_main
st_detail st_detail
p_2 p_2
p_1 p_1
p_3 p_3
st_sub st_sub
end type
global w_sch307a w_sch307a

type variables
Long		il_rv
Long		il_ret
Boolean	ib_list_chk	=	FALSE
String		is_data[]

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

public function integer wf_validall ();String		ls_req_dt
Integer	li_req_no, li_rtn, i

For I = 1 To UpperBound(idw_update)
	If func.of_checknull(idw_update[i]) = -1 Then
		Return -1
	End If
Next

// 신청순번을 최종번호 확인하여 Setting 한다.
ls_req_dt = dw_main.Object.req_dt[dw_main.GetRow()]

SELECT 	NVL(MAX(REQ_NO), 0) + 1
INTO		:li_req_no
FROM		SCH.SAZ350T
WHERE	HOUSE_GB	= :is_data[1]
AND		REQ_DT		= :ls_req_dt
USING SQLCA ;

If isNull(li_req_no) Then li_req_no = 1

dw_main.Object.req_no[dw_main.GetRow()] = li_req_no

// 해당 신청순번에 대한 기본값을 프로그램정보에 임의 Setup 한다.
For I = 1 To dw_sub.RowCount()
	dw_sub.Object.house_gb[i] = is_data[1]
	dw_sub.Object.req_dt[i] = ls_req_dt
	dw_sub.Object.req_no[i] = li_req_no
Next
end function

on w_sch307a.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.dw_con=create dw_con
this.dw_main=create dw_main
this.uc_row_insert=create uc_row_insert
this.uc_row_delete=create uc_row_delete
this.dw_sub=create dw_sub
this.st_main=create st_main
this.st_detail=create st_detail
this.p_2=create p_2
this.p_1=create p_1
this.p_3=create p_3
this.st_sub=create st_sub
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.dw_main
this.Control[iCurrent+4]=this.uc_row_insert
this.Control[iCurrent+5]=this.uc_row_delete
this.Control[iCurrent+6]=this.dw_sub
this.Control[iCurrent+7]=this.st_main
this.Control[iCurrent+8]=this.st_detail
this.Control[iCurrent+9]=this.p_2
this.Control[iCurrent+10]=this.p_1
this.Control[iCurrent+11]=this.p_3
this.Control[iCurrent+12]=this.st_sub
end on

on w_sch307a.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.dw_con)
destroy(this.dw_main)
destroy(this.uc_row_insert)
destroy(this.uc_row_delete)
destroy(this.dw_sub)
destroy(this.st_main)
destroy(this.st_detail)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.p_3)
destroy(this.st_sub)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
func.of_design_dw( dw_main )
This.Event ue_resize_dw( st_line1, dw_list )
This.Event ue_resize_dw( st_line2, dw_sub )

dw_con.insertrow(0)
dw_main.insertrow(0)

idw_update[1]	= dw_main
idw_update[2]	= dw_sub
//만일 update dw와 변경 여부 check하는 dw가 다른 경우에는
//idw_modified[1]	= dw_save

//Excel 저장할 DataWindow가 있으면 지정
//idw_Toexcel[1]	= dw_list
//idw_Toexcel[2]	= dw_main
//idw_Toexcel[3]	= dw_sub

// 사용자에 대한 정보를 확인
uo_hjfunc 	hjfunc
Vector		lvc_data
Integer		li_rtn, i

hjfunc		= Create uo_hjfunc
lvc_data = Create Vector

// 초기값 Setup
dw_con.Object.from_date[dw_con.GetRow()] 	= func.of_get_sdate('yyyy') + '0101'
dw_con.Object.to_date[dw_con.GetRow()] 	= func.of_get_sdate('yyyymmdd')

li_rtn = hjfunc.of_search_house(lvc_data)
If li_rtn = 1 Then
	is_data[1]	= lvc_data.GetProperty('house_gb')
	is_data[2]	= lvc_data.GetProperty('std_year')
	is_data[3]	= lvc_data.GetProperty('allcate_no')
	is_data[4]	= lvc_data.GetProperty('recruit_no')
	is_data[5]	= lvc_data.GetProperty('house_req_no')
	is_data[6]	= lvc_data.GetProperty('house_cd')
	is_data[7]	= lvc_data.GetProperty('room_cd')
	is_data[8]	= lvc_data.GetProperty('door_gb')
	is_data[9]	= lvc_data.GetProperty('door_no')
Else
	For i = 1 To 9
		is_data[1]	= ''
	Next
//	uc_insert.of_enable(False)
//	uc_delete.of_enable(False)
//	uc_save.of_enable(False)
	f_set_message("[확인] " + '프로그램신청을 할 수 있는 사생이 아닙니다. 기존자료가 존재한다면 조회만 가능합니다', '', parentwin)	
End If

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

event ue_delete;call super::ue_delete;Long		ll_row
String		ls_txt

ls_txt = "[삭제] "
If dw_main.RowCount() > 0 Then
	If NOT dw_main.ib_multi_row Then
		If dw_main.Event ue_DeleteRow() > 0 Then
			dw_sub.uf_DeleteAll()
			If Trigger Event ue_save() <> 1 Then
				f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
			Else
				ll_row = dw_list.GetRow()
				If ll_row > 0 Then
					dw_list.DeleteRow(ll_row)
				End If
				f_set_message(ls_txt + '정상적으로 삭제되었습니다.', '', parentwin)
			End If
		Else
			f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
		End If
	Else
		ll_row = dw_main.GetRow()
		If ll_row > 0 Then
			dw_main.SetRow(ll_row)
			If dw_main.Event ue_DeleteRow() > 0 Then
				dw_sub.uf_DeleteAll()
				If Trigger Event ue_save() <> 1 Then
					f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
				Else
					ll_row = dw_list.GetRow()
					If ll_row > 0 Then
						dw_list.DeleteRow(ll_row)
					End If
					f_set_message(ls_txt + '정상적으로 삭제되었습니다.', '', parentwin)
				End If
			Else
				f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
			End If
		Else
			
		End If
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

type ln_templeft from w_window`ln_templeft within w_sch307a
end type

type ln_tempright from w_window`ln_tempright within w_sch307a
end type

type ln_temptop from w_window`ln_temptop within w_sch307a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_sch307a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_sch307a
end type

type ln_tempstart from w_window`ln_tempstart within w_sch307a
end type

type uc_retrieve from w_window`uc_retrieve within w_sch307a
end type

type uc_insert from w_window`uc_insert within w_sch307a
end type

type uc_delete from w_window`uc_delete within w_sch307a
end type

type uc_save from w_window`uc_save within w_sch307a
end type

type uc_excel from w_window`uc_excel within w_sch307a
end type

type uc_print from w_window`uc_print within w_sch307a
end type

type st_line1 from w_window`st_line1 within w_sch307a
end type

type st_line2 from w_window`st_line2 within w_sch307a
end type

type st_line3 from w_window`st_line3 within w_sch307a
end type

type uc_excelroad from w_window`uc_excelroad within w_sch307a
end type

type dw_list from uo_grid within w_sch307a
event type long ue_retrieve ( )
integer x = 50
integer y = 416
integer width = 3104
integer height = 1844
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sch307a_2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event type long ue_retrieve();String		ls_fr, ls_to
Long		ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_fr = dw_con.Object.from_date[dw_con.GetRow()]
ls_to = dw_con.Object.to_date[dw_con.GetRow()]

This.Reset()
dw_main.Reset()
dw_sub.Reset()
ll_rv = This.Retrieve(ls_fr, ls_to, gs_empcode)

If ll_rv <= 0 Then
	dw_main.InsertRow(0)
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

event ue_deleteend;call super::ue_deleteend;If dw_sub.uf_DeleteAll() >= 0 Then
	RETURN 1
Else
	RETURN -1
End If

end event

type dw_con from uo_dw within w_sch307a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sch301a_1"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_dw within w_sch307a
event type long ue_retrieve ( )
integer x = 3209
integer y = 416
integer width = 1216
integer height = 836
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sch307a_3"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_row, ll_rv
String		ls_house_gb, ls_req_dt
Integer	li_req_no

ll_row = dw_list.GetRow()
If ll_row <= 0 Then 
	dw_main.InsertRow(0)
	RETURN -1
End If

ls_house_gb = dw_list.Object.house_gb[ll_row]
ls_req_dt = dw_list.Object.req_dt[ll_row]
li_req_no = dw_list.Object.req_no[ll_row]

ll_rv = dw_main.Retrieve(ls_house_gb, ls_req_dt, li_req_no)
If ll_rv > 0 Then
	dw_sub.Retrieve(ls_house_gb, ls_req_dt, li_req_no)
End If

RETURN ll_rv

end event

event ue_insertend;call super::ue_insertend;String		ls_code, ls_fname
Integer	I, li_cnt

// 기본적으로 Setup 되어야 하는 정보를 Setting
This.Object.house_gb[al_row] = is_data[1]
This.Object.req_dt[al_row] = is_data[1]
This.Object.hakbun[al_row] = is_data[1]
This.Object.hname[al_row] = is_data[1]
This.Object.contact_no[al_row] = is_data[1]
This.Object.cel_no[al_row] = is_data[1]
This.Object.email[al_row] = is_data[1]

// 프로그램에 대한 기본사항을 확인하여 임의적으로 Setting
SELECT	Count(*)
INTO		:li_cnt
FROM		CDDB.KCH102D
WHERE	CODE_GB = 'SAZ30'
AND		USE_YN = 'Y'
USING SQLCA ;

DECLARE cur_1 CURSOR FOR
	SELECT	CODE, FNAME
	FROM		CDDB.KCH102D
	WHERE	CODE_GB = 'SAZ30'
	AND		USE_YN = 'Y'
	USING SQLCA ;

OPEN cur_1 ;

FETCH cur_1 INTO :ls_code, :ls_fname ;

DO WHILE I < li_cnt
	I++
	dw_sub.InsertRow(i)
	dw_sub.Object.program_gb[i] = ls_code
	dw_sub.Object.program_nm[i] = ls_fname
	
	FETCH cur_1 INTO :ls_code, :ls_fname ;
LOOP

CLOSE cur_1 ;

Return 1

end event

type uc_row_insert from u_picture within w_sch307a
integer x = 3890
integer y = 1284
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_input.gif"
end type

event clicked;call super::clicked;If dw_main.RowCount() > 0 Then
	dw_sub.PostEvent("ue_InsertRow")
End If

end event

type uc_row_delete from u_picture within w_sch307a
integer x = 4169
integer y = 1284
integer width = 265
integer height = 84
boolean bringtotop = true
boolean originalsize = false
string picturename = "..\img\button\topBtn_delete.gif"
end type

event clicked;call super::clicked;dw_sub.PostEvent("ue_DeleteRow")

end event

type dw_sub from uo_grid within w_sch307a
event type long ue_retrieve ( )
integer x = 3209
integer y = 1404
integer width = 1216
integer height = 860
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_sch307a_4"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type st_main from statictext within w_sch307a
integer x = 114
integer y = 324
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
string text = "프로그램신청내역"
boolean focusrectangle = false
end type

type st_detail from statictext within w_sch307a
integer x = 3264
integer y = 324
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
string text = "신청기본정보"
boolean focusrectangle = false
end type

type p_2 from picture within w_sch307a
integer x = 3209
integer y = 340
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_1 from picture within w_sch307a
integer x = 50
integer y = 340
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type p_3 from picture within w_sch307a
integer x = 3209
integer y = 1324
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_sub from statictext within w_sch307a
integer x = 3264
integer y = 1312
integer width = 672
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
string text = "프로그램선택"
boolean focusrectangle = false
end type


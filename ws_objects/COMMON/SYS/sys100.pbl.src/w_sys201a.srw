﻿$PBExportHeader$w_sys201a.srw
$PBExportComments$공지사항내역조회
forward
global type w_sys201a from w_window
end type
type dw_list from uo_grid within w_sys201a
end type
type dw_con from uo_dw within w_sys201a
end type
type dw_main from uo_dw within w_sys201a
end type
type p_1 from picture within w_sys201a
end type
type st_main from statictext within w_sys201a
end type
type p_2 from picture within w_sys201a
end type
type st_detail from statictext within w_sys201a
end type
end forward

global type w_sys201a from w_window
event type long ue_row_updatequery ( )
dw_list dw_list
dw_con dw_con
dw_main dw_main
p_1 p_1
st_main st_main
p_2 p_2
st_detail st_detail
end type
global w_sys201a w_sys201a

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

public function integer wf_validall ();Integer	li_rtn, i

For I = 1 To UpperBound(idw_update)
	If func.of_checknull(idw_update[i]) = -1 Then
		Return -1
	End If
Next

end function

on w_sys201a.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.dw_con=create dw_con
this.dw_main=create dw_main
this.p_1=create p_1
this.st_main=create st_main
this.p_2=create p_2
this.st_detail=create st_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.dw_con
this.Control[iCurrent+3]=this.dw_main
this.Control[iCurrent+4]=this.p_1
this.Control[iCurrent+5]=this.st_main
this.Control[iCurrent+6]=this.p_2
this.Control[iCurrent+7]=this.st_detail
end on

on w_sys201a.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.dw_con)
destroy(this.dw_main)
destroy(this.p_1)
destroy(this.st_main)
destroy(this.p_2)
destroy(this.st_detail)
end on

event ue_postopen;call super::ue_postopen;
func.of_design_con( dw_con )
func.of_design_dw( dw_main )
This.Event ue_resize_dw( st_line1, dw_list )

dw_con.insertrow(0)

//idw_update[1]	= dw_main
//만일 update dw와 변경 여부 check하는 dw가 다른 경우에는
//idw_modified[1]	= dw_save

//Excel 저장할 DataWindow가 있으면 지정
//idw_Toexcel[1]	= dw_list
//idw_Toexcel[2]	= dw_main

Vector lvc_data

// 공통코드 Setup
lvc_data = Create Vector
lvc_data.setProperty('column1', 'board_gb')  //공지사항구분
lvc_data.setProperty('key1', 'COM04')

func.of_dddw( dw_con,lvc_data)
func.of_dddw( dw_list,lvc_data)
func.of_dddw( dw_main,lvc_data)

// 초기값 Setup
dw_con.Object.from_dt[dw_con.GetRow()] = func.of_get_sdate( 'yyyymm') + '01'
dw_con.Object.to_dt[dw_con.GetRow()] = func.of_get_sdate( 'yyyymmdd')

//wait 화면을 표시하고 싶은 처리에 한해 지정
//ib_save_wait		= TRUE		//저장 시
//ib_retrieve_wait	= TRUE		//조회 시
//ib_excel_wait		= TRUE		//엑셀 다운로드 시
//ib_excelload_wait	= TRUE		//엑셀 upload 시
//ib_spcall_wait		= TRUE		//Stored Procedure Call 시

Post Event ue_inquiry()
end event

event ue_insert;call super::ue_insert;//Long		ll_rv
//String		ls_txt
//
//ll_rv = dw_main.Event ue_InsertRow()
//
//ls_txt = "[신규] "
//If ll_rv = 1 Then
//	f_set_message(ls_txt + '신규 행이 추가 되었습니다.', '', parentwin)
//ElseIf ll_rv = 0 Then
//	
//Else
//	f_set_message(ls_txt + '오류가 발생했습니다.', '', parentwin)
//End If

Vector lvc_data
Integer	li_row

lvc_data = Create Vector

If dw_list.RowCount() < 1 Then Return

li_row = dw_list.GetRow()

lvc_data.setProperty('board_gb', dw_list.Object.board_gb[li_row])				//공지사항구분
lvc_data.setProperty('make_dt', dw_list.Object.make_dt[li_row])				//작성일자
lvc_data.setProperty('board_seq', String(dw_list.Object.board_seq[li_row]))	//공지사항SEQ
lvc_data.SetProperty("parm_cnt", "1")

OpenWithParm(w_sys202a, lvc_data)

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

type ln_templeft from w_window`ln_templeft within w_sys201a
end type

type ln_tempright from w_window`ln_tempright within w_sys201a
end type

type ln_temptop from w_window`ln_temptop within w_sys201a
end type

type ln_tempbuttom from w_window`ln_tempbuttom within w_sys201a
end type

type ln_tempbutton from w_window`ln_tempbutton within w_sys201a
end type

type ln_tempstart from w_window`ln_tempstart within w_sys201a
end type

type uc_retrieve from w_window`uc_retrieve within w_sys201a
end type

type uc_insert from w_window`uc_insert within w_sys201a
end type

type uc_delete from w_window`uc_delete within w_sys201a
end type

type uc_save from w_window`uc_save within w_sys201a
end type

type uc_excel from w_window`uc_excel within w_sys201a
end type

type uc_print from w_window`uc_print within w_sys201a
end type

type st_line1 from w_window`st_line1 within w_sys201a
end type

type st_line2 from w_window`st_line2 within w_sys201a
end type

type st_line3 from w_window`st_line3 within w_sys201a
end type

type uc_excelroad from w_window`uc_excelroad within w_sys201a
end type

type dw_list from uo_grid within w_sys201a
event type long ue_retrieve ( )
integer x = 50
integer y = 416
integer width = 4389
integer height = 1108
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sys201a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
end type

event type long ue_retrieve();String		ls_board_gb, ls_from_dt, ls_to_dt
Long			ll_rv

If dw_con.AcceptText() = -1 Then
	dw_con.SetFocus( )
	RETURN -1
End If

ls_board_gb = func.of_nvl(dw_con.object.board_gb[dw_con.GetRow()], '%')
ls_from_dt = dw_con.object.from_dt[dw_con.GetRow()]
ls_to_dt = dw_con.object.to_dt[dw_con.GetRow()]

If ls_board_gb = '' Or IsNull(ls_board_gb) Or ls_board_gb = 'null' Then ls_board_gb = '%'

dw_main.Reset()
ll_rv = This.Retrieve(ls_board_gb, ls_from_dt, ls_to_dt)

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

type dw_con from uo_dw within w_sys201a
integer x = 50
integer y = 164
integer width = 4389
integer height = 120
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sys201a_con"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type dw_main from uo_dw within w_sys201a
event type long ue_retrieve ( )
integer x = 50
integer y = 1664
integer width = 4389
integer height = 600
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sys201a_2"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event type long ue_retrieve();Long		ll_row
String		ls_board_gb, ls_make_dt
Long		ll_rv, li_board_seq

ll_row = dw_list.GetRow()
If ll_row <= 0 Then RETURN -1

ls_board_gb = dw_list.object.board_gb[ll_row]
ls_make_dt = dw_list.object.make_dt[ll_row]
li_board_seq = dw_list.Object.board_seq[ll_row]

ll_rv = dw_main.Retrieve(ls_board_gb, ls_make_dt, li_board_seq)

RETURN ll_rv

end event

type p_1 from picture within w_sys201a
integer x = 50
integer y = 328
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_main from statictext within w_sys201a
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
string text = "공지사항내역"
boolean focusrectangle = false
end type

type p_2 from picture within w_sys201a
integer x = 50
integer y = 1576
integer width = 46
integer height = 40
boolean bringtotop = true
boolean originalsize = true
string picturename = "..\img\icon\front_title_img.gif"
boolean focusrectangle = false
end type

type st_detail from statictext within w_sys201a
integer x = 114
integer y = 1564
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
string text = "상세공지"
boolean focusrectangle = false
end type


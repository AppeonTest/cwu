﻿$PBExportHeader$w_hgm503a.srw
$PBExportComments$물품입고현황
forward
global type w_hgm503a from w_msheet
end type
type dw_acct_code from datawindow within w_hgm503a
end type
type st_5 from statictext within w_hgm503a
end type
type dw_dept_code from datawindow within w_hgm503a
end type
type st_7 from statictext within w_hgm503a
end type
type tab_1 from tab within w_hgm503a
end type
type tabpage_1 from userobject within tab_1
end type
type dw_main from uo_dwgrid within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_main dw_main
end type
type tabpage_2 from userobject within tab_1
end type
type dw_print from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_print dw_print
end type
type tab_1 from tab within w_hgm503a
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type st_2 from statictext within w_hgm503a
end type
type em_to_date from editmask within w_hgm503a
end type
type em_fr_date from editmask within w_hgm503a
end type
type st_1 from statictext within w_hgm503a
end type
type uo_1 from u_tab within w_hgm503a
end type
type gb_1 from groupbox within w_hgm503a
end type
end forward

global type w_hgm503a from w_msheet
dw_acct_code dw_acct_code
st_5 st_5
dw_dept_code dw_dept_code
st_7 st_7
tab_1 tab_1
st_2 st_2
em_to_date em_to_date
em_fr_date em_fr_date
st_1 st_1
uo_1 uo_1
gb_1 gb_1
end type
global w_hgm503a w_hgm503a

on w_hgm503a.create
int iCurrent
call super::create
this.dw_acct_code=create dw_acct_code
this.st_5=create st_5
this.dw_dept_code=create dw_dept_code
this.st_7=create st_7
this.tab_1=create tab_1
this.st_2=create st_2
this.em_to_date=create em_to_date
this.em_fr_date=create em_fr_date
this.st_1=create st_1
this.uo_1=create uo_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_acct_code
this.Control[iCurrent+2]=this.st_5
this.Control[iCurrent+3]=this.dw_dept_code
this.Control[iCurrent+4]=this.st_7
this.Control[iCurrent+5]=this.tab_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.em_to_date
this.Control[iCurrent+8]=this.em_fr_date
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.uo_1
this.Control[iCurrent+11]=this.gb_1
end on

on w_hgm503a.destroy
call super::destroy
destroy(this.dw_acct_code)
destroy(this.st_5)
destroy(this.dw_dept_code)
destroy(this.st_7)
destroy(this.tab_1)
destroy(this.st_2)
destroy(this.em_to_date)
destroy(this.em_fr_date)
destroy(this.st_1)
destroy(this.uo_1)
destroy(this.gb_1)
end on

event ue_open;call super::ue_open;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_open
//	기 능 설 명: 초기화 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건의 초기화 처리.
////////////////////////////////////////////////////////////////////////////////////
tab_1.tabpage_1.dw_main.Reset()
tab_1.tabpage_2.dw_print.object.DataWindow.Zoom = 70
tab_1.tabpage_2.dw_print.Object.DataWindow.Print.Preview = 'YES'
idw_print = tab_1.tabpage_2.dw_print

String	ls_Today
ls_Today = String(Today(),'YYYYMMDD')
em_fr_date.Text = MID(ls_Today,1,6)+'01'
em_to_date.Text = ls_Today

///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 부서명
////////////////////////////////////////////////////////////////////////////////////
DataWindowChild	ldwc_Temp
dw_dept_code.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('%') = 0 THEN
	wf_setmsg('부서코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	Long	ll_InsRow
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'gwa',0)
	ldwc_Temp.SetItem(ll_InsRow,'fname','전체')
	ldwc_Temp.SetSort('gwa ASC')
	ldwc_Temp.Sort()
END IF
dw_dept_code.InsertRow(0)
///////////////////////////////////////////////////////////////////////////////////////
// 1.1 조회조건 - 계정과목
////////////////////////////////////////////////////////////////////////////////////
dw_acct_code.GetChild('code',ldwc_Temp)
ldwc_Temp.SetTransObject(SQLCA)
IF ldwc_Temp.Retrieve('%') = 0 THEN
	wf_setmsg('계정코드를 입력하시기 바랍니다.')
	ldwc_Temp.InsertRow(0)
ELSE
	ll_InsRow = ldwc_Temp.InsertRow(0)
	ldwc_Temp.SetItem(ll_InsRow,'code',0)
	ldwc_Temp.SetItem(ll_InsRow,'name','전체')
	ldwc_Temp.SetSort('code ASC')
	ldwc_Temp.Sort()
END IF
dw_acct_code.InsertRow(0)

///////////////////////////////////////////////////////////////////////////////////////
f_childretrieve(tab_1.tabpage_1.dw_main,"hst109h_item_class","item_class")         // 물품구분(조회조건)
f_childretrieve(tab_1.tabpage_1.dw_main,"revenue_opt","revenue_opt")               // 구입재원(조회조건)
f_childretrieve(tab_1.tabpage_2.dw_print,"revenue_opt","revenue_opt")               // 구입재원(조회조건) 
f_childretrieve(tab_1.tabpage_2.dw_print,"hst109h_item_class","item_class")
//////////////////////////////////////////////////////////////////////////////////////
// 2. 초기화 이벤트 호출
///////////////////////////////////////////////////////////////////////////////////////
THIS.TRIGGER EVENT ue_init()

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////

end event

event ue_init;call super::ue_init;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_init
//	기 능 설 명: 초기화 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 초기값처리
///////////////////////////////////////////////////////////////////////////////////////
tab_1.tabpage_1.dw_main.Reset()

////wf_setMenu('I',TRUE)//입력버튼 활성화
////wf_setMenu('S',TRUE)//저장버튼 활성화
////wf_setMenu('D',TRUE)//삭제버튼 활성화
//wf_setMenu('R',TRUE)//조회버튼 활성화


triggerevent('ue_retrieve')

//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////


end event

event ue_insert;call super::ue_insert;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_insert
////	기 능 설 명: 자료추가 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 입력조건체크
/////////////////////////////////////////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 자료추가
/////////////////////////////////////////////////////////////////////////////////////////
//Long	ll_GetRow, ll_RowCnt, ll_Row, ll_newRow
//long  ll_fr_date, li_idx
//ll_GetRow = tab_1.tabpage_1.dw_main.TRIGGER EVENT ue_db_new()
/////////////////////////////////////////////////////////////////////////////////////////
//// 3. 디폴티값 셋팅
/////////////////////////////////////////////////////////////////////////////////////////
//tab_1.tabpage_1.dw_main.object.hst109h_in_date[tab_1.tabpage_1.dw_main.getrow()] = f_today()
//tab_1.tabpage_1.dw_main.object.hst109h_req_no[tab_1.tabpage_1.dw_main.getrow()]  = left(f_today(),4) + '0001'
/////////////////////////////////////////////////////////////////////////////////////////
//// 4. 디폴티값을 셋팅하고 변경되지 않은 것으로 처리.
////			사용하지 안을경우는 커맨트 처리
/////////////////////////////////////////////////////////////////////////////////////////
//tab_1.tabpage_1.dw_main.SetItemStatus(ll_GetRow,0,Primary!,NotModified!)
//
/////////////////////////////////////////////////////////////////////////////////////////
//// 5. 메세지처리, 고정버튼 활성화/비활성화, 데이타원도우로 포커스이동 처리
/////////////////////////////////////////////////////////////////////////////////////////
//wf_SetMsg('자료가 추가되었습니다.')
//wf_SetMenu('I',TRUE)
//wf_SetMenu('D',TRUE)
//wf_SetMenu('S',TRUE)
////wf_SetMenu('R',TRUE)
//tab_1.tabpage_1.dw_main.Setfocus()
////tab_1.tabpage_1.dw_main.setcolumn('sorc_rvn')
//
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_save;call super::ue_save;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_save
//	기 능 설 명: 자료저장 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 1. 변경여부 CHECK
///////////////////////////////////////////////////////////////////////////////////////
IF tab_1.tabpage_1.dw_main.AcceptText() = -1 THEN
	tab_1.tabpage_1.dw_main.SetFocus()
	RETURN -1
END IF
IF tab_1.tabpage_1.dw_main.ModifiedCount() + &
	tab_1.tabpage_1.dw_main.DeletedCount() = 0 THEN 
	wf_SetMsg('자료를 수정 후 저장하시기 바랍니다')
	RETURN -1
END IF

///////////////////////////////////////////////////////////////////////////////////////
// 2. 필수입력항목 체크
///////////////////////////////////////////////////////////////////////////////////////
String	ls_NotNullCol[]

ls_NotNullCol[1] = 'hst109h_ord_no/발주번호'
ls_NotNullCol[2] = 'hst109h_IN_NO/입고번호'
ls_NotNullCol[3] = 'hst109h_ITEM_SEQ/품목번호'
ls_NotNullCol[4] = 'hst109h_REQ_NO/접수번호'
IF f_chk_null(tab_1.tabpage_1.dw_main,ls_NotNullCol) = -1 THEN RETURN -1

 String ls_ord_no, ls_cust_no, ls_apply_gwa, ls_goods_kind
 String ls_req_date, ls_item_no, ls_item_name, ls_req_no, ls_acct_code
 ls_ord_no     = tab_1.tabpage_1.dw_main.Object.hst109h_ord_no[tab_1.tabpage_1.dw_main.getrow()]
 ls_cust_no    = tab_1.tabpage_1.dw_main.Object.hst109h_cust_no[tab_1.tabpage_1.dw_main.getrow()]
 ls_apply_gwa  = tab_1.tabpage_1.dw_main.Object.apply_gwa[tab_1.tabpage_1.dw_main.getrow()]
 ls_req_date   = tab_1.tabpage_1.dw_main.Object.hst109h_req_date[tab_1.tabpage_1.dw_main.getrow()]
 ls_item_no    = tab_1.tabpage_1.dw_main.Object.item_no[tab_1.tabpage_1.dw_main.getrow()]
 ls_item_name  = tab_1.tabpage_1.dw_main.Object.item_name[tab_1.tabpage_1.dw_main.getrow()]
 ls_req_no     = tab_1.tabpage_1.dw_main.Object.hst109h_req_no[tab_1.tabpage_1.dw_main.getrow()]
 ls_acct_code  = tab_1.tabpage_1.dw_main.Object.acct_code[tab_1.tabpage_1.dw_main.getrow()]

// 발주번호 중복 체크
 Long ll_count
 select count(ord_no)
 into   :ll_count
 from   stdb.hst109h
 where  ord_no = :ls_ord_no ;
 
 IF ll_count <> 0 THEN
	 messagebox('확인','발주 번호가 중복 됩니다...!')
	 RETURN -1
 END IF
 
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//2.1필수항목 입력 체크
////////////////////////////////////////////////////////////////////////////////////////////////////////////

   string ls_icolarry[] = {'hst109h_ord_no/발주 번호','item_no/품목코드','hst109h_item_class/물품구분',&
		                     'hst109h_req_date/요구일자', 'hst109h_cust_no/거래처명','apply_gwa/신청부서 ',&
									'acct_code/계정과목'}
  IF f_chk_null( tab_1.tabpage_1.dw_main, ls_icolarry ) = 1 THEN 
		
//		messagebox('확인',ls_apply_gwa+':'+ls_req_date+':'+ls_item_no+':'+ls_item_name)
//		messagebox('확인',ls_ord_no+':'+ls_req_no+':'+ls_acct_code)
     //      신청테이블 업데이트
  INSERT INTO STDB.HST105H (apply_gwa, APPLY_DATE, ITEM_NO, ITEM_NAME, APPLY_MEMBER_NO, ACCEPT_GWA, ORD_NO, REQ_NO, ACCT_CODE, ORD_CLASS)
  VALUES (:ls_apply_gwa, :ls_req_date, :ls_item_no, :ls_item_name, '00000', '1301', :ls_ord_no, :ls_req_no, :ls_acct_code, 7 ) ;
  
  IF sqlca.sqlcode <>0 THEN
	 messagebox('확인 신청테이블 업데이트','저장에 실패 하였습니다..!')
	 RETURN -1
  END IF
	
     //      발주테이블 업데이트
  INSERT INTO STDB.HST106H (ord_no, req_no, item_seq, cust_no, ord_class)  // 발주테이블 업데이트
  VALUES (:ls_ord_no, :ls_req_no, 1, :ls_cust_no, 7)  ;

  IF sqlca.sqlcode <>0 THEN
	 messagebox('확인 발주테이블 업데이트','저장에 실패 하였습니다..!')
	 RETURN -1
  END IF
	
 ///////////////////////////////////////////////////////////////////////////////////////
 // 3. 저장처리전 체크사항 기술
 ///////////////////////////////////////////////////////////////////////////////////////
 DwItemStatus ldis_Status
 Long		ll_Row				//변경된 행
 DateTime	ldt_WorkDate		//등록일자
 String	ls_Worker			//등록자
 String	ls_IPAddr			//등록단말기
 DateTime	ldt_JOB_Date		//등록일자
 String	ls_JOB_UID		//등록자
 String	ls_JOB_ADD			//등록단말기

   ll_Row = tab_1.tabpage_1.dw_main.GetNextModified(0,primary!)
   IF ll_Row > 0 THEN
	 ldt_WorkDate  = f_sysdate()						//등록일자
	 ls_Worker     = gstru_uid_uname.uid				//등록자
	 ls_IPAddr     = gstru_uid_uname.address		//등록단말기
	 ldt_JOB_Date  =f_sysdatE()                   //등록일자
    ls_JOB_UID	  =gstru_uid_uname.uid	         //등록자
    ls_JOB_ADD	  =gstru_uid_uname.address		   //등록단말기
   END IF
   DO WHILE ll_Row > 0
	////////////////////////////////////////////////////////////////////////////////////
	// 3.1 수정항목 처리
	////////////////////////////////////////////////////////////////////////////////////
	 tab_1.tabpage_1.dw_main.Object.Worker   [ll_Row] =ls_Worker   //등록자                                                                                                                                     
	 tab_1.tabpage_1.dw_main.Object.IpAddr   [ll_Row] =ls_IpAddr   //등록단말기                                                                                                                                 
	 tab_1.tabpage_1.dw_main.Object.Work_Date[ll_Row] =ldt_WorkDate//등록일자                                                                                                                                    
	 tab_1.tabpage_1.dw_main.Object.job_uid [ll_Row]  =ls_JOB_UID	//작업자                                                                                                                                           
	 tab_1.tabpage_1.dw_main.Object.job_add [ll_Row]  =ls_JOB_ADD//작업단말기
	 tab_1.tabpage_1.dw_main.Object.job_date[ll_Row]  =ldt_JOB_Date//작업일자
	
	 ll_Row = tab_1.tabpage_1.dw_main.GetNextModified(ll_Row,primary!)
   LOOP
  ///////////////////////////////////////////////////////////////////////////////////////
  // 5. 자료저장처리
  ///////////////////////////////////////////////////////////////////////////////////////
//   IF NOT tab_1.tabpage_1.dw_main.TRIGGER EVENT ue_db_save() THEN RETURN -1
   
	   IF  tab_1.tabpage_1.dw_main.UPDATE() = 1 THEN
		COMMIT USING SQLCA;
		//RETURN 1
	ELSE
		ROLLBACK USING SQLCA;
		RETURN -1
	END IF
   

END IF
///////////////////////////////////////////////////////////////////////////////////////
//6. 자료저장후 리스트 출력
///////////////////////////////////////////////////////////////////////////////////////
triggerevent('ue_retrieve')

///////////////////////////////////////////////////////////////////////////////////////
// 7. 메세지 처리, 고정버튼 활성화/비활성화 처리
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('자료가 저장되었습니다.')
//wf_SetMenu('I',TRUE)
//wf_SetMenu('D',TRUE)
//wf_SetMenu('S',TRUE)
//wf_SetMenu('R',TRUE)
tab_1.tabpage_1.dw_main.SetFocus()
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_delete;call super::ue_delete;////////////////////////////////////////////////////////////////////////////////////////////
////	이 벤 트 명: ue_delete
////	기 능 설 명: 자료삭제 처리
////	작성/수정자: 
////	작성/수정일: 
////	주 의 사 항: 
////////////////////////////////////////////////////////////////////////////////////////////
//// 1. 삭제할 데이타원도우의 선택여부 체크.
/////////////////////////////////////////////////////////////////////////////////////////
//Long		ll_GetRow
//
//IF tab_1.tabpage_1.dw_main.ib_RowSingle THEN &
//			ll_GetRow = tab_1.tabpage_1.dw_main.GetRow()
//	IF NOT tab_1.tabpage_1.dw_main.ib_RowSingle THEN &
//			ll_GetRow = tab_1.tabpage_1.dw_main.GetSelectedRow(0)
//IF ll_GetRow = 0 THEN RETURN
//
//String ls_ord_no, ls_req_no
// ls_ord_no     = tab_1.tabpage_1.dw_main.Object.hst109h_ord_no[tab_1.tabpage_1.dw_main.getrow()]
// ls_req_no     = tab_1.tabpage_1.dw_main.Object.hst109h_req_no[tab_1.tabpage_1.dw_main.getrow()]
/////////////////////////////////////////////////////////////////////////////////////////
//// 2. 삭제메세지 처리.
////		삭제할 자료를 멀티로 선택한 경우는 메세지 처리하지 않음.
/////////////////////////////////////////////////////////////////////////////////////////
//String	ls_Msg
//Long		ll_DeleteCnt, ll_DeletRow, ll_DeletRowCnt, ll_Row
//
//ll_DeleteCnt = tab_1.tabpage_1.dw_main.TRIGGER EVENT ue_db_delete(ls_Msg)
//
//DATAWINDOW  dw_name
//dw_name = tab_1.tabpage_1.dw_main
//ll_row = dw_name.getrow()	
//	  ll_DeleteCnt = dw_name.deleterow(ll_row)
//	  ll_DeletRow = dw_name.GetRow()
//     ll_DeletRowCnt = dw_name.RowCount()
/////////////////////////////////////////////////////////////////////////////////////////
//// 3. 삭제처리.
/////////////////////////////////////////////////////////////////////////////////////////
//IF ll_DeletRowCnt = 0 THEN
//	IF f_update( dw_name,'D') = TRUE THEN wf_setmsg("삭제되었습니다")
//END IF
//
//IF f_update( dw_name,'U') = TRUE THEN wf_setmsg("삭제되었습니다")
//
////발주 테이블 자료 삭제
//DELETE FROM STDB.HST106H
//WHERE  ord_no = :ls_ord_no
//AND    req_no = :ls_req_no;
// IF sqlca.sqlcode <>0 THEN
//	 messagebox('확인','삭제에 실패 하였릅니다..!')
//	 RETURN
//  END IF
//  
// // 신청 테이블 자료 삭제
//DELETE FROM STDB.HST105H
//WHERE  ord_no = :ls_ord_no
//AND    req_no = :ls_req_no;
// IF sqlca.sqlcode <>0 THEN
//	 messagebox('확인','삭제에 실패 하였릅니다..!')
//	 RETURN
//  END IF
//  
//IF ll_DeleteCnt > 0 THEN
//	wf_SetMsg('자료가 삭제되었습니다.')
//	IF tab_1.tabpage_1.dw_main.rowcount() > 0 THEN
//		wf_SetMenu('R',FALSE)
//		wf_SetMenu('I',TRUE)
//		wf_SetMenu('D',TRUE)
//		wf_SetMenu('S',TRUE)
//	ELSE
//		wf_SetMenu('R',FALSE)
//		wf_SetMenu('I',TRUE)
//		wf_SetMenu('D',FALSE)
//		wf_SetMenu('S',TRUE)
//	END IF
//END IF
//
//
////////////////////////////////////////////////////////////////////////////////////////////
////	END OF SCRIPT
/////////////////////////////////////////////////////////////////////////////////////
end event

event ue_retrieve;call super::ue_retrieve;//////////////////////////////////////////////////////////////////////////////////////////
//	이 벤 트 명: ue_db_retrieve
//	기 능 설 명: 자료조회 처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
// 1. 조회조건 체크
/////////////////////////////////////////////////////////////////////////////////////////
String	ls_fr_Date, lsc_fr_Date
em_fr_date.GetData(ls_fr_Date)
ls_fr_Date = TRIM(ls_fr_Date)
IF isNull(ls_fr_Date) OR LEN(ls_fr_Date) = 0 THEN
	f_dis_msg(3,'신청일자를 입력하시기 바랍니다.','')
	em_fr_date.SetFocus()
	RETURN -1
END IF
lsc_fr_Date = String(ls_fr_Date,'@@@@/@@/@@')


String	ls_to_Date,lsc_to_Date
em_to_date.GetData(ls_to_Date)
ls_to_Date = TRIM(ls_to_Date)
IF isNull(ls_to_Date) OR LEN(ls_to_Date) = 0 THEN
	f_dis_msg(3,'신청일자를 입력하시기 바랍니다.','')
	em_to_date.SetFocus()
	RETURN -1
END IF
lsc_to_Date = String(ls_to_Date,'@@@@/@@/@@')
STring  ls_date
ls_date = lsc_fr_Date + " - " + lsc_to_Date

IF ls_fr_Date > ls_to_Date THEN
	f_dis_msg(3,'신청일자 입력오류입니다.','')
	em_fr_date.SetFocus()
	RETURN -1
END IF

String  ls_gwa, ls_AcctCode
ls_gwa = TRIM(dw_dept_code.Object.code[1])   //부서체크
IF isNull(ls_gwa) OR ls_gwa = '0' OR ls_gwa = '' THEN
	ls_gwa = '%'
END IF

ls_AcctCode = TRIM(dw_acct_code.Object.code[1])  //계정과목
IF isNull(ls_AcctCode) OR ls_AcctCode = '0' OR ls_AcctCode = '' THEN
	ls_AcctCode = '%'
END IF

SetPointer(HourGlass!)
///////////////////////////////////////////////////////////////////////////////////////
// 2. 자료조회
///////////////////////////////////////////////////////////////////////////////////////
wf_SetMsg('조회 처리 중입니다...')
Long	ll_RowCnt
tab_1.tabpage_1.dw_main.SetReDraw(FALSE)
ll_RowCnt = tab_1.tabpage_1.dw_main.Retrieve(ls_fr_date, ls_to_date, ls_gwa, ls_AcctCode)
tab_1.tabpage_1.dw_main.SetReDraw(TRUE)

tab_1.tabpage_2.dw_print.SetReDraw(FALSE)
ll_RowCnt = tab_1.tabpage_2.dw_print.Retrieve(ls_fr_date, ls_to_date, ls_gwa, ls_AcctCode)
tab_1.tabpage_2.dw_print.SetReDraw(TRUE)


///////////////////////////////////////////////////////////////////////////////////////
// 3. 데이타원도우에 출력조건 및 시스템일자 처리
///////////////////////////////////////////////////////////////////////////////////////
//DateTime	ldt_SysDateTime
//ldt_SysDateTime = f_sysdate()	//시스템일자
//tab_1.tabpage_2.dw_print.Object.t_sysdate.Text = String(ldt_SysDateTime,'YYYY/MM/DD')
//tab_1.tabpage_2.dw_print.Object.t_systime.Text = String(ldt_SysDateTime,'HH:MM:SS')

///////////////////////////////////////////////////////////////////////////////////////
// 4. 메뉴버튼 활성/비활성화 처리 및 메세지 처리
///////////////////////////////////////////////////////////////////////////////////////
IF ll_RowCnt = 0 THEN 
//	//wf_SetMenu('D',FALSE)
//	//wf_SetMenu('S',FALSE)
//	wf_SetMenu('P',FALSE)
	wf_SetMsg('해당자료가 존재하지 않습니다.')
ELSE
//	//wf_SetMenu('D',TRUE)
//	//wf_SetMenu('S',TRUE)
//	wf_SetMenu('P',TRUE)
	wf_SetMsg('자료가 조회되었습니다.')
	
END IF
//////////////////////////////////////////////////////////////////////////////////////////
//	END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event closequery;call super::closequery;//integer li_rc
//
//tab_1.tabpage_1.dw_main.AcceptText()
//
//IF tab_1.tabpage_1.dw_main.DeletedCount() +& 
//   tab_1.tabpage_1.dw_main.ModifiedCount() > 0 THEN
//   li_rc = MessageBox("Closing", "변경된 내용이 있습니다..! 종료하시겠습니까?", Question!, YesNo!, 2)
//	IF li_rc = 1 THEN // Yes 선택
//		RETURN 0
//	ELSEIF li_rc = 2 THEN // No 선택
//		RETURN 1
//	END IF
//ELSE
//	RETURN 0
//END IF
end event

event ue_print;call super::ue_print;//f_print(tab_1.tabpage_2.dw_print)
end event

event ue_postopen;call super::ue_postopen;this.postevent('ue_open')
end event

event ue_printstart;call super::ue_printstart;// 출력물 설정
If idw_print.rowcount() = 0 Then return -1
avc_data.SetProperty('title', "입고현황 리스트")
avc_data.SetProperty('dataobject', idw_print.dataobject)
avc_data.SetProperty('datawindow', idw_print)

////label 설정
//avc_data.SetProperty('column1',"area_gb_t")
//avc_data.SetProperty('data1', dw_con.Object.area_gb[1])
//
Return 1

end event

type ln_templeft from w_msheet`ln_templeft within w_hgm503a
end type

type ln_tempright from w_msheet`ln_tempright within w_hgm503a
end type

type ln_temptop from w_msheet`ln_temptop within w_hgm503a
end type

type ln_tempbuttom from w_msheet`ln_tempbuttom within w_hgm503a
end type

type ln_tempbutton from w_msheet`ln_tempbutton within w_hgm503a
end type

type ln_tempstart from w_msheet`ln_tempstart within w_hgm503a
end type

type uc_retrieve from w_msheet`uc_retrieve within w_hgm503a
end type

type uc_insert from w_msheet`uc_insert within w_hgm503a
end type

type uc_delete from w_msheet`uc_delete within w_hgm503a
end type

type uc_save from w_msheet`uc_save within w_hgm503a
end type

type uc_excel from w_msheet`uc_excel within w_hgm503a
end type

type uc_print from w_msheet`uc_print within w_hgm503a
end type

type st_line1 from w_msheet`st_line1 within w_hgm503a
end type

type st_line2 from w_msheet`st_line2 within w_hgm503a
end type

type st_line3 from w_msheet`st_line3 within w_hgm503a
end type

type uc_excelroad from w_msheet`uc_excelroad within w_hgm503a
end type

type ln_dwcon from w_msheet`ln_dwcon within w_hgm503a
end type

type dw_acct_code from datawindow within w_hgm503a
integer x = 2757
integer y = 248
integer width = 603
integer height = 92
integer taborder = 40
string dataobject = "ddw_acct_code_hgm"
boolean border = false
boolean livescroll = true
end type

type st_5 from statictext within w_hgm503a
integer x = 2496
integer y = 260
integer width = 265
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "계정코드"
boolean focusrectangle = false
end type

type dw_dept_code from datawindow within w_hgm503a
integer x = 1486
integer y = 252
integer width = 768
integer height = 84
integer taborder = 30
string dataobject = "ddw_gwa_code"
boolean border = false
boolean livescroll = true
end type

type st_7 from statictext within w_hgm503a
integer x = 1225
integer y = 260
integer width = 283
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "요구부서"
boolean focusrectangle = false
end type

type tab_1 from tab within w_hgm503a
event create ( )
event destroy ( )
integer x = 50
integer y = 448
integer width = 4384
integer height = 1872
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 4347
integer height = 1752
string text = "물품입고현황"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_main dw_main
end type

on tabpage_1.create
this.dw_main=create dw_main
this.Control[]={this.dw_main}
end on

on tabpage_1.destroy
destroy(this.dw_main)
end on

type dw_main from uo_dwgrid within tabpage_1
integer x = 9
integer y = 16
integer width = 4325
integer height = 1724
integer taborder = 40
string dataobject = "d_hgm503a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event doubleclicked;call super::doubleclicked;
long ll_getrow
string ls_item_middle, ls_item_no, ls_room_code, ls_apply_member_no

this.accepttext()

//IF key = keyenter! THEN
	
	ll_getrow = this.getrow()

   IF dwo.name = 'item_no' THEN                         // 품목코드 
	
	   ls_item_no = this.object.item_no[ll_getrow]
	
		openwithparm(w_hgm001h,ls_item_no)
				
		IF message.stringparm <> '' THEN
		   
//			this.object.item_middle[ll_getrow] = gstru_uid_uname.s_parm[3]
//			this.object.midd_name[ll_getrow] = gstru_uid_uname.s_parm[4]
			this.object.item_no[ll_getrow] = gstru_uid_uname.s_parm[1]
			this.object.item_name[ll_getrow] = gstru_uid_uname.s_parm[2]
//			this.object.item_stand_size[ll_getrow] = gstru_uid_uname.s_parm[6]
//			this.object.model[ll_getrow] = gstru_uid_uname.s_parm[7]
		
		END IF
	
   END IF
	
	

end event

event constructor;call super::constructor;settransobject(sqlca)
end event

event itemerror;call super::itemerror;RETURN 1
end event

event itemfocuschanged;call super::itemfocuschanged;Long ll_qty, ll_price, ll_amt 
ll_qty    = tab_1.tabpage_1.dw_main.object.hst109h_in_qty[tab_1.tabpage_1.dw_main.getrow()]
ll_price  = tab_1.tabpage_1.dw_main.object.hst109h_in_price[tab_1.tabpage_1.dw_main.getrow()]

tab_1.tabpage_1.dw_main.object.hst109h_in_amt[tab_1.tabpage_1.dw_main.getrow()] = ll_qty * ll_price
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4347
integer height = 1752
string text = "물품입고현황 출력"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_print dw_print
end type

on tabpage_2.create
this.dw_print=create dw_print
this.Control[]={this.dw_print}
end on

on tabpage_2.destroy
destroy(this.dw_print)
end on

type dw_print from datawindow within tabpage_2
integer x = 5
integer y = 12
integer width = 4343
integer height = 1732
integer taborder = 40
string title = "none"
string dataobject = "d_hgm503a_1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type st_2 from statictext within w_hgm503a
integer x = 690
integer y = 244
integer width = 73
integer height = 96
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "~~"
boolean focusrectangle = false
end type

type em_to_date from editmask within w_hgm503a
integer x = 759
integer y = 248
integer width = 361
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type em_fr_date from editmask within w_hgm503a
integer x = 315
integer y = 248
integer width = 361
integer height = 92
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
end type

type st_1 from statictext within w_hgm503a
integer x = 133
integer y = 260
integer width = 169
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "기간"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_1 from u_tab within w_hgm503a
integer x = 1358
integer y = 388
integer height = 148
integer taborder = 50
boolean bringtotop = true
string selecttabobject = "tab_1"
end type

on uo_1.destroy
call u_tab::destroy
end on

type gb_1 from groupbox within w_hgm503a
integer x = 50
integer y = 156
integer width = 4384
integer height = 236
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "조회조건"
end type

﻿$PBExportHeader$cuo_insa_member.sru
$PBExportComments$인사공통 성명,개인번호
forward
global type cuo_insa_member from userobject
end type
type st_lab_name from statictext within cuo_insa_member
end type
type st_lab_code from statictext within cuo_insa_member
end type
type st_19 from statictext within cuo_insa_member
end type
type st_jumin_no from statictext within cuo_insa_member
end type
type st_11 from statictext within cuo_insa_member
end type
type st_9 from statictext within cuo_insa_member
end type
type st_10 from statictext within cuo_insa_member
end type
type st_12 from statictext within cuo_insa_member
end type
type st_13 from statictext within cuo_insa_member
end type
type st_14 from statictext within cuo_insa_member
end type
type st_15 from statictext within cuo_insa_member
end type
type st_16 from statictext within cuo_insa_member
end type
type st_17 from statictext within cuo_insa_member
end type
type st_18 from statictext within cuo_insa_member
end type
type st_8 from statictext within cuo_insa_member
end type
type st_7 from statictext within cuo_insa_member
end type
type st_6 from statictext within cuo_insa_member
end type
type st_5 from statictext within cuo_insa_member
end type
type st_4 from statictext within cuo_insa_member
end type
type st_3 from statictext within cuo_insa_member
end type
type st_2 from statictext within cuo_insa_member
end type
type cb_help from commandbutton within cuo_insa_member
end type
type sle_member_no from singlelineedit within cuo_insa_member
end type
type sle_kname from singlelineedit within cuo_insa_member
end type
type st_1 from statictext within cuo_insa_member
end type
type st_jikmu_nm from statictext within cuo_insa_member
end type
type st_firsthire_date from statictext within cuo_insa_member
end type
type st_sal_class from statictext within cuo_insa_member
end type
type st_duty_nm from statictext within cuo_insa_member
end type
type st_jikwi_nm from statictext within cuo_insa_member
end type
type st_jikjong_nm from statictext within cuo_insa_member
end type
type st_dept_nm from statictext within cuo_insa_member
end type
end forward

global type cuo_insa_member from userobject
integer width = 1193
integer height = 80
long backcolor = 31112622
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_clear ( )
event ue_enbled ( boolean ab_value )
event ue_enter ( boolean ab_chk )
event ue_ygdb_auth_chk ( )
st_lab_name st_lab_name
st_lab_code st_lab_code
st_19 st_19
st_jumin_no st_jumin_no
st_11 st_11
st_9 st_9
st_10 st_10
st_12 st_12
st_13 st_13
st_14 st_14
st_15 st_15
st_16 st_16
st_17 st_17
st_18 st_18
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
cb_help cb_help
sle_member_no sle_member_no
sle_kname sle_kname
st_1 st_1
st_jikmu_nm st_jikmu_nm
st_firsthire_date st_firsthire_date
st_sal_class st_sal_class
st_duty_nm st_duty_nm
st_jikwi_nm st_jikwi_nm
st_jikjong_nm st_jikjong_nm
st_dept_nm st_dept_nm
end type
global cuo_insa_member cuo_insa_member

type variables
s_insa_com	istr_com
String		is_KName					//성명
String		is_MemberNo				//개인번호
String		is_JikJongCode			//교직원구분
String		is_GroupID				//권한코드
Integer		ii_SinbunGb				//신분구분(0:학과/전체권한, 1:연구소권한)
Boolean		ib_Option = TRUE		//성명 체크시 구분(TRUE:필수, FALSE:옵션)
Boolean		ib_Sinbun = FALSE		//신분구분에 따라 성명란 활성화/비활성화처리

end variables

event ue_clear();sle_kname.Text         = ''
sle_member_no.Text     = ''
st_jumin_no.Text       = ''
st_firsthire_date.Text = ''
st_sal_class.Text      = ''
st_dept_nm.Text        = ''
st_jikjong_nm.Text     = ''
st_jikwi_nm.Text       = ''
st_duty_nm.Text        = ''
st_jikmu_nm.Text       = ''
end event

event ue_enbled;sle_kname.Enabled = ab_Value
sle_member_no.Enabled = ab_Value
cb_help.Enabled = ab_Value
end event

event ue_ygdb_auth_chk();////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: ue_ygdb_auth_chk
//	기 능 설 명: 연구권한 체크
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
String	ls_MemberNo
String	ls_Name
String	ls_SinbunGbn
ls_MemberNo = gs_empcode //gstru_uid_uname.uid			//개인번호
ls_Name     = gs_empname  //gstru_uid_uname.uname			//성명
	
///////////////////////////////////////////////////////////////////////////////////////
// 1. 신분구분 SELECT
///////////////////////////////////////////////////////////////////////////////////////
String	ls_JuminNo
String	ls_DeptCode
String	ls_JikJongCode
Integer	li_JikWiCode
String	ls_DutyCode
Integer	li_JikMuCode
String	ls_FirstHireDate
String	ls_HakwonHireDate
String	ls_SalClass
String	ls_GroupID
String	ls_ComDeptNm
String	ls_ComJikJongNm
String	ls_ComJikWiNm
String	ls_ComDutyNm
String	ls_ComJikMuNm
SELECT	'1',
			B.JUMIN_NO,
			B.GWA,
			SUBSTR(B.DUTY_CODE,1,1)	JIKJONG_CODE,
			B.JIKWI_CODE,
			B.DUTY_CODE,
			B.JIKMU_CODE,
			B.FIRSTHIRE_DATE,
			B.HAKWONHIRE_DATE,
			B.SAL_CLASS,
			C.GROUP_ID,
			FU_DEPT_NM(B.GWA,'K')														COM_DEPT_NM,
			FU_CODE_NM('COMM','JIKJONG_CODE',SUBSTR(B.DUTY_CODE,1,1),'K')	COM_JIKJONG_NM,
			FU_CODE_NM('COMM','JIKWI_CODE',B.JIKWI_CODE,'K')					COM_JIKWI_NM,
			FU_DUTY_NM(B.DUTY_CODE,'K')												COM_DUTY_NM,
			FU_CODE_NM('COMM','JIKWI_CODE',B.JIKMU_CODE,'K')					COM_JIKMU_NM
INTO		:ls_SinbunGbn,
			:ls_JuminNo,
			:ls_DeptCode,
			:ls_JikJongCode,
			:li_JikWiCode,
			:ls_DutyCode,
			:li_JikMuCode,
			:ls_FirstHireDate,
			:ls_HakwonHireDate,
			:ls_SalClass,
			:ls_GroupID,
			:ls_ComDeptNm,
			:ls_ComJikJongNm,
			:ls_ComJikWiNm,
			:ls_ComDutyNm,
			:ls_ComJikMuNm	
FROM		INDB.HIN001M B,
			CDDB.KCH403M C
WHERE		B.MEMBER_NO  = C.MEMBER_NO
AND		B.JAEJIK_OPT = 1
AND		B.MEMBER_NO = :ls_MemberNo
AND		(C.GROUP_ID LIKE 'HYG%' OR C.GROUP_ID = 'Mnger')
AND		ROWNUM = 1;
IF SQLCA.SQLCODE <> 0 THEN
	f_dis_msg(1,'연구권한 체크시 오류가 발생하였습니다.','')
	MessageBox('오류',&
					'연구권한 체크시 전산장애가 발생되었습니다.~r~n' + &
					'하단의 장애번호와 장애내역을~r~n' + &
					'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
					'장애번호 : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
					'장애내역 : ' + SQLCA.SqlErrText)
	ib_Sinbun = FALSE
	THIS.TRIGGER EVENT ue_enbleD(ib_Sinbun)
	RETURN
END IF
istr_com.ls_Item[01]   = ls_Name				//성명
istr_com.ls_Item[02]   = ls_MemberNo		//개인번호
istr_com.ls_item[03]   = ls_JuminNo			//주민번호
istr_com.ls_item[04]   = ls_DeptCode		//조직코드
istr_com.ls_item[05]   = ls_JikJongCode	//직종코드
istr_com.ll_item[06]   = li_JikWiCode		//직위코드
istr_com.ls_item[07]   = ls_DutyCode		//직급코드
istr_com.ll_item[08]   = li_JikMuCode		//직무코드
istr_com.ls_item[09]   = ls_FirstHireDate	//최초임용일
istr_com.ls_item[10]   = ls_HakwonHireDate//학원임용일
istr_com.ls_item[11]   = ls_SalClass		//호봉코드
istr_com.ls_item[12]   = ls_ComDeptNm		//조직명
istr_com.ls_item[13]   = ls_ComJikJongNm	//직종명
istr_com.ls_item[14]   = ls_ComJikWiNm		//직위명
istr_com.ls_item[15]   = ls_ComDutyNm		//직급명
istr_com.ls_item[16]   = ls_ComJikMuNm		//직무명

///////////////////////////////////////////////////////////////////////////////////////
// 2. 권한체크
//			연구책임자, 공동연구원 : 성명 비활성화
//			연구담당자 : 성명 활성화
//CHOOSE CASE ls_SinbunGbn 
//	CASE '1','2'
//	CASE '3'    ;ib_Sinbun = FALSE	//학생
//	CASE '9'    ;ib_Sinbun = FALSE	//외부
//	CASE ELSE
//END CHOOSE
///////////////////////////////////////////////////////////////////////////////////////
Boolean	lb_Chk
ii_SinbunGb = 0
is_GroupID = UPPER(ls_GroupID)
IF is_GroupID = 'HYG1' OR is_GroupID = 'MNGER' THEN
	ib_Sinbun = TRUE	//연구담당자
ELSE
	ib_Sinbun = FALSE	//교원,직원
END IF
IF NOT ib_Sinbun THEN
	sle_kname.Text     = ls_Name
	sle_member_no.Text = ls_MemberNo
END IF

THIS.TRIGGER EVENT ue_enbled(ib_Sinbun)

///////////////////////////////////////////////////////////////////////////////////////
// 3. 연구소별 권한
///////////////////////////////////////////////////////////////////////////////////////
String	ls_Gwa
String	ls_LabCode
String	ls_LabName
ls_Gwa = gs_deptcode //gstru_uid_uname.dept_code	//부서코드

SELECT	B.LAB_CODE,
			FU_LAB_NM(B.LAB_CODE)
INTO		:ls_LabCode,
			:ls_LabName
FROM		YGDB.HYB130M A,
			YGDB.HYB140H B,
			CDDB.KCH003M C
WHERE		A.LAB_CODE      = B.LAB_CODE
AND		B.GWA           = C.GWA
AND		B.LAB_MEMBER_NO LIKE :ls_MemberNo||'%'
AND		B.GWA           LIKE :ls_Gwa||'%'
AND		C.GWA_GUBUN     = '9'
AND		ROWNUM          = 1;
IF SQLCA.SQLCODE = 0 THEN
	st_lab_code.Text = ls_LabCode
	st_lab_name.Text = ls_LabName
	ii_SinbunGb = 1
END IF
////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

on cuo_insa_member.create
this.st_lab_name=create st_lab_name
this.st_lab_code=create st_lab_code
this.st_19=create st_19
this.st_jumin_no=create st_jumin_no
this.st_11=create st_11
this.st_9=create st_9
this.st_10=create st_10
this.st_12=create st_12
this.st_13=create st_13
this.st_14=create st_14
this.st_15=create st_15
this.st_16=create st_16
this.st_17=create st_17
this.st_18=create st_18
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.cb_help=create cb_help
this.sle_member_no=create sle_member_no
this.sle_kname=create sle_kname
this.st_1=create st_1
this.st_jikmu_nm=create st_jikmu_nm
this.st_firsthire_date=create st_firsthire_date
this.st_sal_class=create st_sal_class
this.st_duty_nm=create st_duty_nm
this.st_jikwi_nm=create st_jikwi_nm
this.st_jikjong_nm=create st_jikjong_nm
this.st_dept_nm=create st_dept_nm
this.Control[]={this.st_lab_name,&
this.st_lab_code,&
this.st_19,&
this.st_jumin_no,&
this.st_11,&
this.st_9,&
this.st_10,&
this.st_12,&
this.st_13,&
this.st_14,&
this.st_15,&
this.st_16,&
this.st_17,&
this.st_18,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.cb_help,&
this.sle_member_no,&
this.sle_kname,&
this.st_1,&
this.st_jikmu_nm,&
this.st_firsthire_date,&
this.st_sal_class,&
this.st_duty_nm,&
this.st_jikwi_nm,&
this.st_jikjong_nm,&
this.st_dept_nm}
end on

on cuo_insa_member.destroy
destroy(this.st_lab_name)
destroy(this.st_lab_code)
destroy(this.st_19)
destroy(this.st_jumin_no)
destroy(this.st_11)
destroy(this.st_9)
destroy(this.st_10)
destroy(this.st_12)
destroy(this.st_13)
destroy(this.st_14)
destroy(this.st_15)
destroy(this.st_16)
destroy(this.st_17)
destroy(this.st_18)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_help)
destroy(this.sle_member_no)
destroy(this.sle_kname)
destroy(this.st_1)
destroy(this.st_jikmu_nm)
destroy(this.st_firsthire_date)
destroy(this.st_sal_class)
destroy(this.st_duty_nm)
destroy(this.st_jikwi_nm)
destroy(this.st_jikjong_nm)
destroy(this.st_dept_nm)
end on

event constructor;sle_kname.Text = gs_empName

end event

type st_lab_name from statictext within cuo_insa_member
integer x = 553
integer y = 360
integer width = 832
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_lab_code from statictext within cuo_insa_member
integer x = 553
integer y = 280
integer width = 741
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_19 from statictext within cuo_insa_member
integer x = 270
integer y = 296
integer width = 261
integer height = 52
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "연구소"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_jumin_no from statictext within cuo_insa_member
integer x = 1490
integer y = 12
integer width = 462
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_11 from statictext within cuo_insa_member
integer x = 1477
integer width = 489
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_9 from statictext within cuo_insa_member
integer x = 1216
integer y = 12
integer width = 256
integer height = 52
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "주민번호"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_10 from statictext within cuo_insa_member
integer x = 699
integer y = 8
integer width = 407
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_12 from statictext within cuo_insa_member
integer x = 224
integer y = 80
integer width = 544
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_13 from statictext within cuo_insa_member
integer x = 983
integer y = 80
integer width = 384
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_14 from statictext within cuo_insa_member
integer x = 1582
integer y = 80
integer width = 544
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_15 from statictext within cuo_insa_member
integer x = 2341
integer y = 80
integer width = 690
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_16 from statictext within cuo_insa_member
integer x = 2871
integer width = 155
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_17 from statictext within cuo_insa_member
integer x = 2341
integer width = 375
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_18 from statictext within cuo_insa_member
integer x = 1842
integer y = 260
integer width = 544
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_8 from statictext within cuo_insa_member
integer x = 1637
integer y = 272
integer width = 206
integer height = 52
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "직무명"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_7 from statictext within cuo_insa_member
integer x = 2011
integer y = 12
integer width = 334
integer height = 52
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "최초임용일"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_6 from statictext within cuo_insa_member
integer x = 2729
integer y = 12
integer width = 142
integer height = 52
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "호봉"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_5 from statictext within cuo_insa_member
integer x = 2135
integer y = 92
integer width = 206
integer height = 52
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "직급명"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within cuo_insa_member
integer x = 1376
integer y = 92
integer width = 206
integer height = 52
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "직위명"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within cuo_insa_member
integer x = 777
integer y = 92
integer width = 206
integer height = 52
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "직종명"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within cuo_insa_member
integer x = 14
integer y = 92
integer width = 206
integer height = 52
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "부서명"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_help from commandbutton within cuo_insa_member
integer x = 1111
integer y = 4
integer width = 69
integer height = 72
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string pointer = "Help!"
string text = "?"
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: clicked::cb_help
//	기 능 설 명: 인사정보 도움말 오픈처리
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
s_insa_com	lstr_com
String		ls_KName
ls_KName = TRIM(sle_KName.Text)

lstr_com.ls_item[1] = ls_KName		//성명
lstr_com.ls_item[2] = ''				//개인번호
lstr_com.ls_item[3] = is_JikJongCode//교직원구분

OpenWithParm(w_hin000h,lstr_com)

//lstr_com.ls_item[01] = ls_KName				//성명
//lstr_com.ls_item[02] = ls_MemberNo			//개인번호
//lstr_com.ls_item[03] = ls_JuminNo				//주민번호
//lstr_com.ls_item[04] = ls_DeptCode			//조직코드
//lstr_com.ls_item[05] = ls_JikJongCode		//직종코드
//lstr_com.ll_item[06] = li_JikWiCode			//직위코드
//lstr_com.ls_item[07] = ls_DutyCode			//직급코드
//lstr_com.ll_item[08] = li_JikMuCode			//직무코드
//lstr_com.ls_item[09] = ls_FirstHireDate		//최초임용일
//lstr_com.ls_item[10] = ls_HakwonHireDate	//학원임용일
//lstr_com.ls_item[11] = ls_SalClass			//호봉코드
//lstr_com.ls_item[12] = ls_ComDeptNm			//조직명
//lstr_com.ls_item[13] = ls_ComJikJongNm		//직종명
//lstr_com.ls_item[14] = ls_ComJikWiNm			//직위명
//lstr_com.ls_item[15] = ls_ComDutyNm			//직급명
//lstr_com.ls_item[16] = ls_ComJikMuNm			//직무명
istr_com = Message.PowerObjectParm
IF NOT isValid(istr_com) THEN
	sle_kname.SetFocus()
	RETURN
END IF

is_KName               = istr_com.ls_item[01]	//성명
gs_empName                = is_KName					//성명
is_MemberNo            = istr_com.ls_item[02]	//개인번호
sle_kname.Text         = is_KName					//성명
sle_member_no.Text     = is_MemberNo				//개인번호
st_jumin_no.Text       = String(istr_com.ls_item[03],'@@@@@@-@@@@@@@')	//주민번호
st_firsthire_date.Text = String(istr_com.ls_item[09],'@@@@/@@/@@')		//학원임용일
st_sal_class.Text      = istr_com.ls_item[11]	//호봉코드
st_dept_nm.Text        = istr_com.ls_item[12]	//조직명
st_jikjong_nm.Text     = istr_com.ls_item[13]	//직종명
st_jikwi_nm.Text       = istr_com.ls_item[14]	//직위명
st_duty_nm.Text        = istr_com.ls_item[15]	//직급명
st_jikmu_nm.Text       = istr_com.ls_item[16]	//직무명

SEND(HANDLE(THIS),256,9,LONG(0,0))
PARENT.TRIGGER EVENT ue_Enter(TRUE)
////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

type sle_member_no from singlelineedit within cuo_insa_member
integer x = 722
integer y = 12
integer width = 361
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 79741120
boolean border = false
boolean displayonly = true
end type

type sle_kname from singlelineedit within cuo_insa_member
event ue_keydown pbm_keydown
integer x = 238
integer y = 8
integer width = 453
integer height = 64
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 1090519039
boolean border = false
end type

event ue_keydown;////////////////////////////////////////////////////////////////////////////////////////// 
//	이 벤 트 명: modified::em_ac_code
//	기 능 설 명: 변경시 처리사항 기술
//	작성/수정자: 
//	작성/수정일: 
//	주 의 사 항: 
//////////////////////////////////////////////////////////////////////////////////////////
IF keyflags <> 0 THEN RETURN
////////////////////////////////////////////////////////////////////////////////
// 1. F1인 경우 도움말 OPEN
////////////////////////////////////////////////////////////////////////////////
IF key = KeyF1! THEN
	cb_help.TRIGGER EVENT clicked()
	RETURN
END IF

IF key <> KeyEnter! THEN RETURN
////////////////////////////////////////////////////////////////////////////////
// 2. 항목 변경시 처리
////////////////////////////////////////////////////////////////////////////////
s_insa_com	lstr_com
IF NOT isValid(istr_com) THEN
	istr_com = lstr_com
END IF

////////////////////////////////////////////////////////////////////////////////
// 3. 조회조건체크
////////////////////////////////////////////////////////////////////////////////
String	ls_KName
ls_KName = TRIM(sle_KName.Text)

Long		ll_Cnt
String	ls_KNameTmp
String	ls_MemberNo
String	ls_JuminNo
String	ls_DeptCode
String	ls_JikJongCode
Integer	li_JikWiCode
String	ls_DutyCode
Integer	li_JikMuCode
String	ls_FirstHireDate
String	ls_HakwonHireDate
String	ls_SalClass
String	ls_ComDeptNm
String	ls_ComJikJongNm
String	ls_ComJikWiNm
String	ls_ComDutyNm
String	ls_ComJikMuNm

SELECT	RTRIM(A.NAME),
			RTRIM(A.MEMBER_NO),
			A.JUMIN_NO,
			A.GWA,
			SUBSTR(A.DUTY_CODE,1,1)	JIKJONG_CODE,
			A.JIKWI_CODE,
			A.DUTY_CODE,
			A.JIKMU_CODE,
			A.FIRSTHIRE_DATE,
			A.HAKWONHIRE_DATE,
			A.SAL_CLASS,
			FU_DEPT_NM(A.GWA,'K')														COM_DEPT_NM,
			FU_CODE_NM('HAENG','JIKJONG_CODE',SUBSTR(A.DUTY_CODE,1,1),'K')	COM_JIKJONG_NM,
			FU_CODE_NM('HAENG','JIKWI_CODE',A.JIKWI_CODE,'K')					COM_JIKWI_NM,
			FU_DUTY_NM(A.DUTY_CODE,'K')												COM_DUTY_NM,
			FU_CODE_NM('HAENG','JIKWI_CODE',A.JIKMU_CODE,'K')					COM_JIKMU_NM,
			NVL(B.COM_CNT,0)
INTO		:ls_KNameTmp,
			:ls_MemberNo,
			:ls_JuminNo,
			:ls_DeptCode,
			:ls_JikJongCode,
			:li_JikWiCode,
			:ls_DutyCode,
			:li_JikMuCode,
			:ls_FirstHireDate,
			:ls_HakwonHireDate,
			:ls_SalClass,
			:ls_ComDeptNm,
			:ls_ComJikJongNm,
			:ls_ComJikWiNm,
			:ls_ComDutyNm,
			:ls_ComJikMuNm,			
			:ll_Cnt
FROM		INDB.HIN001M A,
			(	SELECT	COUNT(*)	COM_CNT
				FROM		INDB.HIN001M A
				WHERE		A.NAME LIKE :ls_KName||'%'	) B
WHERE		A.NAME LIKE :ls_KName||'%';


PARENT.TRIGGER EVENT ue_clear()
sle_kname.Text = ls_KName		//성명

CHOOSE CASE ll_Cnt
	CASE 0
		IF ib_Option THEN cb_help.TRIGGER EVENT clicked()
		PARENT.TRIGGER EVENT ue_Enter(FALSE)
	CASE 1
		sle_kname.Text         = ls_KNameTmp		//성명
		gs_empName                = ls_KNameTmp		//성명
		sle_member_no.Text     = ls_MemberNo		//개인번호
		st_jumin_no.Text       = String(ls_JuminNo,'@@@@@@-@@@@@@@')	//주민번호
		st_firsthire_date.Text = String(ls_FirstHireDate,'@@@@/@@/@@')	//학원임용일
		st_sal_class.Text      = ls_SalClass		//호봉코드
		st_dept_nm.Text        = ls_ComDeptNm		//조직명
		st_jikjong_nm.Text     = ls_ComJikJongNm	//직종명
		st_jikwi_nm.Text       = ls_ComJikWiNm		//직위명
		st_duty_nm.Text        = ls_ComDutyNm		//직급명
		st_jikmu_nm.Text       = ls_ComJikMuNm		//직무명
		
		is_KName               = ls_KNameTmp		//성명
		is_MemberNo            = ls_MemberNo		//개인번호
		istr_com.ls_Item[01]   = ls_KNameTmp		//성명
		istr_com.ls_Item[02]   = ls_MemberNo		//개인번호
		istr_com.ls_item[03]   = ls_JuminNo			//주민번호
		istr_com.ls_item[04]   = ls_DeptCode		//조직코드
		istr_com.ls_item[05]   = ls_JikJongCode	//직종코드
		istr_com.ll_item[06]   = li_JikWiCode		//직위코드
		istr_com.ls_item[07]   = ls_DutyCode		//직급코드
		istr_com.ll_item[08]   = li_JikMuCode		//직무코드
		istr_com.ls_item[09]   = ls_FirstHireDate	//최초임용일
		istr_com.ls_item[10]   = ls_HakwonHireDate//학원임용일
		istr_com.ls_item[11]   = ls_SalClass		//호봉코드
		istr_com.ls_item[12]   = ls_ComDeptNm		//조직명
		istr_com.ls_item[13]   = ls_ComJikJongNm	//직종명
		istr_com.ls_item[14]   = ls_ComJikWiNm		//직위명
		istr_com.ls_item[15]   = ls_ComDutyNm		//직급명
		istr_com.ls_item[16]   = ls_ComJikMuNm		//직무명
		
		SEND(HANDLE(THIS),256,9,LONG(0,0))
		PARENT.TRIGGER EVENT ue_Enter(TRUE)
	CASE IS > 1
		IF ib_Option THEN cb_help.TRIGGER EVENT clicked()
		PARENT.TRIGGER EVENT ue_Enter(FALSE)
	CASE ELSE
		MessageBox('오류','전산장애가 발생되었습니다.~r~n' + &
						'하단의 장애번호와 장애내역을~r~n' + &
						'기록하신뒤 전산실로 연락바랍니다~r~n~r~n' + &
						'장애번호SQLCODE : ' + String(SQLCA.SQLCODE) + '~r~n' + &
						'장애번호SqlDbCode : ' + String(SQLCA.SqlDbCode) + '~r~n' + &
						'장애내역 : ' + SQLCA.SQLERRTEXT,StopSign!,Ok!)
		PARENT.TRIGGER EVENT ue_Enter(FALSE)
END CHOOSE
////////////////////////////////////////////////////////////////////////////////////////// 
// END OF SCRIPT
//////////////////////////////////////////////////////////////////////////////////////////
end event

event getfocus;SelectText(1,20)
end event

event modified;String	ls_KName
ls_KName = THIS.Text
PARENT.TRIGGER EVENT ue_clear()
THIS.Text = ls_KName

end event

type st_1 from statictext within cuo_insa_member
integer y = 8
integer width = 219
integer height = 52
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 18751006
long backcolor = 31112622
string text = "성명"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_jikmu_nm from statictext within cuo_insa_member
integer x = 1870
integer y = 276
integer width = 475
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_firsthire_date from statictext within cuo_insa_member
integer x = 2368
integer y = 12
integer width = 338
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_sal_class from statictext within cuo_insa_member
integer x = 2898
integer y = 12
integer width = 114
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_duty_nm from statictext within cuo_insa_member
integer x = 2368
integer y = 92
integer width = 613
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_jikwi_nm from statictext within cuo_insa_member
integer x = 1609
integer y = 92
integer width = 475
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_jikjong_nm from statictext within cuo_insa_member
integer x = 1010
integer y = 92
integer width = 315
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_dept_nm from statictext within cuo_insa_member
integer x = 251
integer y = 92
integer width = 494
integer height = 52
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type


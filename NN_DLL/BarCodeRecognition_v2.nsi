; �Ӹ}���ϥ� HM VNISEdit �}���s�边�Q�ɲ���

; �w�˵{�Ǫ�l�w�q�`�q
!define PRODUCT_NAME "Kaiwood Oned Barcode"
!define PRODUCT_VERSION "2.0.0.0"
!define PRODUCT_PUBLISHER "Kaiwood"
!define PRODUCT_WEB_SITE "http://www.kaiwood.com"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

!define KEY_UNINST_HEAD_ROOT_X86 "HKCR"
!define KEY_UNINST_ROOT_X86 "HKCR"
!define KEY_HEAD "BarCodeRecognition.BarcodeReder"
!define KEY_CLSID "{82B2DB60-E1E8-453B-9E8B-B320CEAAEF39}"
!define KEY_UNINST_QR_WRITER_HEAD_X86 "BarcodeReder"
!define KEY_UNINST_QR_WRITER_X86 "CLSID\{82B2DB60-E1E8-453B-9E8B-B320CEAAEF39}"

!define KEY_UNINST_HEAD_ROOT_X64 "HKLM"
!define KEY_UNINST_ROOT_X64 "HKCR"
!define KEY_UNINST_QR_WRITER_HEAD_X64 "SOFTWARE\Classes\BarcodeReder"
!define KEY_UNINST_QR_WRITER_X64 "Wow6432Node\${KEY_UNINST_QR_WRITER_X86}"

SetCompressor lzma

; ------ MUI �{�N�ɭ��w�q (1.67 �����H�W�ݮe) ------

!include "MUI.nsh"
!include "x64.nsh"
!include "LogicLib.nsh"
!include "DotNetVer.nsh"

; MUI �w�w�q�`�q
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"


; �w�ﭶ��
!insertmacro MUI_PAGE_WELCOME
; �w�˹L�{����
!insertmacro MUI_PAGE_INSTFILES
; �w�˧�������
!insertmacro MUI_PAGE_FINISH

; �w�˨����L�{����
!insertmacro MUI_UNPAGE_INSTFILES

; �w�ˬɭ��]�t���y���]�m
!insertmacro MUI_LANGUAGE "English"

; �w�˹w������
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI �{�N�ɭ��w�q���� ------

Name "${PRODUCT_NAME}"
OutFile "BarCodeRecognition_v2.exe"
InstallDir "$PROGRAMFILES\Kaiwood\OnedBarcode\v.${PRODUCT_VERSION}"
ShowInstDetails show
ShowUnInstDetails show

Section -Prerequisites
  ${If} ${HasDotNet2.0}

  ${Else}
    ${If} ${RunningX64}
      ExecWait "Prerequisites\NetFx20SP2_x64.exe"
    ${Else}
      ExecWait "Prerequisites\NetFx20SP2_x86.exe"
    ${EndIf}
	${EndIf}
SectionEnd

Section "Main" SEC01

  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  File "D:\GlobalDll\v.1.0.2\NN_DLL\AForge.dll"
  File "D:\GlobalDll\v.1.0.2\NN_DLL\AForge.Imaging.dll"
  File "D:\GlobalDll\v.1.0.2\NN_DLL\AForge.Math.dll"
  File "D:\GlobalDll\v.1.0.2\NN_DLL\BarCodeRecognition.dll"
  File "D:\GlobalDll\v.1.0.2\NN_DLL\ImageProcess.dll"
  File "D:\GlobalDll\v.1.0.2\NN_DLL\Kaiwood.Image.dll"
  File "D:\GlobalDll\v.1.0.2\NN_DLL\zxing.dll"
  
SectionEnd

;Section -AdditionalIcons
;  CreateDirectory "$SMPROGRAMS\Kaiwood\Barcode\v.1.0.2"
;  CreateShortCut "$SMPROGRAMS\Kaiwood\Barcode\v.1.0.2\Uninstall.lnk" "$INSTDIR\uninst.exe"
;SectionEnd

Section -Post
        WriteUninstaller "$INSTDIR\uninst.exe"
        WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
        WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
        WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
        WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
        WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
        ${If} ${RunningX64}
        	WriteRegStr   HKLM "${KEY_UNINST_QR_WRITER_HEAD_X64}" "" "${KEY_HEAD}"
        	WriteRegStr   HKLM "${KEY_UNINST_QR_WRITER_HEAD_X64}\CLSID" "" "${KEY_CLSID}"
        	WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X64}" "" "${KEY_HEAD}"
        	WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X64}\InprocServer32" "" "mscoree.dll"
        	WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X64}\InprocServer32" "ThreadingModel" "Both"
        	WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X64}\InprocServer32" "Class" "${KEY_HEAD}"
        	WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X64}\InprocServer32" "Assembly" "BarCodeRecognition, Version=2.0.0.0, Culture=neutral, PublicKeyToken=null"
        	WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X64}\InprocServer32" "RuntimeVersion" "v2.0.50727"
        	WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X64}\InprocServer32" "CodeBase" "$INSTDIR\BarCodeRecognition.dll"
        	WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X64}\InprocServer32\${PRODUCT_VERSION}" "Class" "${KEY_HEAD}"
        	WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X64}\InprocServer32\${PRODUCT_VERSION}" "Assembly" "BarCodeRecognition, Version=2.0.0.0, Culture=neutral, PublicKeyToken=null"
        	WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X64}\InprocServer32\${PRODUCT_VERSION}" "RuntimeVersion" "v2.0.50727"
        	WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X64}\InprocServer32\${PRODUCT_VERSION}" "CodeBase" "$INSTDIR\BarCodeRecognition.dll"
			WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X64}\ProgId" "" "${KEY_UNINST_QR_WRITER_HEAD_X86}"
			
        ${Else}
                WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_HEAD_X86}" "" "${KEY_HEAD}"
                WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_HEAD_X86}\CLSID" "" "${KEY_CLSID}"
                WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X86}" "" "${KEY_HEAD}"
                WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X86}\InprocServer32" "" "mscoree.dll"
                WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X86}\InprocServer32" "ThreadingModel" "Both"
                WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X86}\InprocServer32" "Class" "${KEY_HEAD}"
                WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X86}\InprocServer32" "Assembly" "BarCodeRecognition, Version=2.0.0.0, Culture=neutral, PublicKeyToken=null"
                WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X86}\InprocServer32" "RuntimeVersion" "v2.0.50727"
                WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X86}\InprocServer32" "CodeBase" "$INSTDIR\BarCodeRecognition.dll"
                WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X86}\InprocServer32\${PRODUCT_VERSION}" "Class" "${KEY_HEAD}"
                WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X86}\InprocServer32\${PRODUCT_VERSION}" "Assembly" "BarCodeRecognition, Version=2.0.0.0, Culture=neutral, PublicKeyToken=null"
                WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X86}\InprocServer32\${PRODUCT_VERSION}" "RuntimeVersion" "v2.0.50727"
                WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X86}\InprocServer32\${PRODUCT_VERSION}" "CodeBase" "$INSTDIR\BarCodeRecognition.dll"
                WriteRegStr   HKCR "${KEY_UNINST_QR_WRITER_X86}\ProgId" "" "${KEY_UNINST_QR_WRITER_HEAD_X86}"

        ${EndIf}

SectionEnd

/******************************
 *  �H�U�O�w�˵{�Ǫ���������  *
 ******************************/

Section Uninstall
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\AForge.dll"
  Delete "$INSTDIR\AForge.Imaging.dll"
  Delete "$INSTDIR\AForge.Math.dll"
  Delete "$INSTDIR\BarCodeRecognition.dll"
  Delete "$INSTDIR\ImageProcess.dll"
  Delete "$INSTDIR\Kaiwood.Image.dll"
  Delete "$INSTDIR\zxing.dll"

;  Delete "$SMPROGRAMS\Kaiwood\Barcode\v.1.0.2\Uninstall.lnk"

;  RMDir "$SMPROGRAMS\Kaiwood\Barcode\v.1.0.2"

  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
        ${If} ${RunningX64}
                DeleteRegKey ${KEY_UNINST_HEAD_ROOT_X64} "${KEY_UNINST_QR_WRITER_HEAD_X64}"
                DeleteRegKey ${KEY_UNINST_ROOT_X64} "${KEY_UNINST_QR_WRITER_X64}"
        ${Else}
                DeleteRegKey ${KEY_UNINST_HEAD_ROOT_X86} "${KEY_UNINST_QR_WRITER_HEAD_X86}"
                DeleteRegKey ${KEY_UNINST_ROOT_X86} "${KEY_UNINST_QR_WRITER_X86}"
        ${EndIf}
  SetAutoClose true
SectionEnd

#-- �ھ� NSIS �}���s��W�h�A�Ҧ� Function �Ϭq������m�b Section �Ϭq����s�g�A�H�קK�w�˵{�ǥX�{���i�w�������D�C--#

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Uninatall $(^Name) ?" IDYES +2
  Abort
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) unistall succeeded!"
FunctionEnd

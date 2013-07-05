; 該腳本使用 HM VNISEdit 腳本編輯器嚮導產生

; 安裝程序初始定義常量
!define StrRep "!insertmacro StrRep"
!macro StrRep output string old new
    Push "${string}"
    Push "${old}"
    Push "${new}"
    !ifdef __UNINSTALL__
        Call un.StrRep
    !else
        Call StrRep
    !endif
    Pop ${output}
!macroend 
!macro Func_StrRep un
    Function ${un}StrRep
        Exch $R2 ;new
        Exch 1
        Exch $R1 ;old
        Exch 2
        Exch $R0 ;string
        Push $R3
        Push $R4
        Push $R5
        Push $R6
        Push $R7
        Push $R8
        Push $R9
 
        StrCpy $R3 0
        StrLen $R4 $R1
        StrLen $R6 $R0
        StrLen $R9 $R2
        loop:
            StrCpy $R5 $R0 $R4 $R3
            StrCmp $R5 $R1 found
            StrCmp $R3 $R6 done
            IntOp $R3 $R3 + 1 ;move offset by 1 to check the next character
            Goto loop
        found:
            StrCpy $R5 $R0 $R3
            IntOp $R8 $R3 + $R4
            StrCpy $R7 $R0 "" $R8
            StrCpy $R0 $R5$R2$R7
            StrLen $R6 $R0
            IntOp $R3 $R3 + $R9 ;move offset by length of the replacement string
            Goto loop
        done:
 
        Pop $R9
        Pop $R8
        Pop $R7
        Pop $R6
        Pop $R5
        Pop $R4
        Pop $R3
        Push $R0
        Push $R1
        Pop $R0
        Pop $R1
        Pop $R0
        Pop $R2
        Exch $R1
    FunctionEnd
!macroend
!insertmacro Func_StrRep ""
;!insertmacro Func_StrRep "un."
!define PRODUCT_NAME "Kaiwood Oned Barcode"
!define PRODUCT_VERSION "2.1.0.0"
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

; ------ MUI 現代界面定義 (1.67 版本以上兼容) ------

!include "MUI.nsh"
!include "x64.nsh"
!include "LogicLib.nsh"
!include "DotNetVer.nsh"

; MUI 預定義常量
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"


; 歡迎頁面
!insertmacro MUI_PAGE_WELCOME
; 安裝過程頁面
!insertmacro MUI_PAGE_INSTFILES
; 安裝完成頁面
!insertmacro MUI_PAGE_FINISH

; 安裝卸載過程頁面
!insertmacro MUI_UNPAGE_INSTFILES

; 安裝界面包含的語言設置
!insertmacro MUI_LANGUAGE "English"

; 安裝預釋放文件
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI 現代界面定義結束 ------

Name "${PRODUCT_NAME}"
OutFile "BarCodeRecognition_v2.1.exe"
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
 *  以下是安裝程序的卸載部分  *
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

#-- 根據 NSIS 腳本編輯規則，所有 Function 區段必須放置在 Section 區段之後編寫，以避免安裝程序出現未可預知的問題。--#

Function .onInit
 
  ReadRegStr $R0 HKLM \
  "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" \
  "UninstallString"
  
  ReadRegStr $R1 HKLM \
  "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" \
  "DisplayVersion"
  
  StrCmp $R0 "" done
  StrCmp $R1 "${PRODUCT_VERSION}" done
  
  ${StrRep} $R2 $R0 "uninst.exe" ""
 
  MessageBox MB_OK|MB_ICONEXCLAMATION \
  "${PRODUCT_NAME} is already installed. $\n$\nClick 'OK' to remove the \
  previous version" \
  ;uninst
  ;Abort
 
;Run the uninstaller
;uninst:
  ClearErrors
  ExecWait "$R0 _?=$R2" ;Do not copy the uninstaller to a temp file
  ; ExecWait "$R0"
  ; Abort
  
;Recheck again
  ;ReadRegStr $R0 HKLM \
  ;"Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" \
  ;"UninstallString"
  
  ;ReadRegStr $R1 HKLM \
  ;"Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" \
  ;"DisplayVersion"
  ;StrCmp $R0 "" done  
  ;Abort
 
  IfErrors no_remove_uninstaller done
    ;You can either use Delete /REBOOTOK in the uninstaller or add some code
    ;here to remove the uninstaller. Use a registry key to check
    ;whether the user has chosen to uninstall. If you are using an uninstaller
    ;components page, make sure all sections are uninstalled.
  no_remove_uninstaller:
 
 
done:
 
FunctionEnd

Function un.onInit  
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Uninatall $(^Name) ?" IDYES +2  
  Abort
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) unistall succeeded!"
FunctionEnd

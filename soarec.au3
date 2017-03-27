;~ ; 1. global variables
Local $autorun = 0
Local $running = 0
Local $mousePos
Local $lastMousePos
;~ ; 2. functions

; start moving mouse
Func MoveMouse()
   ; check if is already moving
   If $running = 1 Then
	  Return
   EndIf

   $autorun = 1
   Do
		 $running = 1
		 ; move mouse in square sequence
		  If MoveCursorBy(50, 0) <> 1 Then
			 Return
		  ElseIf MoveCursorBy(0, 50) <> 1 Then
			 Return
		  ElseIf MoveCursorBy(-50, 0) <> 1 Then
			 Return
		  ElseIf MoveCursorBy(0, -50) <> 1 Then
			 Return
		  EndIf
   Until $running = 0
EndFunc


; move mouse with coords (X,Y,speed)
Func MoveCursorBy(Const $xCoord, Const $yCoord, Const $speed = 5)
   ; get current coordinates
	$lastMousePos = MouseGetPos()
	; move cursor
	MouseMove($lastMousePos[0] + $xCoord, $lastMousePos[1] + $yCoord , $speed)
	; get updated coordinates
	$mousePos = MouseGetPos()
	; if the coordinates are altered - running stops
	If $lastMousePos[0] + $xCoord <> $mousePos[0] Or $lastMousePos[1] + $yCoord  <> $mousePos[1] Then
	   $running = 0
	   Return 0
	EndIf
	Return 1
EndFunc

; stop mouse movement
Func MouseStop()
   $running = 0
   $autorun = 0
EndFunc

; display tooltip
Func DisplayToolTip()
ToolTip ("[F9] - AUTO-START 30s" & @CRLF & _
"[F10] - STOP" & @CRLF & _
"[Ctrl + F12] - EXIT" , 0, 0, "Muta soarecu'" , 1, 4)
EndFunc

; close application
Func ExitApp()
   Exit
EndFunc

; move mouse if idle
Func MoveMouseIfIdle()
   While $autorun = 1
	  ; save last mouse position
	  $lastMousePos = MouseGetPos()
	  Sleep(30 * 1000)
	  ; save current mouse position
	  $mousePos = MouseGetPos()
	  ; if mouse has not moved, start moving
	  If $mousePos[0] = $lastMousePos[0] And $mousePos[1] = $lastMousePos[1] And $running = 0 Then
		 MoveMouse()
	  EndIf
   WEnd
EndFunc

;~ ; 3. main app
HotkeySet("{F9}", "MoveMouse")
HotkeySet("{F10}", "MouseStop")
HotKeySet("^{F12}","ExitApp")
; display tooltips and start moving mouse
   DisplayToolTip()
   MoveMouse()
While 1
   MoveMouseIfIdle()
WEnd
; end main application
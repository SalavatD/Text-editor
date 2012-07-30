
IncludeFile "OpenMainWindow.pb"

Global filePath.s = ""

Procedure StatusBarUpdate()
  
  If filePath = ""
    StatusBarText(#STATUS_BAR, 0, "Безымянный", #PB_StatusBar_Right)
  Else
    StatusBarText(#STATUS_BAR, 0, GetFilePart(filePath), #PB_StatusBar_Right)
  EndIf
EndProcedure

Procedure WriteToFile()
  
  If CreateFile(0, filePath)
    buffer.s = GetGadgetText(#EDITOR)
    WriteString(0, buffer)
    CloseFile(0)
  EndIf
EndProcedure

Procedure ReadFromFile()
  
  buffer.s = ""
  If ReadFile(0, filePath)
    While Eof(0) = 0
      buffer = buffer + ReadString(0) + #CR$
    Wend
    CloseFile(0)
    SetGadgetText(#EDITOR, buffer)
  EndIf
EndProcedure

Procedure Create()
  
  If MessageRequester("Создание", "Все несохраненные изменения будут потеряны." + #CR$ + "Продолжить?", #PB_MessageRequester_YesNo | #MB_ICONINFORMATION) = #PB_MessageRequester_Yes
    filePath = ""
    ClearGadgetItems(#EDITOR)
  EndIf
EndProcedure

Procedure Open()
  
  If MessageRequester("Открытие", "Все несохраненные изменения будут потеряны." + #CR$ + "Продолжить?", #PB_MessageRequester_YesNo | #MB_ICONINFORMATION) = #PB_MessageRequester_Yes
    filePathTemp.s = OpenFileRequester("Открытие", "", "Текстовые документы (*.txt)|*.txt|Все файлы (*.*)|*.*", 1)
    If filePathTemp <> ""
      filePath = filePathTemp
      ClearGadgetItems(#EDITOR)
      ReadFromFile()
    EndIf
  EndIf
EndProcedure

Procedure SaveAs()
  
  filePathTemp.s = SaveFileRequester("Сохранение файла", "", "Текстовые документы (*.txt)|*.txt|Все файлы (*.*)|*.*", 1)
  If filePathTemp <> ""
    filePath = filePathTemp
    WriteToFile()
  EndIf
EndProcedure

Procedure Save()
  
  If filePath = ""
    SaveAs()
  Else
    WriteToFile()
  EndIf
EndProcedure

Procedure Font()
  fontName.s = "Consolas"
  fontSize  = 11
  result = FontRequester(fontName, fontSize, #PB_FontRequester_Effects)
  If result
    If LoadFont(#CUSTOM_FONT, SelectedFontName(), SelectedFontSize(), SelectedFontStyle())
      
      SetGadgetFont(#EDITOR, FontID(#CUSTOM_FONT))
      
      SetGadgetColor(#EDITOR, #PB_Gadget_FrontColor, SelectedFontColor())
    EndIf
  EndIf
EndProcedure

Procedure MainMenuHandler(eventMenu.i, eventGadget.i)
  
  Select eventMenu
    Case #ACTION_CREATE
      Create()
      StatusBarUpdate()
    Case #ACTION_OPEN
      Open()
      StatusBarUpdate()
    Case #ACTION_SAVE
      Save()
      StatusBarUpdate()
    Case #ACTION_SAVE_AS
      SaveAs()
      StatusBarUpdate()
    Case #ACTION_UNDO
      SendMessage_(GadgetID(eventGadget), #EM_UNDO, 0, 0)
    Case #ACTION_REDO
      SendMessage_(GadgetID(eventGadget), #EM_REDO, 0, 0)
    Case #ACTION_CUT
      SendMessage_(GadgetID(eventGadget), #WM_CUT, 0, 0)
    Case #ACTION_COPY
      SendMessage_(GadgetID(eventGadget), #WM_COPY, 0, 0)
    Case #ACTION_PASTE
      SendMessage_(GadgetID(eventGadget), #WM_PASTE, 0, 0)
    Case #ACTION_CLEAR
      SendMessage_(GadgetID(eventGadget), #WM_CLEAR, 0, 0)
    Case #ACTION_SELECT_ALL
      SendMessage_(GadgetID(eventGadget), #EM_SETSEL, 0, -1)
    Case #ACTION_TIME_AND_DATE
      SendMessage_(GadgetID(eventGadget), #WM_SETTEXT, 0, FormatDate("%hh:%ii %dd.%mm.%yyyy", Date()))
    Case #ACTION_FONT
      Font()
    Case #ACTION_ABOUT
      MessageRequester("О программе", "Текстовый редактор. Версия 1.0" + #CR$ + #CR$ + "Автор: Салават Даутов" + #CR$ + #CR$ + "Дата создания: июль 2012 года", #MB_ICONINFORMATION)
  EndSelect
EndProcedure

OpenMainWindow()

Repeat
  
  event       = WaitWindowEvent()
  eventMenu   = EventMenu()
  eventGadget = EventGadget()
  eventWindow = EventWindow()
  eventType   = EventType()
  
  If eventWindow = #MAIN_WINDOW
    If event = #PB_Event_SizeWindow
      ResizeGadget(#EDITOR, #PB_Ignore, #PB_Ignore, WindowWidth(#MAIN_WINDOW), WindowHeight(#MAIN_WINDOW) - 43)
    EndIf
    
    If event = #WM_RBUTTONUP
      DisplayPopupMenu(#POPUP_MENU, WindowID(#MAIN_WINDOW))
    EndIf
    
    If event = #PB_Event_Menu
      If eventMenu = #ACTION_EXIT
        Break
      ElseIf eventMenu = #ACTION_NEW_WINDOW
        RunProgram(ProgramFilename())
      Else
        MainMenuHandler(eventMenu, #EDITOR)
      EndIf
    EndIf
    
    If event = #PB_Event_Gadget
      If eventGadget = #EDITOR
        StatusBarText(#STATUS_BAR, 1, "Строк: " + Str(CountGadgetItems(#EDITOR)), #PB_StatusBar_Right)
      EndIf
    EndIf
  EndIf
Until event = #PB_Event_CloseWindow And eventWindow = #MAIN_WINDOW

; IDE Options = PureBasic 4.51 (Windows - x86)
; CursorPosition = 160
; FirstLine = 119
; Folding = --
; EnableXP
; UseIcon = Icon.ico
; Executable = Текстовый редактор.exe
; DisableDebugger
; IncludeVersionInfo
; VersionField0 = 1.0.0.0
; VersionField1 = 1.0.0.0
; VersionField2 = Салават Даутов
; VersionField3 = Текстовый редактор
; VersionField4 = 1.0
; VersionField5 = 1.0
; VersionField6 = Текстовый редактор
; VersionField7 = Текстовый редактор
; VersionField8 = Текстовый редактор.exe
; VersionField17 = 0419 Russian

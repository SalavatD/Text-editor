
Enumeration
  #MAIN_WINDOW
EndEnumeration

Enumeration
  #MAIN_MENU
  #EDITOR
  #POPUP_MENU
EndEnumeration

Enumeration
  #ACTION_CREATE
  #ACTION_NEW_WINDOW
  #ACTION_OPEN
  #ACTION_SAVE
  #ACTION_SAVE_AS
  #ACTION_EXIT
  #ACTION_UNDO
  #ACTION_REDO
  #ACTION_CUT
  #ACTION_COPY
  #ACTION_PASTE
  #ACTION_CLEAR
  #ACTION_SELECT_ALL
  #ACTION_TIME_AND_DATE
  #ACTION_FONT
  #ACTION_ABOUT
EndEnumeration

Enumeration
  #STATUS_BAR
EndEnumeration

Enumeration
  #CONSOLAS_FONT_11
  #CUSTOM_FONT
EndEnumeration


Procedure OpenMainWindow()
  
  If OpenWindow(#MAIN_WINDOW, #PB_Ignore, #PB_Ignore, 1000, 500, "��������� ��������",  #PB_Window_SystemMenu | #PB_Window_MinimizeGadget | #PB_Window_MaximizeGadget | #PB_Window_SizeGadget | #PB_Window_ScreenCentered)
    WindowBounds(#MAIN_WINDOW, 500, 250, #PB_Ignore, #PB_Ignore)
    
    If CreateMenu(#MAIN_MENU, WindowID(#MAIN_WINDOW))
      MenuTitle("&����")
      MenuItem(#ACTION_CREATE,        "����&���"          + Chr(9) + "Ctrl+N")
      MenuItem(#ACTION_NEW_WINDOW,    "&����� ����"       + Chr(9) + "Ctrl+Shift+N")
      MenuItem(#ACTION_OPEN,          "&�������..."       + Chr(9) + "Ctrl+O")
      MenuItem(#ACTION_SAVE,          "&���������"        + Chr(9) + "Ctrl+S")
      MenuItem(#ACTION_SAVE_AS,       "&��������� ���..." + Chr(9) + "Ctrl+Shift+S")
      MenuBar()
      MenuItem(#ACTION_EXIT,          "&�����")
      
      MenuTitle("&������")
      MenuItem(#ACTION_UNDO,          "&��������"         + Chr(9) + "Ctrl+Z")
      MenuItem(#ACTION_REDO,          "&�������"          + Chr(9) + "Ctrl+Y")
      MenuBar()
      MenuItem(#ACTION_CUT,           "&��������"         + Chr(9) + "Ctrl+X")
      MenuItem(#ACTION_COPY,          "&����������"       + Chr(9) + "Ctrl+C")
      MenuItem(#ACTION_PASTE,         "���&�����"         + Chr(9) + "Ctrl+V")
      MenuItem(#ACTION_CLEAR,         "&�������"          + Chr(9) + "Del")
      MenuBar()
      MenuItem(#ACTION_SELECT_ALL,    "�������� �&��"     + Chr(9) + "Ctrl+A")
      MenuItem(#ACTION_TIME_AND_DATE, "����&� � ����"     + Chr(9) + "F5")
      
      MenuTitle("���&���")
      MenuItem(#ACTION_FONT,          "&�����...")
      
      MenuTitle("&�������")
      MenuItem(#ACTION_ABOUT,         "&� ���������")
    EndIf
    
    EditorGadget(#EDITOR, 0, 0, WindowWidth(#MAIN_WINDOW), WindowHeight(#MAIN_WINDOW) - 43)
    
    SetActiveGadget(#EDITOR)
    
    SmartWindowRefresh(#MAIN_WINDOW, #True)
    
    If LoadFont(#CONSOLAS_FONT_11, "Consolas", 11)
      SetGadgetFont(#EDITOR, FontID(#CONSOLAS_FONT_11))
    EndIf
    
    If CreateStatusBar(#STATUS_BAR, WindowID(#MAIN_WINDOW))
      AddStatusBarField(350)
      AddStatusBarField(100)
      
      StatusBarText(#STATUS_BAR, 0, "����������", #PB_StatusBar_Right)
    EndIf
    
    If CreatePopupMenu(#POPUP_MENU)
      MenuItem(#ACTION_UNDO,       "��������")
      MenuItem(#ACTION_REDO,       "���������")
      MenuBar()
      MenuItem(#ACTION_CUT,        "��������")
      MenuItem(#ACTION_COPY,       "����������")
      MenuItem(#ACTION_PASTE,      "��������")
      MenuItem(#ACTION_CLEAR,      "�������")
      MenuBar()
      MenuItem(#ACTION_SELECT_ALL, "�������� ���")
    EndIf
    
    AddKeyboardShortcut(#MAIN_WINDOW, #PB_Shortcut_Control | #PB_Shortcut_N ,                      #ACTION_CREATE)
    AddKeyboardShortcut(#MAIN_WINDOW, #PB_Shortcut_Control | #PB_Shortcut_Shift | #PB_Shortcut_N , #ACTION_NEW_WINDOW)
    AddKeyboardShortcut(#MAIN_WINDOW, #PB_Shortcut_Control | #PB_Shortcut_O ,                      #ACTION_OPEN)
    AddKeyboardShortcut(#MAIN_WINDOW, #PB_Shortcut_Control | #PB_Shortcut_S ,                      #ACTION_SAVE)
    AddKeyboardShortcut(#MAIN_WINDOW, #PB_Shortcut_Control | #PB_Shortcut_Shift | #PB_Shortcut_S , #ACTION_SAVE_AS)
    AddKeyboardShortcut(#MAIN_WINDOW, #PB_Shortcut_Control | #PB_Shortcut_N ,                      #ACTION_TIME_AND_DATE)
    AddKeyboardShortcut(#MAIN_WINDOW, #PB_Shortcut_F5 ,                                            #ACTION_CREATE)
  EndIf
EndProcedure

; IDE Options = PureBasic 4.51 (Windows - x86)
; CursorPosition = 111
; FirstLine = 70
; Folding = -
; EnableXP

# gameui - Game UI

add_library(gameui SHARED
    BackgroundMenuButton.cpp
    BasePanel.cpp
    GameConsole.cpp
    GameUI_Interface.cpp
    ModInfo.cpp
    MouseMessageForwardingPanel.cpp
    ${CMAKE_SOURCE_DIR}/common/GameUI/ObjectList.cpp
    PanelListPanel.cpp
    RunGameEngine.cpp
    ${CMAKE_SOURCE_DIR}/common/GameUI/scriptobject.cpp
    Sys_Utils.cpp
    TextEntryBox.cpp
    TGAImagePanel.cpp
    ${CMAKE_SOURCE_DIR}/public/vgui_controls/vgui_controls.cpp
    VGuiSystemModuleLoader.cpp
    BonusMapsDatabase.cpp
    ${CMAKE_SOURCE_DIR}/common/language.cpp
    ${CMAKE_SOURCE_DIR}/common/imageutils.cpp
    SaveGameBrowserDialog.cpp
    gameui_util.cpp
    BitmapImagePanel.cpp
    CommandCheckButton.cpp
    CvarNegateCheckButton.cpp
    ${CMAKE_SOURCE_DIR}/common/GameUI/cvarslider.cpp
    CvarTextEntry.cpp
    CvarToggleCheckButton.cpp
    HapticControlBox.cpp
    KeyToggleCheckButton.cpp
    LabeledCommandComboBox.cpp
    URLButton.cpp
    vcontrolslistpanel.cpp
    BenchmarkDialog.cpp
    BonusMapsDialog.cpp
    CommentaryDialog.cpp
    CommentaryExplanationDialog.cpp
    ContentControlDialog.cpp
    CustomTabExplanationDialog.cpp
    GameConsoleDialog.cpp
    LoadGameDialog_Xbox.cpp
    LoadGameDialog.cpp
    MultiplayerAdvancedDialog.cpp
    NewGameDialog.cpp
    PlayerListDialog.cpp
    SaveGameDialog_Xbox.cpp
    SaveGameDialog.cpp
    LoadCommentaryDialog.cpp
    LoadingDialog.cpp
    BaseSaveGameDialog.cpp
    CreateMultiplayerGameBotPage.cpp
    CreateMultiplayerGameDialog.cpp
    CreateMultiplayerGameGameplayPage.cpp
    CreateMultiplayerGameServerPage.cpp
    OptionsDialog_Xbox.cpp
    ControllerDialog.cpp
    matchmaking/achievementsdialog.cpp
    matchmaking/basedialog.cpp
    matchmaking/dialogmenu.cpp
    matchmaking/leaderboarddialog.cpp
    matchmaking/matchmakingbasepanel.cpp
    matchmaking/pausedialog.cpp
    matchmaking/sessionlobbydialog.cpp
    matchmaking/sessionoptionsdialog.cpp
    matchmaking/sessionbrowserdialog.cpp
    matchmaking/welcomedialog.cpp
    OptionsDialog.cpp
    OptionsSubAudio.cpp
    OptionsSubDifficulty.cpp
    OptionsSubGame.cpp
    OptionsSubKeyboard.cpp
    OptionsSubMouse.cpp
    OptionsSubTouch.cpp
    OptionsSubMultiplayer.cpp
    OptionsSubPortal.cpp
    OptionsSubVideo.cpp
    OptionsSubVoice.cpp
    ${CMAKE_SOURCE_DIR}/public/tier0/memoverride.cpp
)

# Platform-specific sources
if(WIN32)
    target_sources(gameui PRIVATE
        LogoFile.cpp
        ChangeGameDialog.cpp
        OptionsSubHaptics.cpp
    )
endif()

# Defines
target_compile_definitions(gameui PRIVATE
    GAMEUI_EXPORTS=1
    NO_STEAM=1
    VERSION_SAFE_STEAM_API_INTERFACES=1
)

target_include_directories(gameui PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/public
    ${CMAKE_SOURCE_DIR}/public/tier0
    ${CMAKE_SOURCE_DIR}/public/tier1
    ${CMAKE_SOURCE_DIR}/common
    ${CMAKE_SOURCE_DIR}/common/GameUI
    ${CMAKE_SOURCE_DIR}/thirdparty
)

target_link_libraries(gameui PUBLIC
    tier0
    vgui_controls
    tier1
    tier2
    tier3
    vstdlib
    vtf
    bitmap
    mathlib
)

# Platform libs
if(WIN32)
    target_link_libraries(gameui PRIVATE user32 gdi32)
endif()

install(TARGETS gameui RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR})

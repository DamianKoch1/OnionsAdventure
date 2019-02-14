extends Container

#hardcoded all scene paths because godot crashes if two scenes reference each other using exported packedscenes
onready var creditscreen = preload("res://Menus/MainMenu/CreditScreen.tscn")
onready var extrasMenu = preload("res://Menus/ExtrasMenu/ExtrasMenu.tscn")
onready var levelSelector = preload("res://Menus/LevelSelector/LevelSelector.tscn")
onready var newGamePanels = preload("res://Menus/StoryPanels/NewGamePanels/NewGamePanels.tscn")

onready var fade = $Fade

var focusButton

func _ready():
	$Fade.fadeIn()
	$YesNoOverlayQuit.connect("yesPressed", self, "quit")
	$YesNoOverlayQuit.connect("noPressed", self, "cancel")
	$YesNoOverlayQuit.hide()
	if MenuMusic.playing == false:
		MenuMusic.fadeIn()
	if SaveGame.fileExists(SaveGame.savePath):
		focusButton = $ContinueButton
		$NewGameButton.hide()
		$ContinueButton.show()
	else:
		focusButton = $NewGameButton
		$NewGameButton.show()
		$ContinueButton.hide()
	focusButton.grab_focus()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if $OptionsOverlay.visible == false:
			if $YesNoOverlayQuit.visible == false:
				_on_QuitButton_pressed()
			else:
				cancel()
				focusButton.grab_focus()
		else:
			focusButton.grab_focus()


func _on_CreditsButton_pressed():
	fade.oneshot(self, "credits", 2)

func credits():
	get_tree().change_scene_to(creditscreen)


func _on_QuitButton_pressed():
	if $YesNoOverlayQuit.visible == false:
		$YesNoOverlayQuit.show()
		$YesNoOverlayQuit/NoButton.grab_focus()


func _on_OptionsButton_pressed():
	fade.oneshot(self, "options", 2)

func options():
	$YesNoOverlayQuit.hide()
	$OptionsOverlay.show()
	$OptionsOverlay/BackButton.grab_focus()
	fade.fadeIn(2)
	

func quit():
	get_tree().quit()

func cancel():
	$YesNoOverlayQuit.hide()
	focusButton.grab_focus()



func _on_ExtrasButton_pressed():
	fade.oneshot(self, "extras", 2)

func extras():
	get_tree().change_scene_to(extrasMenu)


func _on_NewGameButton_pressed():
	fade.oneshot(self, "newGame")
	
func newGame():
	SaveGame.deleteSave()
	SaveGame.loadPlayerState = false
	get_tree().change_scene_to(newGamePanels)



func _on_ContinueButton_pressed():
	fade.oneshot(self, "loadGame")

func loadGame():
	SaveGame.loadGame()

func _on_LevelSelectorButton_pressed():
	fade.oneshot(self, "levelSelector", 2)

func levelSelector():
	SaveGame.checkLevelProgress()
	SaveGame.loadPlayerState = false
	get_tree().change_scene_to(levelSelector)


#when options menu finishes fading out
func _on_AnimationPlayer_animation_finished(anim_name):
	fade.show()
	fade.fadeIn(2)
	focusButton.grab_focus()

#options menu back button
func _on_BackButton_pressed():
	fade.oneshot(self, "back", 2) 

func back():
	$OptionsOverlay.hide()
	fade.fadeIn(2)
	focusButton.grab_focus()
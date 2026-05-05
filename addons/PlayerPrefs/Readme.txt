PlayerPrefs Plugin for Godot

A lightweight Unity-like PlayerPrefs system for Godot.
Easily store and retrieve data such as int, float, and string across sessions.


#1 Installation:-

	a. Put the addons folder in the root project folder i.e. res://addons/PlayerPrefs
	b. Restart or reload your current project
	c. Go to - Project -> Project Settings -> Plugins -> Enable PlayerPrefs


#2 Usage:-
	a. Set value
		i. PlayerPrefs.set_int("score", 100) 
		ii. PlayerPrefs.set_float("volume", 0.8) 
		iii. PlayerPrefs.set_string("name", "Tanay")

	b. Get value
		i. PlayerPrefs.get_int("score")
		ii. PlayerPrefs.get_float("volume")
		iii. PlayerPrefs.get_string("name")

	c. Utilities
		i. PlayerPrefs.has_key("score") - to check the key's existance
        ii. PlayerPrefs.delete_key("score") - to delete a key
        iii. PlayerPrefs.delete_all() - to delete all the data
        iv. PlayerPrefs.save() - to save the data

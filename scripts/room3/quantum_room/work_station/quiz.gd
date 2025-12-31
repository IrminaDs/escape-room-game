extends CanvasLayer

var questions = [
	{
		"question": "Jaka jest najmniejsza jednostka informacji kwantowej?",
		"answers": ["Foton", "Bit", "Kubit", "Atom"]
	},
	{
		"question": "Czym różni się kubit od klasycznego bitu?",
		"answers": ["Kubit może znajdować się jednocześnie w stanie jeden i zero ", "Kubit może przyjąć tylko jeden z dwóch stanów - zero lub jeden ", "Kubit to jednostka pamięci w klasycznych kopmuterach", "Kubit przechowuje więcej informacji, ponieważ ma cztery możliwe stany bazowe"]
	},
	{
		"question": "Na jakich dwóch bazach opiera się protokół QKD BB84?",
		"answers": ["Poziomej i pionowej", "Prostej i skośnej", "Kołowej o liniowej", "Opiera się na czterech bazach"]
	},
	{
		"question": "Co jest celem protokołu BB84?",
		"answers": ["Kompresja danych w celu zmniejszenia ich rozmiaru", "Publiczne udostępnienie klucza wszystkim użytkownikom sieci", "Weryfikacja tożsamości użytkownika za pomocą hasła i loginu", "Bezpieczne wygenerowanie i uzgodnienie tajnego klucza szyfrującego"]
	},
	{
		"question": "Co robi polaryzator?",
		"answers": ["Rozszczepia światło białe na poszczególne kolory tęczy", "Skupia wszystkie promienie świetlne w jednym punkcie", "Przepuszcza tylko światło drgające w jednej, określonej płaszczyźnie", "Zmienia częstotliwość fal, zmieniając barwę światła"]
	},
		{
		"question": "Jaką rolę pełni polaryzacja w protokole BB84?",
		"answers": ["Służy do zakodowania wartości bitów klucza na cząstkach światła", "Umożliwia szybsze przeysłanie zaszyfrowanej informacji", "Chroni cząstki światła przed utratą energii", "Sprawia, że przesyłane cząstki są niewidoczne dla detektorów"]
	}
]

var current_question := 0
var correct_sequence := "CABDCA"
var player_sequence := ""

@onready var wrong_info := $Panel/WrongAnswers
@onready var question_label = $Panel/Panel/VBoxContainer/Question
@onready var answer_labels = [
	$Panel/Panel/VBoxContainer/A/A2,
	$Panel/Panel/VBoxContainer/B/B2,
	$Panel/Panel/VBoxContainer/C/C2,
	$Panel/Panel/VBoxContainer/D/D2
]
func _ready():
	Room3GameEvents.next_question.connect(_on_answer_selected)
	_update_question()

func _update_question():
	question_label.text = questions[current_question]["question"]
	var answers = questions[current_question]["answers"]
	for i in answer_labels.size():
		answer_labels[i].text = answers[i]

func _on_answer_selected(letter: String):
	player_sequence += letter
	current_question += 1

	if current_question < questions.size():
		_update_question()
	else:
		_check_result()

func _check_result():
	if player_sequence == correct_sequence:
		Room3GameEvents.quiz_completed.emit()
	else:
		_show_info()
		_reset_quiz()

func _reset_quiz():
	current_question = 0
	player_sequence = ""
	_update_question()

func _show_info():
	Room3GameEvents.answer_wrong.emit()
	wrong_info.visible = true
	await get_tree().create_timer(3).timeout
	wrong_info.visible = false
	
	

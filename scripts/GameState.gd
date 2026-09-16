extends Node

var dia_atual: int = 1
var atividades_feitas: Dictionary = {}  

func completar(atividade: String) -> void:
	atividades_feitas[atividade] = true
	print(atividade, " concluído!")
	_verificar_avanco()

func _atividades_do_dia(dia: int) -> Array:
	match dia:
		1:
			return ["lavar_rosto"]
		2:
			return ["lavar_rosto", "escovar_dente"]
		3:
			return ["lavar_rosto", "escovar_dente", "tomar_banho"]
		_:
			return ["lavar_rosto", "escovar_dente", "tomar_banho", "lavar_roupa"]


func _verificar_avanco() -> void:
	var necessarias: Array = _atividades_do_dia(dia_atual)

	for atividade in necessarias:
		if not atividades_feitas.get(atividade, false):
			return   

	dia_atual += 1
	atividades_feitas.clear()
	print("Passou pro dia ", dia_atual)

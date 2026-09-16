extends Node

# Autoload "GameState" — guarda o dia atual e quais atividades já foram feitas nesse dia.

var dia_atual: int = 1
var atividades_feitas: Dictionary = {}   # ex: {"lavar_rosto": true}

func completar(atividade: String) -> void:
	atividades_feitas[atividade] = true
	print(atividade, " concluído!")
	_verificar_avanco()

func pode_fazer(atividade: String) -> bool:
	var necessarias: Array = _atividades_do_dia(dia_atual)
	if atividade not in necessarias:
		return false   # não é uma atividade do dia de hoje
	if atividades_feitas.get(atividade, false):
		return false   # já foi feita hoje
	return true

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
			print("Ainda falta: ", atividade)  # debug temporário
			return   # ainda falta alguma coisa hoje, não avança

	# Completou tudo que era necessário nesse dia
	dia_atual += 1
	atividades_feitas.clear()
	print("Passou pro dia ", dia_atual)
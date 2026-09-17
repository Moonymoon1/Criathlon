extends Node

# Autoload "GameState" — guarda o dia atual e quais atividades já foram feitas nesse dia.

var dia_atual: int = 1
var atividades_feitas: Dictionary = {}
var pronto_para_dormir: bool = false   # true quando já fez tudo que precisava hoje

func completar(atividade: String) -> bool:
	atividades_feitas[atividade] = true
	print(atividade, " concluído!")
	return _verificar_avanco()

func pode_fazer(atividade: String) -> bool:
	var necessarias: Array = _atividades_do_dia(dia_atual)
	if atividade not in necessarias:
		return false
	if atividades_feitas.get(atividade, false):
		return false
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

func _verificar_avanco() -> bool:
	var necessarias: Array = _atividades_do_dia(dia_atual)

	for atividade in necessarias:
		if not atividades_feitas.get(atividade, false):
			return false

	dia_atual += 1
	atividades_feitas.clear()
	pronto_para_dormir = true
	print("Passou pro dia ", dia_atual)
	return true

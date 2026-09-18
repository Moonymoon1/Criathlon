extends Node2D

@onready var botao_verificar: Button = $BotaoVerificar
var liberado: bool = false
var terminou: bool = false

func _on_botao_verificar_pressed() -> void:
	if GameState.pode_fazer("lavar_roupa"):
		liberado = true
		botao_verificar.visible = false
	else:
		print("Não tenho disposição para fazer isso hoje...")
		Transicao.trocar_cena("res://scenes/Banheiro.tscn")

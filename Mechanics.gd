extends Node2D

enum Affiliation {
	Player,
	Enemy,
	Other
}

var affiliations = [[0, 1, 0], [1, 0, 0], [0, 0, 0]]

func getTarget(searcher):
	var children = []
	for child in searcher.get_parent().get_children():
		if typeof(child) == typeof(CharacterBody2D):
			if checkAffiliation(searcher, child):
				children.append(child)
	
	return children

func checkAffiliation(searcher, target):
	var searcherTeam = searcher.get_meta("affiliation", -1)
	var targetTeam = target.get_meta("affiliation", -1)
	
	if searcherTeam >= 0 and targetTeam >= 0:
		return affiliations[searcherTeam][targetTeam]

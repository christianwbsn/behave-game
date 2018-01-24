:- include('dynamic_clauses.pl').

% New Game - State Initialization
init_player_state :- asserta(player_skills(0)),
	  				 asserta(player_motivation(100)),
	  				 asserta(player_consciousness(100)),
	  				 asserta(player_location(10,1)),
	  				 asserta(current_location(mulmed)).

init_enemies :- asserta(enemy_location(1,1,madamLili)),
				asserta(enemy_location(2,4,penunggu)),
				asserta(enemy_location(1,14,penjaga)),
				asserta(enemy_location(10,8,dosen)),
				asserta(enemy_location(10,14,tubes)),
				asserta(enemy_location(13,11,angel)),
				asserta(enemy_location(12,4,anak2)),
				asserta(enemy_location(16,1,satpam)),
				asserta(enemy_location(20,5,kating)),
				asserta(enemy_location(20,11,deadline)).

init_inventories:-asserta(inventories(bread)).

init_object:-asserta(object(1,4,shoes)),
			 asserta(object(1,13,code)),
			 asserta(object(2,6,food_voucher)),
			 asserta(object(7,1,beautiful_girl)),
			 asserta(object(7,12,coffee)),
			 asserta(object(9,1,water)),
			 asserta(object(10,4,laptop)),
			 asserta(object(10,9,smartphone)),
			 asserta(object(12,1,chips)),
			 asserta(object(14,4,task_paper)),
			 asserta(object(12,9,bread)),
			 asserta(object(12,11,innocent_face)),
			 asserta(object(20,1,coffee)),
			 asserta(object(20,8,money)),
			 asserta(object(19,14,radar)).

init_attributes :- asserta(player_attributes(fist)).

init_dynamic_clauses :- init_object,init_attributes,
						init_enemies,init_inventories,!.
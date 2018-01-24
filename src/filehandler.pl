:- include('dynamic_clauses.pl').

deleteEnemy([]) :- !.
deleteEnemy([(A,B)|Tail]) :- retract(enemy_location(A,B,_)), deleteEnemy(Tail).

deleteObj([]) :- !.
deleteObj([(A,B)|Tail]) :- retract(object(A,B,_)), deleteObj(Tail).

deleteInv([]) :- !.
deleteInv([A|Tail]) :- retract(inventories(A)), deleteInv(Tail).

check(Val) :- \+(Val == end_of_file), retract(player_name(_)), retract(player_skills(_)), retract(player_consciousness(_)), retract(player_motivation(_)),
	   retract(player_attributes(_)), retract(player_location(_,_)), retract(current_location(_)).
check(Val) :- (Val == end_of_file), !.

% Write Stream player current state
writerule(Stream, X) :- write(Stream, X), write(Stream, '.'), nl(Stream).
writelol(Stream, []) :- player_name(Name), player_skills(Skills), player_consciousness(Consciousness), player_motivation(Motivation),
						player_attributes(Attributes), player_location(M, Y), current_location(Z),
						writerule(Stream, player_name(Name)), writerule(Stream, player_skills(Skills)),
						writerule(Stream, player_consciousness(Consciousness)), writerule(Stream, player_motivation(Motivation)),
						writerule(Stream, player_attributes(Attributes)), writerule(Stream, player_location(M, Y)), writerule(Stream, current_location(Z)), !.

% Write Stream enemy location current state
writelol(Stream, [(A,B)|Tail]) :- enemy_location(A,B,C),
								  writerule(Stream, enemy_location(A,B,C)), writelol(Stream, Tail).

% Write Stream current inventory
list_inv(Z):- findall(X,inventories(X),Z),!.
writeinv(_, []) :- !.
writeinv(Stream, [A|Tail]) :- inventories(A), writerule(Stream, inventories(A)), writeinv(Stream, Tail).

% Write Stream current object								  
list_obj(Z):- findall((X,Y),object(X,Y,_),Z),!.
writeobj(_, []) :- !.
writeobj(Stream, [(A,B)|Tail]) :- object(A,B,C),
							      writerule(Stream, object(A,B,C)), writeobj(Stream, Tail).

% Saving current state to file
save(Filename) :- list_enemy(ListOfEnemy), list_inv(ListOfInv), list_obj(ListOfObj),
		          open(Filename,write,Stream), writelol(Stream, ListOfEnemy), writeinv(Stream, ListOfInv), writeobj(Stream, ListOfObj), write(Stream, 'end_of_file.'), close(Stream),
                  write('> Your progress has been succesfully saved to file '),write(Filename),nl.

% Read Stream from file
readrule(Stream, X):-  read(Stream, X).
readlol(Stream, N) :-  \+ (N == 'end_of_file'), asserta(N), readrule(Stream, X), readlol(Stream, X).
readlol(_,N)       :-  N == 'end_of_file', !.

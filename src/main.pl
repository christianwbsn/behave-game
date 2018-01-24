% Include modules
:- include('location.pl').
:- include('description.pl').
:- include('game_state.pl').
:- include('filehandler.pl').

:- initialization(start).

start :- title,
		 about,
		 game_mode,!.

% Game-Player interaction
player_data :- tab(2),write('Insert name [Use '' '']: '),
			   read(Player),
		       asserta(player_name(Player)),
		       tab(2),write('Welcome to Behave, '),write(Player), write(' !'),nl,nl,!.

mode_instructions :- tab(2),write('Type ''new.'' if you want to start new game'),nl,
			         tab(2),write('or ''load <name>.'' if you want to load game'),nl.

% Game Mode Control Loop  
game_mode :- mode_instructions,
             repeat,
             catch((
					write('> '),
					read(user_input,Mode),
					mode_action(Mode),
		      (Mode == quit)),
		      error(syntax_error(_),_), 
		      (write('> Your input is invalid. Type "help." to see available command.'), 
		      nl,fail,!)).

%Start New Game
new :- player_data,
	   init_player_state,
	   init_dynamic_clauses,
	   help,
	   intro,
	   describe(mulmed),
	   command_loop.

% Load file from file
loads(Filename) :- file_exists(Filename),write('> You''ve successfully load game from '),write(Filename),nl,
		           open(Filename,read,Stream), readrule(Stream, N), readlol(Stream, N), close(Stream),
				   write('> Welcome back, '),player_name(Player),write(Player),write(' !'),nl,
		           command_loop,!.
loads(Filename) :- write('> File with name'),write(Filename),write(' doesn''t exist'),nl,game_mode,!.

% List Of existing command
do(start):- start,!.
do(use(X)):- use(X),!.
do(take(X)):- take(X),!.
do(drop(X)):- drop(X),!.
do(inventory):- inventory,!.
do(attack):- attack,!.
do(look):- print_around,!.
do(instructions):- instructions,!.
do(enemy):- enemy,!.
do(status) :- status, !.
do(map):- map,!.
do(n):- n,!.
do(s):- s,!.
do(w):- w,!.
do(e):- e,!.
do(ne):- ne,!.
do(se):- se,!.
do(nw):- nw,!.
do(sw):- sw,!.
do(help):-help,!.
do(quit) :- quit,!.
do(surrender) :- surrender,!.
do(inspect(Object)) :- inspect(Object),!.
do(save(Filename)) :- save(Filename),!.
do(credits) :- credits, !.
do(_) :- error_message,!.

% Game mode command
mode_action(help):- mode_instructions,!.
mode_action(new) :- new,!.
mode_action(load(Filename)) :- loads(Filename), !.
mode_action(exit) :- quit,!.
mode_action(quit) :- quit,!.
mode_action(_) :- error_message,!.
	
error_message :- write('> Your input is invalid. Type "help." to see available command.'), 
		         nl,fail,!.

surrender 	  :- write('> All roads lead to Annex'),nl,halt,!.		   

% Command control loop
command_loop :- repeat,
                catch((
					write('> '),
					read(user_input,Command),
					do(Command),
		        (Command == quit)),
				error(syntax_error(_),_), 
		        (write('> Your input is invalid. Type "help." to see available command.'), 
		        nl,fail,!)).

map :- player_attributes(X),X==radar,print_map(0,0),legend,!.
map :- write('> You don''t have radar, you have to find one'),nl,!.

whats_on_north(T):-player_location(X,_),T is X-1,!.
whats_on_south(T):-player_location(X,_),T is X+1,!.
whats_on_west(T):-player_location(_,Y),T is Y-1,!.
whats_on_east(T):-player_location(_,Y),T is Y+1,!.

print_map(21,15):-!,write(' # '),nl.
print_map(X,16):-!,XX is X+1,YY is 0,nl,print_map(XX,YY).
print_map(X,Y):-player_location(X,Y),!,write(' P '), YY is Y+1,print_map(X,YY).
print_map(X,Y):-enemy_location(X,Y,_),!,write(' E '), YY is Y+1,print_map(X,YY).
print_map(X,Y):-object(X,Y,_),!,write(' T '), YY is Y+1,print_map(X,YY).
print_map(X,Y):-location(X,Y,Z),(Z == lt1;Z == lt2;Z == lt3;Z == lt4),!,write(' _ '),YY is Y+1, print_map(X,YY).
print_map(X,Y):-location(X,Y,Z),(Z == irk;Z == mulmed;Z == sekre;Z == toilet;Z == r7602;Z == perpus;Z == labpro;Z == selasar;Z == tu;Z == fotokopi;Z == vending;Z == dingdong;Z == borju),!,write(' . '),YY is Y+1, print_map(X,YY).
print_map(X,Y):-location(X,Y,Z),(Z == tangga),!,write(' = '),YY is Y+1, print_map(X,YY).
print_map(X,Y):-location(X,Y,Z),(Z == lift),!,write(' ? '),YY is Y+1, print_map(X,YY).
print_map(X,Y):-location(X,Y,Z),!,write(' '),write(Z),write(' '),YY is Y+1, print_map(X,YY).

print_around:-whats_on_north(X1),whats_on_south(X2),
			  whats_on_east(Y1),whats_on_west(Y2),
			  player_location(X,Y),location(X1,Y2,_),
			  location(X1,Y,_),location(X1,Y1,_),
			  location(X,Y2,_),location(X,Y,_),
			  location(X,Y1,_),location(X2,Y2,_),
			  location(X2,Y,_),location(X2,Y1,_),
		   	  tab(16),legend_translator(X1,Y2), legend_translator(X1,Y), legend_translator(X1,Y1),nl,
			  tab(16),legend_translator(X,Y2), legend_translator(X,Y), legend_translator(X,Y1),nl,
			  tab(16),legend_translator(X2,Y2),legend_translator(X2,Y),legend_translator(X2,Y1),nl,nl,
			  legend.

legend_translator(X,Y):- location(X,Y,_),object(X,Y,_),write(' T '),!.
legend_translator(X,Y):- location(X,Y,_),enemy_location(X,Y,_),write(' E '),!.
legend_translator(X,Y):- location(X,Y,_),player_location(X,Y),write(' P '),!.
legend_translator(X,Y):- location(X,Y,Z),(Z == lt1;Z == lt2;Z == lt3;Z == lt4),write(' _ '),!.
legend_translator(X,Y):- location(X,Y,Z),(Z == irk;Z == mulmed;Z == sekre;Z == toilet;Z == r7602;Z == perpus;Z == labpro;Z == selasar;Z == tu;Z == fotokopi;Z == vending;Z == dingdong;Z == borju),write(' . '),!.
legend_translator(X,Y):- location(X,Y,Z),(Z == tangga),!,write(' = '),!.
legend_translator(X,Y):- location(X,Y,Z),(Z=='#'),!,write(' # '),!.

is_there_enemy(X,Y) :- player_location(X,Y),enemy_location(X,Y,Z),enemy_description(Z),nl,!.
is_there_enemy(_,_).

is_there_object :- player_location(X,Y),object(X,Y,Z),write('> You''ve just found '),write(Z),nl,!.
is_there_object.

is_toilet :- player_location(X,Y),location(X,Y,Z),Z== toilet,write('> You are in a toilet, You feel refreshed'),
			 nl,increase_motivation(20),increase_consciousness(10),!.
is_toilet.

is_sleepy:-player_consciousness(X),X < 50, X > 48,nl,nl,tab(2), write(' You feel a little bit sleepy, Stay awake!'),nl,nl,!.
is_sleepy.

lose:- lose_description,halt,!.

current_status:- write('> Your consciusness now '),player_consciousness(Z),write(Z),write(' %'),nl,
				 write('> Your motivation now '),player_motivation(A),write(A),write(' %'),nl,!.

attack:-player_location(X,Y),enemy_location(X,Y,Z),Z==angel,player_attributes(shoes),player_skills(A),A >= 120,write('> You killed '),
		write(Z),nl,retract(enemy_location(X,Y,Z)),increase_skills(50),defeat(Z),!.
attack:-player_location(X,Y),enemy_location(X,Y,Z),Z==angel,
		(player_attributes(A),\+ A == shoes ; (player_skills(Q),Q < 120)),write('> You don''t use shoes or you need at least 120 skills. '),nl,
		write('> You got damaged '),random(10,20,M),increase_motivation(-M),write(M),
		increase_consciousness(-M),nl,current_status,!.
		
attack:-player_location(X,Y),enemy_location(X,Y,Z),Z== deadline,player_attributes(submission_link),player_skills(A),A >= 250,write('> You killed '),
		write(Z),nl,retract(enemy_location(X,Y,Z)),increase_skills(20),defeat(Z),win,halt,!.
attack:-player_location(X,Y),enemy_location(X,Y,Z),Z== deadline,
		(player_attributes(A),\+ A == submissionlink ; (player_skills(Q),Q < 250)) ,write('> You don''t use submission link or you need at least 250 skills. '),nl,
		write('> You got damaged '),random(20,25,M),increase_motivation(-M),increase_consciousness(-M),write(M),
		nl,!.
		
attack:-player_location(X,Y),enemy_location(X,Y,Z),Z== penjaga,player_skills(A),A >= 40,write('> You killed '),
		write(Z),write(' . It dropped a Love Letter!'),nl,retract(enemy_location(X,Y,Z)),increase_skills(20),asserta(object(X,Y,love_letter)),defeat(Z),!.
attack:-player_location(X,Y),enemy_location(X,Y,Z),Z== penjaga,
		player_skills(Q),Q < 40 ,write('> You need at least 40 skills. '),nl,
		write('> You got damaged '),random(5,15,M),increase_motivation(-M),write(M),
		nl,current_status,!.
		
attack:-player_location(X,Y),enemy_location(X,Y,Z),Z== satpam,player_attributes(money),write('> You killed '),
		write(Z),nl,retract(enemy_location(X,Y,Z)),increase_skills(40),defeat(Z),!.
attack:-player_location(X,Y),enemy_location(X,Y,Z),Z== satpam,
		player_attributes(A),\+ A == money ,write('> You don''t use money.'),nl,
		write('> You got damaged 10'),increase_consciousness(-10),nl,current_status,!.
		
attack:-player_location(X,Y),enemy_location(X,Y,Z),Z== kating,player_attributes(slayer),player_skills(A),A >= 40,write('> You killed '),
		write(Z),write(' . It dropped a LANTIK!'),nl,retract(enemy_location(X,Y,Z)),increase_skills(40),asserta(object(X,Y,lantik)),defeat(Z),!.
attack:-player_location(X,Y),enemy_location(X,Y,Z),Z== kating,
		(player_attributes(A),\+ A == slayer ; (player_skills(Q),Q < 40)),write('> You don''t use slayer or you need at least 40 skills. '),nl,
		write('> You got damaged '),random(7,10,M),increase_motivation(-M),write(M),nl,current_status,!.

attack:-player_location(X,Y),enemy_location(X,Y,Z),Z== dosen,player_attributes(innocent_face),player_skills(A),A >= 80,write('> You killed '),
		write(Z),write(' . It dropped a cheatsheet!'),nl,retract(enemy_location(X,Y,Z)),increase_skills(40),asserta(object(X,Y,cheatsheet)),defeat(Z),!.
attack:-player_location(X,Y),enemy_location(X,Y,Z),Z== dosen,
		(player_attributes(A),\+ A == innocent_face ; (player_skills(Q),Q < 80)),write('> You don''t use innocent face or you need at least 80 skills. '),nl,
		write('> You got damaged '),random(7,15,M),increase_motivation(-M),write(M),nl,current_status,!.
		
attack:-player_location(X,Y),enemy_location(X,Y,Z),Z== penunggu,player_attributes(task_paper),player_skills(A),A >= 20,write('> You killed '),
		write(Z),nl,retract(enemy_location(X,Y,Z)),increase_skills(50),defeat(Z),!.
attack:-player_location(X,Y),enemy_location(X,Y,Z),Z == penunggu,
		(player_attributes(A),\+ A == task_paper ; (player_skills(Q),Q < 20)),write('> You don''t use task paper or you need at least 20 skills. '),nl,
		write('> You got damaged '),random(5,15,M),increase_motivation(-M),write(M),nl,current_status,!.
		
attack:-player_location(X,Y),enemy_location(X,Y,Z),Z== tubes,player_attributes(laptop),player_skills(A),A >= 200,write('> You killed '),
		write(Z),nl,retract(enemy_location(X,Y,Z)),increase_skills(100),asserta(object(X,Y,submissionlink)),defeat(Z),!.
attack:-player_location(X,Y),enemy_location(X,Y,Z),Z== tubes,
		(player_attributes(A),\+ A == task_paper ; (player_skills(Q),Q < 200)),write('> You don''t use laptop or you need at least 200 skills. '),nl,
		write('> You got damaged '),random(10,20,M),increase_motivation(-M),write(M),nl,current_status,!.
		
attack:-player_location(X,Y),enemy_location(X,Y,Z),Z== madamLili,write('> You killed '),
		write(Z),write(' . It dropped a motivational quote'),nl,retract(enemy_location(X,Y,Z)),increase_skills(20),asserta(object(X,Y,motivational_quotes)),defeat(Z),!.
		
attack:-player_location(X,Y),enemy_location(X,Y,Z),Z== anak2,write('> You killed '),
		write(Z),nl,retract(enemy_location(X,Y,Z)),increase_skills(20),defeat(Z),current_status,!.
				
attack:-write('> There''s no enemy in here'),nl,!.

damaged(X,Y):-player_location(X,Y),enemy_location(X,Y,_),write('> You can''t runaway. You got damaged 10'),
			  increase_motivation(-10),nl,current_status,!.
damaged(_,_).

quit :- write('> You''ve quitted your game'),nl,halt(1),!.

list_attributes(X) :- player_attributes(X), tab(2), write(X), nl, fail; true.

status :- player_name(Player),tab(12),write(' --'),write(Player),write('''s Status-- '),nl,!,
          tab(12),write(' Skill : '),player_skills(X),write(X),write(' exp'),nl,!,
          tab(12),write(' Motivation: '),player_motivation(Y),write(Y),write('% '),nl,!,
          tab(12),write(' Consciousness: '),player_consciousness(Z),write(Z),write('% '),nl,!,
		  tab(12),write(' Attributes: '),player_attributes(A),write(A),nl.

% Player Status Handler
increase_motivation(Z) :-player_motivation(X),
						 Y is X+Z,Y>0,Y=<100,retract(player_motivation(X)),
						 asserta(player_motivation(Y)).
increase_motivation(Z) :-player_motivation(X),
						 A is X+Z,A>100,Y is 100,retract(player_motivation(X)),
						 asserta(player_motivation(Y)).
increase_motivation(Z) :-player_motivation(X),
						 A is X+Z,A<0,Y is 0,retract(player_motivation(X)),
						 asserta(player_motivation(Y)),lose.
increase_motivation(_).

increase_skills(Z) :-	player_skills(X),
						Y is X+Z,Y>0,Y=<100,retract(player_skills(X)),
						asserta(player_skills(Y)),!.
increase_skills(Z) :-player_skills(X),
						 A is X+Z,A>100,Y is 100,retract(player_skills(X)),
						 asserta(player_skills(Y)).
increase_skills(Z) :-player_skills(X),
						 A is X+Z,A<0,Y is 0,retract(player_skills(X)),
						 asserta(player_skills(Y)).
increase_skills(_).

increase_consciousness(Z) :-player_consciousness(X),
						Y is X+Z,Y=<100,retract(player_consciousness(X)),
						asserta(player_consciousness(Y)),!.
increase_consciousness(Z) :-player_consciousness(X),
						 A is X+Z,A>100,Y is 100,retract(player_consciousness(X)),
						 asserta(player_consciousness(Y)).
increase_consciousness(Z) :-player_consciousness(X),
						 A is X+Z,A<0,Y is 0,retract(player_consciousness(X)),
						 asserta(player_consciousness(Y)),lose.
increase_consciousness(_).

list_inventory(X) :-inventories(X), tab(2), write(X), nl, fail; true.

% Object Handler
take(radar):- inventories(smartphone),player_location(X,Y),damaged(X,Y),object(X,Y,C),
			  list_enemy(List_Enemy),random_movement_X(List_Enemy),
		   	  findall(A,inventories(A),List_Inventories),length(List_Inventories,Length),Length =< 5,
		   	   asserta(inventories(C)),retract(object(X,Y,C)),write('> You have installed '),write(C),write('. You can use map now'),nl,!.

take(radar):- findall(A,inventories(A),List_Inventories),length(List_Inventories,Length),Length > 5,
			  write('> Ooh, your inventory is full, you can''t bring more than 5 things'),!.
take(radar):- write('> You need smartphone to install radar ! Find one in the largest class of Labtek V'),nl,!.
take(C) :- player_location(X,Y),damaged(X,Y),object(X,Y,C),list_enemy(List_Enemy),random_movement_X(List_Enemy),
		   findall(A,inventories(A),List_Inventories),length(List_Inventories,Length),Length =< 5,
		   asserta(inventories(C)),retract(object(X,Y,C)),write('> You took '),write(C),nl,!.
take(C) :- player_location(X,Y),object(X,Y,C),
		   write('> Ooh, your inventory is full, you can''t bring more than 5 things'),nl,
		   write('> Drop some item so you can take this thing'),nl,!.
take(_) :- write('> That thing doesn''t exist here'),nl,
		   write('> Find in another place!'),nl,!.

drop(C) :- inventories(C),player_location(X,Y),damaged(X,Y),list_enemy(List_Enemy),
		   random_movement_Y(List_Enemy),retract(inventories(C)),asserta(object(X,Y,C)),write('> You''ve just dropped '),write(C),nl,!.

drop(C) :- write('> '),write(C),write(' is not in your inventory'),nl,!.

use(C) :- inventories(C),list_enemy(List_Enemy),random_movement_X(List_Enemy),
		  (C == motivational_quotes;C == perfect_score_test;C == lantik), increase_motivation(80),
		  retract(inventories(C)),
		  use_description(C),nl,!.

use(C) :- inventories(C),list_enemy(List_Enemy),random_movement_X(List_Enemy),
		  C == love_letter, increase_motivation(50),
		  retract(inventories(C)),
		  use_description(C),nl,!.

use(C) :- inventories(C),list_enemy(List_Enemy),random_movement_X(List_Enemy),
		  (C == food_voucher;C== beautiful_girl), increase_motivation(60),
		  retract(inventories(C)),
		  use_description(C),nl,!.

use(C) :- inventories(C),list_enemy(List_Enemy),random_movement_X(List_Enemy),
		  (C == water;C == bread; C==spicy_chips), increase_consciousness(50),
		  retract(inventories(C)),
		  use_description(C),nl,!.

use(C) :- inventories(C),list_enemy(List_Enemy),random_movement_X(List_Enemy),
		  C == coffee, increase_consciousness(40),
		  retract(inventories(C)),
		  use_description(C),nl,!.

use(C) :- inventories(C),list_enemy(List_Enemy),random_movement_X(List_Enemy),
		  player_attributes(X),asserta(inventories(X)),
		  retract(player_attributes(X)),
		  asserta(player_attributes(C)),
		  retract(inventories(C)),
		  use_description(C),nl,!.

use(C) :- write('> '),write(C),write(' is not in your inventory'),nl,!.

inventory :- write('   -- Objects in your inventory--  '), nl,
			 list_inventory(_); true.


% Movement Handler
check_current_location(Z) :- current_location(A),
							 \+ Z == A, !,
							 retract(current_location(A)),
							 asserta(current_location(Z)),
							 describe(Z).
check_current_location(_).	
n:- player_location(X,Y),damaged(X,Y),Z is X-1,
	location(Z,Y,A),\+ A =='#',!,
	write('> You are going north'),nl,
	retract(player_location(X,Y)),
	asserta(player_location(Z,Y)),
	is_sleepy,
	list_enemy(List_Enemy),
	random_movement_Y(List_Enemy),
	is_toilet,
	is_there_enemy(Z,Y),
	is_there_object,
	increase_consciousness(-1),
	increase_motivation(-1),
	check_current_location(A).

n:- write('> There''s wall, you can''t go there!'),nl.

s:- player_location(X,Y),damaged(X,Y),Z is X+1,
	location(Z,Y,A),\+ A == '#',!,
	write('> You are going south'),nl,
	retract(player_location(X,Y)),
	asserta(player_location(Z,Y)),
	is_sleepy,
	list_enemy(List_Enemy),
	random_movement_Y(List_Enemy),
	is_there_enemy(Z,Y),
	is_there_object,
	increase_motivation(-1),
	increase_consciousness(-1),
	check_current_location(A).

s:- write('> There''s wall, you can''t go there!'),nl.

e:- player_location(X,Y),damaged(X,Y),Z is Y+1,
	location(X,Z,A),\+ A == '#',!,
	write('> You are going east'),nl,
	retract(player_location(X,Y)),
	asserta(player_location(X,Z)),
	is_sleepy,
	list_enemy(List_Enemy),
	random_movement_X(List_Enemy),
	is_there_enemy(X,Z),
	is_there_object,
	increase_motivation(-1),
	increase_consciousness(-1),check_current_location(A).

e:- write('> There''s wall, you can''t go there!'),nl.

w:- player_location(X,Y),damaged(X,Y),Z is Y-1,
	location(X,Z,A),\+ A == '#',!,
	write('> You are going west'),nl,
	retract(player_location(X,Y)),
	asserta(player_location(X,Z)),
	is_sleepy,
	list_enemy(List_Enemy),
	random_movement_X(List_Enemy),
	random_movement_Y(List_Enemy),
	is_toilet,
	is_there_enemy(X,Z),
	is_there_object,
	increase_motivation(-1),
	increase_consciousness(-1),check_current_location(A).

w:- write('> There''s wall, you can''t go there!'),nl.

ne:-player_location(X,Y),damaged(X,Y),Z is X-1,ZZ is Y+1,
	location(Z,ZZ,A),\+ A == '#',!,
	write('> You are going northeast'),nl,
	retract(player_location(X,Y)),
	asserta(player_location(Z,ZZ)),
	is_sleepy,
	list_enemy(List_Enemy),
	random_movement_X(List_Enemy),
	random_movement_Y(List_Enemy),
	is_toilet,
	is_there_enemy(X,Z),
	is_there_object,
	increase_motivation(-1),
	increase_consciousness(-2),check_current_location(A).
ne:- write('> There''s wall, you can''t go there!'),nl.

nw:-player_location(X,Y),damaged(X,Y),Z is Y-1,ZZ is X-1,
	location(ZZ,Z,A),\+ A == '#',!,
	write('> You are going northwest'),nl,
	retract(player_location(X,Y)),
	asserta(player_location(ZZ,Z)),
	is_sleepy,
	list_enemy(List_Enemy),
	random_movement_X(List_Enemy),
	random_movement_Y(List_Enemy),
	is_toilet,
	is_there_enemy(X,Z),
	is_there_object,
	increase_motivation(-1),
	increase_consciousness(-1),check_current_location(A).

nw :- write('> There''s wall, you can''t go there!'),nl.

se:-player_location(X,Y),damaged(X,Y),Z is Y+1,ZZ is X+1,
	location(ZZ,Z,A),\+ A == '#',!,
	write('> You are going southeast'),nl,
	retract(player_location(X,Y)),
	asserta(player_location(ZZ,Z)),
	is_sleepy,
	list_enemy(List_Enemy),
	random_movement_X(List_Enemy),
	random_movement_Y(List_Enemy),
	is_toilet,
	is_there_enemy(X,Z),
	is_there_object,
	increase_motivation(-1),
	increase_consciousness(-1),check_current_location(A).

se :- write('> There''s wall, you can''t go there!'),nl.

sw:-player_location(X,Y),damaged(X,Y),Z is Y-1,ZZ is X+1,
	location(ZZ,Z,A),\+ A == '#',!,
	write('> You are going southwest'),nl,
	retract(player_location(X,Y)),
	asserta(player_location(ZZ,Z)),
	is_sleepy,
	list_enemy(List_Enemy),
	random_movement_X(List_Enemy),
	random_movement_Y(List_Enemy),
	is_toilet,
	is_there_enemy(X,Z),
	is_there_object,
	increase_motivation(-1),
	increase_consciousness(-1),check_current_location(A).

sw :-write('> There''s wall, you can''t go there!'),nl.

% Enemy Movement Handler
list_enemy(Z):- findall((X,Y),enemy_location(X,Y,_),Z),!.

random_movement_X([]):-!.
random_movement_X([(X,Y)|Xs]):-random(-1,2,A),XX is X+A,\+ A==0,is_there_enemy(XX,Y),
							location(XX,Y,Z),\+ Z == '#',
							retract(enemy_location(X,Y,E)),
							assertz(enemy_location(XX,Y,E)),
							random_movement_X(Xs),!.
random_movement_X([(X,Y)|Xs]):-random(-1,2,A),XX is X+A,
							location(XX,Y,Z),\+ Z == '#',
							retract(enemy_location(X,Y,E)),
							assertz(enemy_location(XX,Y,E)),
							random_movement_X(Xs),!.
random_movement_X([_|_]).

random_movement_Y([]):-!.
random_movement_Y([(X,Y)|Xs]):-random(-1,2,A),YY is Y+A,\+ A==0,is_there_enemy(X,YY),
							location(X,YY,Z),\+ Z == '#',
							retract(enemy_location(X,Y,E)),
							assertz(enemy_location(X,YY,E)),
							random_movement_Y(Xs),!.
random_movement_Y([(X,Y)|Xs]):-random(-1,2,A),YY is Y+A,
							location(X,YY,Z),\+ Z == '#',
							retract(enemy_location(X,Y,E)),
							assertz(enemy_location(X,YY,E)),
							random_movement_Y(Xs),!.
random_movement_Y([_|_]).

inspect(Object):- (Object==perfect_score_test;Object==lantik),((player_location(X,Y),object(X,Y,Object));inventories(Object)),write('> '),write(Object),
				  write(' can be used to increase your motivation by 80%'),nl,!.
inspect(Object):- Object==food_voucher,((player_location(X,Y),object(X,Y,Object));inventories(Object)),write('> '),write(Object),
				  write(' can be used to increase your motivation by 80%'),nl,!.
inspect(Object):- Object==love_letter,((player_location(X,Y),object(X,Y,Object));inventories(Object)),write('> '),write(Object),
				  write(' can be used to increase your motivation by 80%'),nl,!.
inspect(Object):- (Object==spicy_chips;Object==bread;Object==water),((player_location(X,Y),object(X,Y,Object));inventories(Object)),write('> '),write(Object),
				  write(' can be used to increase your consciousness by 50%'),nl,!.
inspect(Object):- Object==coffee,((player_location(X,Y),object(X,Y,Object));inventories(Object)),write('> '),write(Object),
				  write(' can be used to increase your consciousness by 40%'),nl,!.
inspect(Object):- Object==code,((player_location(X,Y),object(X,Y,Object));inventories(Object)),write('> '),write(Object),
				  write(' can be used to increase your skills by 20 Exp'),nl,!.
inspect(Object):- Object==cheatsheet,((player_location(X,Y),object(X,Y,Object));inventories(Object)),write('> '),write(Object),
				  write(' can be used to increase your skills by 40 Exp'),nl,!.
inspect(Object):- Object==smartphone,((player_location(X,Y),object(X,Y,Object));inventories(Object)),write('> '),write(Object),
				  write(' can be used to install map if you have find radar'),nl,!.
inspect(Object):- Object==radar,((player_location(X,Y),object(X,Y,Object));inventories(Object)),write('> '),write(Object),
				  write(' can be used to see Labtek V map'),nl,!.
inspect(_):- write('> This thing doesn''t exist neither in your inventories nor here'),nl.

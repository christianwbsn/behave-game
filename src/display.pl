/*Dynamic Variable*/
:- dynamic(player_name/1).
:- dynamic(player_skills/1).
:- dynamic(player_drowsiness/1).
:- dynamic(player_motivation/1).
:- dynamic(inventories/1).

player_name(unnamed).
player_skills(20).
player_motivation(100).
player_drowsiness(100).
inventories([smartphones,shoes,key]).

/* Display */

title :- write('     _____                                     '),nl,
		 write('  __|___  |__ ______ __   _ ____ __    _______ '),nl,
		 write(' |      >    |   ___|  |_| |    \\  \\  /|   ___|'),nl,
		 write(' |     <     |   ___|   _  |     \\  \\//|   ___|'),nl,
		 write(' |______>  __|______|__| |_|__|\\__\\__/ |______|'),nl,
		 write('    |_____|                                    '),nl,
		 write('            Copyright C++ K-03 IF2016         '),nl,
		 write('               All Right Reserved         '),nl.

credits :- write(' Created by C++ Team K-03 IF2016'),nl,
		  write(' 13516024 - Jason Wiguna'),nl,
		  write(' 13516102 - Steven Sukma Limanus'),nl,
		  write(' 13516117 - Eric Jonathan'),nl,
		  write(' 13516147 - Christian Wibisono'),nl.

about :- write('Behave is survival-adventure game created by C++ Team'),nl,
		 write('Your goal is to fight all enemies and finish your journey'),nl,nl.

player_data :- write('Insert name [Use '' '']: '),
			   read(Player),
		       retract(player_name(N)),
		       asserta(player_name(Player)),
		       write('Welcome to Behave, '),write(Player), write(' !'),nl,!.

start :- title,
		 about,
		 player_data,
		 instructions,!,
		 command_loop.
		 
instructions :- write('Here is the list of commands that you can use for this game'), nl,
	tab(2), write('n.                           go to north'), nl,
	tab(2), write('e.                           go to east'), nl,
	tab(2), write('w.                           go to west'), nl,
	tab(2), write('s.                           go to south'), nl,
	tab(2), write('look.                        look around'), nl,
	tab(2), write('status.                      to see your status'), nl,
	tab(2), write('inventory.                   check your belongings'), nl,
	tab(2), write('save <name>.                 to save your progress using filename "name"'), nl,
	tab(2), write('load <name>.                 to load your progress using filename "name"'), nl,
	tab(2), write('inspect <something>.         ex: inspect soup'), nl,
	tab(2), write('check <something>.           ex: check bed'), nl,
	tab(2), write('take <something>.            ex: take gold'), nl,
	tab(2), write('drop <something>.            ex: drop clothes'), nl,
	tab(2), write('use <something>.             ex: use clothes'), nl,
	tab(2), write('credits.                     show the credits'), nl,
	tab(2), write('quit.                        exit from game'), nl, nl,
	write('Use '' '' if you use more than 1 word, ex: take ''dog food''.'), nl,nl.
	
/* Command */

	do(inspect(X)):- inspect(X),!.
	do(use(X)):- use(X),!.
	do(move(X)):- move(X),!.
	do(take(X)):- take(X),!.
	do(drop(X)):- drop(X),!.
	do(inventory):- inventory,!.
	do(look):- look,!.
	do(motivation):- motivation,!.
	do(instructions):- instructions,!.
	do(status) :- status, !.
	do(n):- n,!.
	do(s):- s,!.
	do(w):- w,!.
	do(e):- e,!.
	do(quit) :- quit, !.
	do(save(X)) :- save(X),!.
	do(load(X)) :- loads(X), !.
	do(credits) :- credits, !.
	do(_) :- error_message.

error_message :- write('Your input is invalid. Type "instructions." for help.'), 
		         nl, fail, !.
		   
command_loop :- repeat,
                catch((
		        write('> '),
		        read(Command),
		        do(Command),
		        (Command == quit)),
		        error(syntax_error(_),_), 
		        (write('> Your input is invalid. Type "instructions." for help.'), 
		        nl, fail, !)).

status :- player_name(Player),write(' --'),write(Player),write('''s Status-- '),nl,
          write('> Skill : '),player_skills(X),write(X),write(' exp'),nl,
          write('> Motivation: '),player_motivation(Y),write(Y),write('% '),nl,
          write('> Drowsiness: '),player_drowsiness(Z),write(Z),write('% '),nl,!.

motivation :- write('> Ayo kita semangat!'),nl,player_motivation(X),X<100,!,
			  Y is X+20,retract(player_motivation(X)),
			  asserta(player_motivation(Y)),!.
motivation.

inventory :- findall(X,inventories(X),Inventory),
	         write('Inventory: '),
	         write(Inventory),nl,!.

/* Room List */

	

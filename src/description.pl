% Game Title & Introduction Display
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

help :- write('Here is the list of commands that you can use for this game'), nl,
	tab(2), write('n.                         -- go to north'), nl,
	tab(2), write('e.                         -- go to east'), nl,
	tab(2), write('w.                         -- go to west'), nl,
	tab(2), write('s.                         -- go to south'), nl,
	tab(2), write('ne.                        -- go to northeast'), nl,
	tab(2), write('se.                        -- go to southeast'), nl,
	tab(2), write('nw.                        -- go to northwest'), nl,
	tab(2), write('sw.                        -- go to southwest'), nl,
	tab(2), write('look.                      -- look around'), nl,
	tab(2), write('map.                       -- show map'), nl,
	tab(2), write('status.                    -- to see your status'), nl,
	tab(2), write('attack.                    -- attack enemy'), nl,
	tab(2), write('inventory.                 -- check your belongings'), nl,
	tab(2), write('save(filename).            -- to save '), nl,
	tab(2), write('inspect(something).        -- ex: inspect(water).'), nl,
	tab(2), write('take(something).           -- ex: take(water).'), nl,
	tab(2), write('drop(something).           -- ex: drop(water)'), nl,
	tab(2), write('use(something).            -- ex: use(water).'), nl,
	tab(2), write('surrender.                 -- to give up'), nl,
	tab(2), write('credits.                   -- show the credits'), nl,
	tab(2), write('quit.                      -- quit from game'), nl, nl.

about :- write('Behave is survival-adventure game created by C++ Team'),nl,
		 write('Your goal is to fight the deadline and finish your journey at Labtek V'),nl,
		 tab(6),write('----You have to behave to be saved----'),nl,nl.

% Legend for Map
legend :- tab(12),write('     --LEGEND--      '),nl,
		  tab(12),write('P          : player'),nl,
		  tab(12),write('E          : enemy'),nl,
		  tab(12),write('T          : tools/object'),nl,
		  tab(12),write('#          : fence'),nl,
		  tab(12),write('_          : floor'),nl,
		  tab(12),write('.          : room'),nl,
		  tab(12),write('=          : stairs'),nl,!.

/* Description for each room */
describe(mulmed) :- write(''),nl,
					tab(2),write('You are in the Multimedia room. You see a water tap nearby. It is said that'),nl,
					tab(2),write('you can find a multipurpose laptop in this room.'),
			        write(''),nl,nl.
			     
describe(irk) :- 	write(''),nl,
					tab(2),write('You are in the IRK room. Rumor has it that if you kill the shadow residing in this room,'),nl,
					tab(2),write('you can find motivational quotes to lift up your spirit.'),
					write(''),nl,nl.
					
describe(sekre) :- 	write(''),nl,
					tab(2),write('You are in the Sekre. You can see someone waiting at the corner of the room.'),nl,
					tab(2),write('Maybe you can talk to him.'),
					write(''),nl,nl.

describe(r7602) :- 	write(''),nl,
					tab(2),write('You are in 7602. You can sense a killing presence. Your friend left his phone here yesterday.'),nl,
					tab(2),write('You can keep it for him today.'),
					write(''),nl,nl.
					
describe(perpus) :- write(''),nl,
					tab(2),write('You are in the Library. There is a Tab on display. The security guard seems to have an extra shirt.'),
					write(''),nl,nl.
					
describe(labpro) :- write(''),nl,
					tab(2),write('You are in the Programming Lab. You can train your innocent face here. Someone who resembles an angel'),nl,
					tab(2),write('is looking at you. Maybe you can try to impress her.'),
					write(''),nl,nl.
					
describe(selasar) :- write(''),nl,
					 tab(2),write('You are in the Selasar Labtek. There is a strong signal coming from somewhere...'),
					 write(''),nl,nl.
					
describe(tu) :- write(''),nl,
				tab(2),write('You are in the TU. There is nothing special here.'),
				write(''),nl,nl.
					
describe(dingdong) :- write(''),nl,
					  tab(2),write('You are at Dingdong. There is something sticking out under the table.'),nl,
					  tab(2),write('A hostile presence is coming from the neighborhood.'),
					  write(''),nl,nl.
					
describe(fotokopi) :- write(''),nl,
					  tab(2),write('You are in the Photocopy room. People come here to copy their task papers.'),nl,
					  tab(2),write('There is a kid running around you. Maybe he wants your attention.'),
					  write(''),nl,nl.
					
describe(borju) :- write(''),nl,
				   tab(2),write('You are at the Canteen. This place is famous for its spicy chips.'),
				   write(''),nl,nl.
					
describe(vending) :- write(''),nl,
					 write('You are at the Vending Machine. Various drinks are in stock.'),nl,
					 write('You feel like buying some coffee.'),
					 write(''),nl,nl.
					 
describe(lt1) :- nl,tab(2),write('First floor...'),nl,nl.

describe(lt2) :- nl,tab(2),write('Second floor... You can find a radar in this floor.'),nl,
				nl,tab(2),write('You better wear your shirt and shoes now.'),nl,nl.

describe(lt3) :- nl,tab(2),write('Third floor...'),nl,nl.

describe(lt4) :- nl,tab(2),write('Fourth floor...'),nl,nl.

describe(tangga) :- nl,tab(2),write('Stairs...'),nl,nl.

describe(lift) :- nl,tab(2),write('Lift...'),nl,nl.

/*Introduction to game */
/*Penjelasan story awal game*/
intro:- write(''),nl,
		tab(2),write('Welcome to Labtek V! You have 4 years to finish your course while keeping your motivation up.'),nl,
		tab(2),write('During your adventure, you will find many obstacles that kill your motivation.'),nl,
		tab(2),write('But do not fret, for you can overcome your enemies by collecting attires to fight them.'),nl,
		tab(2),write('Good luck on your quest to find happiness in your studies! :)'),
		tab(2),write(''),nl.


/*Win Description */
/*Congratulate the winner */

win :- write(''),nl,
	   tab(2),write('Congratulations! You have cleared every single obstacle in Labtek V.'),nl,
	   tab(2),write('Now that you have proven yourself by getting your degree, you can choose to continue on'),nl,
	   tab(2),write('to pursue your Masters degree, or to become a slave to the marketplace.'),
	   tab(2),write(''),nl.
	   
/*Lose Description */
/*Notify the loser */

lose_description :- write(''),nl,
					write('> You have run out of motivation. Try to manage your stress better next time. :('),
	    			write(''),nl.
	    
/*Using Object Description*/
			 
use_description(motivational_quotes):-tab(2),write(''),nl,
						  tab(2),write('"tagnames atik oya oyA"'),nl,
						  tab(2),write('Somehow you feel motivated.'),
						  tab(2),write(''),nl.
			 
use_description(love_letter):-tab(2),write(''),nl,
				  tab(2),write('You have used love letter.'),nl,
				  tab(2),write('You feel motivated.'),
				  tab(2),write(''),nl.

use_description(perfect_score_test) :-tab(2),write(''),nl,
						  tab(2),write('You have used perfect score test.'),nl,
						  tab(2),write('You feel motivated.'),
						  tab(2),write(''),nl.
		
use_description(food_voucher):-tab(2),write(''),nl,
				   tab(2),write('You have used food voucher.'),nl,
				   tab(2),write('You feel motivated.'),
				   tab(2),write(''),nl.

use_description(beautiful_girl):-tab(2),write(''),nl,
				     tab(2),write('You have seen beautiful girl.'),nl,
				     tab(2),write('You feel motivated.'),
				     tab(2),write(''),nl.

use_description(lantik):-tab(2),write(''),nl,
			 tab(2),write('You have used lantik.'),nl,
		     tab(2),write('You feel motivated.'),
		     tab(2),write(''),nl.

use_description(water) :-tab(2),write(''),nl,
			 tab(2),write('You have used water.'),nl,
			 tab(2),write('You feel more conscious.'),
			 tab(2),write(''),nl.

use_description(coffee) :-tab(2),write(''),nl,
			  tab(2),write('You have used coffee.'),nl,
			  tab(2),write('You feel more conscious.'),
			  tab(2),write(''),nl.
				   
use_description(bread) :-tab(2),write(''),nl,
			 tab(2),write('You have used bread.'),nl,
			 tab(2),write('You feel more conscious.'),
			 tab(2),write(''),nl.

use_description(spicy_chips) :-tab(2),write(''),nl,
					write('You have used spicy chips.'),nl,
					write('You feel more conscious.'),
					write(''),nl.

use_description(shoes) :-tab(2),write(''),nl,
			 tab(2),write('You equipped shoes.'),nl,
			 tab(2),write('Maybe you can see an angel now?'),
			 tab(2),write(''),nl.

use_description(laptop) :-tab(2),write(''),nl,
			  tab(2),write('You have used your laptop.'),nl,
		      tab(2),write('Prepare for a fight!'),
		      tab(2),write(''),nl.

use_description(slayer) :-tab(2),write(''),nl,
			  tab(2),write('You equipped slayer.'),nl,
			  tab(2),write('Prepare for a fight!'),
			  tab(2),write(''),nl.

use_description(submission_link) :-tab(2),write(''),nl,
						write('You used submission link.'),nl,
						write('Prepare for a fight!'),
						write(''),nl.

use_description(innocent_face) :-tab(2),write(''),nl,
					 tab(2),write('You have used innocent face.'),nl,
					 tab(2),write('Prepare for a fight!'),
					 tab(2),write(''),nl.

use_description(money) :-tab(2),write(''),nl,
			 tab(2),write('You have used money.'),nl,
			 tab(2),write('Prepare for a fight!'),
			 tab(2),write(''),nl.

use_description(task_paper) :-tab(2),write(''),nl,
				  tab(2),write('You have used task paper.'),nl,
				  tab(2),write('Prepare for a fight!'),
				  tab(2),write(''),nl.

use_description(fist) :-tab(2),write(''),nl,
			tab(2),write('Prepare for a fight!'),
			tab(2),write(''),nl.

use_description(code) :-tab(2),write(''),nl,
			tab(2),write('You have used code.'),nl,
			tab(2),write('You feel more skillful.'),
			tab(2),write(''),nl.

use_description(cheatsheet) :-tab(2),write(''),nl,
				  tab(2),write('You have used cheatsheet.'),nl,
				  tab(2),write('You feel more skillful.'),
				  tab(2),write(''),nl.

use_description(phone):-tab(2),write(''),nl,
			tab(2),write('You have used your phone.'),nl,
			tab(2),write('You can now use radar if you have one.'),
			tab(2),write(''),nl.

use_description(radar) :-tab(2),write(''),nl,
			 tab(2),write('You equipped radar.'),nl,
			 tab(2),write('You can see better now.'),
			 tab(2),write(''),nl.

use_description(tab) :-tab(2),write(''),nl,
		   tab(2),write('You have used your tab.'),nl,
		   tab(2),write('Prepare for a fight!'),
		   tab(2),write(''),nl.

use_description(shirt) :-tab(2),write(''),nl,
			 tab(2),write('You equipped shirt.'),nl,
			 tab(2),write('Maybe you can see an angel now?'),
			 tab(2),write(''),nl.
			   
/*Talk to enemy*/
/*Conversation when meet enemy */

enemy_description(madamLili) :- write(''),nl,
				   tab(2),write('A shadow approaches. You cannot get her out of your mind.'),nl,
				   tab(2),write('You deciced to fight her.'),
				   tab(2),write(''),nl.

enemy_description(penunggu) :- write(''),nl,
						tab(2),write('You encountered penunggu sekre. He would not budge.'),nl,
						tab(2),write('You deciced to fight him.'),
						tab(2),write(''),nl.

enemy_description(anak2) :- write(''),nl,
				   tab(2),write('You encountered children. They keep on pestering you.'),nl,
				   tab(2),write('You deciced to fight them.'),
				   tab(2),write(''),nl.

enemy_description(penjaga) :- write(''),nl,
						 tab(2),write('You encountered penjaga perpus. He asked you to be quiet.'),nl,
						 tab(2),write('You deciced to fight him.'),
						 tab(2),write(''),nl.

enemy_description(satpam) :- write(''),nl,
				 tab(2),write('You encountered satpam. He seems to need some money.'),nl,
				 tab(2),write('You deciced to fight him.'),
				 tab(2),write(''),nl.

enemy_description(kating) :- write(''),nl,
				 tab(2),write('You encountered kating. Where is your slayer?'),nl,
				 tab(2),write('You deciced to fight him.'),
				 tab(2),write(''),nl.

enemy_description(dosen) :- write(''),nl,
					   tab(2),write('You encountered dosen killer. You cannot stand his killing presence.'),nl,
					   tab(2),write('You deciced to fight him.'),
					   tab(2),write(''),nl.

enemy_description(angel) :- write(''),nl,
				tab(2),write('An angel approaches. She seems angry.'),nl,
				tab(2),write('ANGEL: WEAR YOUR SHOES! WEAR YOUR SHIRT! DONT PLAY WITH YOUR PHONE!'),nl,
				tab(2),write('You deciced to fight her.'),
			    tab(2),write(''),nl.

enemy_description(tubes) :- write(''),nl,
				   tab(2),write('The ultimate tubes has appeared!!! You have to use everything you have learned to defeat it.'),nl,
				   tab(2),write('You deciced to fight it.'),
				   write(''),nl.
				   
enemy_description(deadline) :- write(''),nl,
				   tab(2),write('The legendary deadline has come close!!! The time has come to test everything in this one chance.'),nl,
				   tab(2),write('You deciced to fight it.'),
				   write(''),nl.

defeat(madamLili) :- write(''),nl,
				    tab(2),write('Congratulations, you have defeated the shadow.'),nl,
				    tab(2),write('You can now sleep in peace.'),
				    tab(2),write(''),nl.
defeat(tubes) :- write(''),nl,
				 tab(2),write('Congratulations, you have conquered tubes.'),nl,
				 tab(2),write('Deadline is near, beware.'),
				 tab(2),write(''),nl.
				    
defeat(deadline) :- write(''),nl,
				    tab(2),write('Congratulations, you have passed the deadline.'),
				    write(''),nl.

defeat(penunggu) :- write(''),nl,
						 tab(2),write('Congratulations, you have defeated penjaga sekre.'),nl,
						 tab(2),write('The room feels different without him.'),
						 tab(2),write(''),nl.

defeat(anak2) :- write(''),nl,
				   tab(2), write('Congratulations, you have defeated the children.'),nl,
				    tab(2),write('Peace and quiet have returned.'),
				    write(''),nl.

defeat(penjaga) :- write(''),nl,
						  tab(2),write('Congratulations, you have defeated penjaga perpus.'),nl,
						  tab(2),write('You can do whatever you want now.'),
						  write(''),nl.

defeat(satpam) :- write(''),nl,
				 tab(2), write('Congratulations, you have defeated the satpam.'),nl,
				  tab(2),write('Everyone can use extra cash.'),
				  tab(2),write(''),nl.

defeat(kating) :- tab(2),write(''),nl,
				  tab(2),write('Congratulations, you have defeated kating.'),nl,
				  tab(2),write('You feel liberated.'),
				  write(''),nl.

defeat(dosen) :- write(''),nl,
				 tab(2),write('Congratulations, you have defeated dosen killer.'),nl,
				 tab(2),write('You did well.'),
				 write(''),nl.

defeat(angel) :- write(''),nl,
				 tab(2),write('Congratulations, you have defeated angel.'),nl,
				 tab(2),write('Its a good thing you wear all the complete attire.'),
				 write(''),nl.

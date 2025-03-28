--$Name:Прочь$
--$Version: 2.11$
--$Author: Тимофей Усиков$
require "parser/mp-ru"
-- mp.errhints = false
game.dsc = [["ПРОЧЬ"    автор: Тимофей Усиков    (игра выполнена на платформе INSTEAD)]]

--"бочка";

room {
	-"полянка,поляна|поле";
	nam = "place";
	title = "Полянка";
	dsc = "Ты на полянке. На севере расположился штабик твоих друзей. На востоке - свалка. На юге - стройка. На западе - лес.";
	e_to = 'trash';
	w_to = 'forest';
	n_to = 'base';
	s_to = 'build';
	u_to = function()
		p "Да! Только для этого нужно средство перемещения.";
	end;
}

room {
	-"свалка|вещи|мусор";
	nam = "trash";
	title = "Свалка";
	dsc = "В отживших своё вещах таится прошлое. Навечно недоговоренное.";
	w_to = 'place';
	u_to = function()
		p "Да! Только для этого нужно средство перемещения.";
	end;
	cant_go = "Единственный путь ведет на запад.";
	obj = { 'con' };
}

room {
	-"леc,лесок";
	nam = "forest";
	title = "Лес";
	e_to = 'place';
	u_to = function()
		p "Да! Только для этого нужно средство перемещения.";
	end;
	cant_go = "Единственный путь ведет на восток.";
  	dsc = "Всегда удивляет, как иногда здесь можно найти вещь, совершенно несоответствующую месту - оставленную людьми.";
	obj = { 'barrel' };
}

room {
	-"стройка,площадка,стройплощадка";
	nam = "build";
	title = "Стройка";
	dsc = "Построили только подвал, вход в который заколочен. Зато сверху образовалась примечательная бетонная площадка, нагретая солнцем. На ней ты и стоишь.";
	n_to = 'place';
	u_to = function()
		p "Да! Только для этого нужно средство перемещения.";
	end;
	cant_go = "Единственный путь ведет на север.";
}

room {
	-"штабик,штаб|база|сарай";
	nam = "base";
	title = "Штабик";
	dsc = "Это просто маленький деревянный сарай.";
	s_to = 'place';
	u_to = function()
		p "Да! Только для этого нужно средство перемещения.";
	end;
	cant_go = "Единственный путь ведет на юг.";
	out_to = 'place';
	obj = { 'freinds' };
}

obj {
	word = 'бочка';
	nam = 'barrel';
	title = 'Бочка';
	description = "Ржавая бочка, испещрённая дырами. В неё можно залезть, её можно взять.";
	inside_dsc = "Здесь прохладно и одиноко.";
	["before_Push,Pull,Transfer"] = function()
		_'barrel':move('build');
		walk 'build';
		p "Играя с бочкой, ты оказался на стройке."
	end;
	before_Receive = function(s)
		if mp.xevent == 'PutOn' then
			if here()^'build' then
				walk 'end';
			else
				p "Нужно ещё сделать это на стартовой площадке.";
			end;
		else
			return false;
		end;
	end;		
}:attr 'enterable,container,open';


obj {
	-"конус|шашка";
	nam = 'con';
	description = "Помятый грязный пластиковый конус для дорожной разметки.";
}

obj {
	-"подвал";
	nam = "cellar";
	found_in = 'build';
}:attr 'scenery';

obj {
	-"друзья";
	nam = 'freinds';
	description = "Друзья не обращают на тебя внимания.";	
	before_Attack = "А драться ты боишься!";
}: attr 'live';

gameover {
	nam = 'end';
	title = "Конец";
	dsc = [[Ракета готова к запуску. Теперь ты можешь покинуть эту планету.]];
}

function init()
	pl.room = 'place';
	pl.description = "Тебя так много, что некуда деться.";
end
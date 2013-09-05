Как использовать:
	Вставляем в какой-нибудь спрайт FocusKeeper:
		
		var fc:FocusKeeper = new FocusKeeper();
	
	Ассоциируем его с каким-нибудь Input-ом:
		
		var inp:Input = new Input();
		fc.keep(inp);
		
	Готово! Снимаем показания:
		
		trace(inp.up)
		trace(inp.down)
		trace(inp.left)
		trace(inp.right)
%declaracion de librerias para la interfaz

:-use_module(library(pce)).
:-use_module(library(pce_style_item)).
%

iniciar:-

	new(Menu, dialog('Adopción de mascotas', size(1000,800))),
	new(L,label(nombre,'SISTEMA DE CONSULTA DE ADOPCIÓN CANINO.')),
	new(@respl,label(nombre,'')),
	new(Can,button('cancelar',and(message(Menu, destroy),message(Menu,free)))),
	new(@boton,button('Cuestionario.',message(@prolog,botones))),
	new(@texto,label(nombre,'Responda el siguiente.')),
	send(Menu,append(L)),new(@btncarrera,button('Diagnostico?')),
	send(Menu,display,L,point(60,20)),
	send(Menu,display,@boton,point(100,100)),
	send(Menu,display,Can,point(190,200)),
	send(Menu,display,@respl,point(20,90)),
	send(Menu,display,@texto,point(20,80)),
	send(Menu,open_centered).

resultado('USTED PUEDE ADOPTAR A :
	lobo Gris.Galgo español.Braco Aleman.
        Setter Inglés.Alanos españoles.El pointer.
	'):-caseria,!.

resultado(' USTED PUEDE ADOPTAR A UN:
       El Chihuahua.,El Pug.,El labrador.
El french.,Los daltmatas.,Maltés.,Schnauzer.
       '):-trabajador,!.

resultado(' USTED PUEDE ADOPTAR A:
Ellabrador.,Golden retriever.y Pastor alemán.

         '):-asistente,!.

resultado('
	USTED PUEDE ADOPTAR:
	Pastor Alemán.,Viejo Pastor Inglés.,Pastor
Ovejero australiano.,Pastor Catalán.
Border Collie.,Pastor de Brie. y Pastor Belga.'):-pastor,!.

resultado('sin resultados, lo sentimos.').

% preguntas para poder identificar, su resultado.
caseria:- caza,
	pregunta('Busca un perro con energia?'),
	pregunta('Quiere un perro trabajdor?'),
	pregunta('Quiere un perro con excelente olfato ?');
	pregunta('Busca un perro que sea obediente?');
	pregunta('vive en un lugar de caza?');
        pregunta('Se pasa el tiempo,cazando? ').

trabajador:- trabaja,
        pregunta('tienes niños? '),
	pregunta('quieres un cachoro?'),
	pregunta('buscas un perro paciente?');
	pregunta('quieres un perro amable?').
asistente:- asistencia,
	pregunta('Es para usted la mascota?'),
	pregunta('Quiere un perro guia?'),
	pregunta('Le gustaria, un perro entrenado?'),
	pregunta('Busca un pero audaz?').
pastor:- pastoreo,
	pregunta('busca un perro que conctrole una manada?'),
	pregunta('quiere que sea agil.?'),
	pregunta('busca un perro que sea un guardia').

caza:-pregunta('eres un cazador caza?'),!.
trabaja:-pregunta('quiere una mascota?'),!.
asistencia:-pregunta('tiene alguna discapacidad?'),!.
pastoreo:-pregunta('eres un pastor?'),!.

:-dynamic si/1,no/1.
preguntar(Problema):- new(Di,dialog('Estas serian las sugerencias de adopción')),
     new(L2,label(texto,'Responde las siguientes preguntas')),
     new(La,label(prob,Problema)),
     new(B1,button(si,and(message(Di,return,si)))),
     new(B2,button(no,and(message(Di,return,no)))),

         send(Di,append(L2)),
	 send(Di,append(La)),
	 send(Di,append(B1)),
	 send(Di,append(B2)),

	 send(Di,default_button,si),
	 send(Di,open_centered),get(Di,confirm,Answer),
	 write(Answer),send(Di,destroy),
	 ((Answer==si)->assert(si(Problema));
	 assert(no(Problema)),fail).

pregunta(S):-(si(S)->true; (no(S)->fail; preguntar(S))).
limpiar :- retract(si(_)),fail.
limpiar :- retract(no(_)),fail.
limpiar.

botones :- lim,
	send(@boton,free),
	send(@btncarrera,free),
	resultado(Falla),
	send(@texto,selection(' ')),
	send(@respl,selection(Falla)),
	new(@boton,button('inicia procedimiento de adopción',message(@prolog,botones))),
        send(Menu,display,@boton,point(40,50)),
        send(Menu,display,@btncarrera,point(20,50)),
limpiar.
lim :- send(@respl, selection('')).

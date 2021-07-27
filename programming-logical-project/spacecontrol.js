	//nave
	var xj=400;
	var yj=500;
	var quantimg1=6
	var gifnave=[]
	var k
	var sprite=1
	var time=0
	var animeSpeed=1
	
	//itens
	var xo = 900;
	var yo= 0;
	
	//tirosdanave
	var yTiros = [];  
	var tirosAtivos = []; 
	var qtTiros =  20;
	var xd = [];
	var tempoTiro = -1; 

	//imagens
	var nave;
	var tiro;
	var asteroide1;
	var asteroide2;
	var itemvida;
	var gameover;
	var telawin;
	var naveboss;
	
	//sons
	var telainicial;
	var fundomusical;
	var somexplosao;
	var fundogameover;
	var somdetiro;
	var fundowin;
	
	//explosao
	var explosao = [];
	var conti = 0;
	var xe = 0;
	var ye = 0;
	var gx = 0;
	var gy = 0;
	var xe2 = 0;
	var ye2 = 0;
	var gx2 = 0;
	var gy2 = 0;		
	var sprite2=1;
	var animeSpeed2=100;
	var time2=1;
	
	//Score
	var vida = 100;
	var vidamax = 100;
	var dvida = 25;
	var barradevida = 60;
	var pontos = 0;
	var nivel = 1;
	var avida = 25;
	var dvida2 = 50;
	
	//telas de jogo
	var teladejogo=0
	var cont=0
	
	//estrelas
	var estrelasX = [];
	var estrelasY = [];
	var estrelasVel = [];
	var estrelasTam = [];    
	var qtEstrelas = 40; 
	
	//asteroides
	var iX=[];
	var iY=[];
	var iVel=[];
	var iTam= [];
	var qtI= 7;
	
	var iX2=[];
	var iY2=[];
	var iVel2=[];
	var iTam2= [];
	var qtI2= 3;

	var xa = 0;
	var ya = 0;
	var vidaa = 20;
	var dvidaa = 1;
	
	//Boss
	var gifboss=[]
	var time3=0;
	var sprite3=1;
	var animeSpeed3=1;
	var xb = 350;
	var yb = -100;
	var vb = 5;
	var contb = 0;
	var borda = false;
  
	//Tiro Boss
	var xtb = [];
	var ytb = [];
	var qtb = 2;
	var vtb = 10;
	var vidab = 1000;
	var vidabmax = 1000;
	var dvidaboss = 50;
	var barradevidab = 400;
	var ybarra = -100;  
	
	function preload(){
		tiro= loadImage('images/bullet.png');
		tiroboss= loadImage('images/bullet2.png');
		asteroide1= loadImage('images/asteroide1.png');
		asteroide2= loadImage('images/asteroide2.png');
		itemvida= loadImage('images/vida.png');
		inicio= loadImage('images/inicio.png');
		gameover= loadImage('images/gameover.png');
		fundo = loadImage('images/fundo.png');
		telawin= loadImage('images/win.png');
		
		fundomusical= loadSound('sounds/fundomusical.mp3');
		fundogameover= loadSound('sounds/gameover.mp3');
		fundowin= loadSound('sounds/win.mp3');
		//somdetiro= loadSound('sounds/tiro.mp3');
		somexplosao= loadSound('sounds/explosao.wav');

		for(i=1; i<18;i++){
		explosao[i]= loadImage('images/explosion2('+i+').png');
		}
		
		for(b=1; b<9; b++){
		gifboss[b]= loadImage('images/b('+b+').png');
		}
		
		for(k=1; k<quantimg1; k++){
		gifnave[k]= loadImage('images/'+k+'.png');
		}
	}

	function setup() {
		createCanvas(800, 600);
  
	//estrelas
		for (i = 0; i < qtEstrelas; i++) {
			estrelasX[i] = random(0,width);
			estrelasY[i] = random(0,height); 
			estrelasVel[i] = 2+random(0,10)/10; 
			estrelasTam[i] = random(1,2); 
		}
		
	//asteroides
		for (i = 0; i < qtI; i++) {
			iX[i] = random(50,width-50);
			iY[i] = -random(0,height); 
			iVel[i] = 2+random(0,10)/10;  
		}
		
		for (i = 0; i < qtI2; i++) {
			iX2[i] = random(50,width-50);
			iY2[i] = -random(0,height); 
			iVel2[i] = 2+random(0,10)/10;  
		}
	 
	//tirosdanave
		for ( i = 0; i < qtTiros; i++) {
			yTiros[i] = yj;
			tirosAtivos[i] = false;  
			xd[i] = xj; 
		}
		
	//boss
		for (i = 0; i < qtb; i++){
			xtb[i] = xb;
			ytb[i] = yb;
		}
	}
	
	function draw() { 
		background(0);
		fill(255);
		if (teladejogo == 0) {
			initScreen();
		} else if (teladejogo == 1){
				gameplayScreen();
		} else if (teladejogo == 2){
				gameOverScreen();
		} else if (teladejogo == 3){
				gameWinScreen();
		}
	}
	
	function initScreen() {
		background(inicio);
	}
	
	function keyPressed() {
		if (teladejogo==0) { 
			startGame();
			//somdetiro.stop();
			somexplosao.stop();
			fundogameover.stop();
			fundomusical.play();
			fundomusical.setVolume(0.5);
			somexplosao.setVolume(0.2);
		}
		if (teladejogo==2) {
			restart();
			fundogameover.stop();
			fundomusical.play();
		}
		if (teladejogo==3) {
			restart()
			fundowin.stop()
			fundomusical.play();
		}
	}
	
	function startGame() {
		teladejogo=1;
	}
	
	function gameOver() {
		teladejogo=2;
		fundomusical.stop();
		fundogameover.play();
		fundogameover.setVolume(0.5);
	}
	
	function gameWin() {
		teladejogo=3;
		fundomusical.stop();
		fundowin.play();
		fundowin.setVolume(0.1);
	}
	
	function restart() {
		pontos = 0;
		vida = vidamax;
		teladejogo = 1;
		xj = 400;
		yj = 500;
		xo = random(0,height);
		yo = 0;
		nivel = 1;
		vidab = vidabmax;
		ybarra = -100;
	}
	
	function gameplayScreen() {
		background(fundo);
		frameRate(60);
		desenharbarradevida();
		desenharbarradevidadoboss();
		estrelas();
		jogador();
		asteroides();
		tirosdanave();
		colisoes();
		nivelamento();
		pontuacao();
		nivel1();
		nivel2();
		nivel3();
		nivel4();
		nivel5();
		boss();
	}
	
	function nivelamento(){
		textAlign(CORNER);
		fill(189, 195, 199);
		textSize(30);
		text("Nível: "+nivel, 80, 50);
	}
	
	function pontuacao(){
		textAlign(CENTER);
		fill(189, 195, 199);
		textSize(30);
		text("Pontuação: "+pontos, 400, 50);
	}
	
	function gameOverScreen() {
		background(gameover);
		textAlign(CENTER);
		strokeWeight(4);
		stroke(255);
		fill(50, 50, 50);
		textSize(60);
		text("Sua Pontuação: ", width/2, height/2);
		textSize(130);
		text(pontos, width/2, height/2+120);
	} 
	
	function gameWinScreen() {
		background(telawin);
		textAlign(CENTER);
		fill(255,255,255);
		textSize(30);
		text("Parabéns, você venceu o jogo\nSua Pontuação: ", width/2, height/2 - 230);
		textSize(60);
		text(pontos, width/2, height/2-130);
	}

	function desenharbarradevida() {
		noStroke();
		fill(189, 195, 199);
		rectMode(CORNER);
		rect(xj+5, yj-5, barradevida, 5);
		if (vida > 60) {
			fill(46, 204, 113);				
		} else if ( vida > 30){
				fill(230, 126, 34);
		} else {
				fill(231, 76, 60);
		}
		rectMode(CORNER);
		rect(xj+5, yj-5, barradevida*(vida/vidamax), 5);
	}
	
	function desenharbarradevidadoboss() {
		noStroke();
		fill(189, 195, 199);
		rectMode(CORNER);
		rect(200, ybarra, barradevidab, 15);
		if (vidab > 60) {
			fill(46, 204, 113);				
		} else if ( vidab > 30){
			fill(230, 126, 34);
		} else {
			fill(231, 76, 60);
		}
		rectMode(CORNER);
		rect(200, ybarra, barradevidab*(vidab/vidabmax), 15);
	}
	
	function diminuirvida(){
		vida -= dvida;
		if (vida <= 0){
			gameOver();
		}
	}
	
	function diminuirvida2(){
		vida -= dvida2;
		if (vida<= 0){
			gameOver();
		}
   }
   
	function diminuirvidab(){
		vidab -= dvidaboss;
		if (vidab <= 0){
			gameWin();
		}
	}
		
	function addPontos() {
		pontos = pontos + 10;
		if(pontos == 100){
			addnivel();
		}
		if(pontos == 200){
			addnivel();
		}
		if(pontos == 300){
			addnivel();
		}
		if(pontos == 400){
			addnivel();
		}
		if(pontos == 500){
			addnivel();
		}
	}

	function addnivel(){
		nivel++;
	}
	
	function addvida(){
		vida += avida;
		if (vida >= 100){
			avida = 0;
		} else{
			avida = 25;
		}	
	}
	
	
	function estrelas(){
		for(i = 0; i < qtEstrelas; i++) {
			fill(255,255,255)
			rect(estrelasX[i],estrelasY[i],estrelasTam[i],estrelasTam[i])
		}
  
		for(i = 0; i < qtEstrelas; i++) { 
		estrelasY[i] = estrelasY[i] + estrelasVel[i]; 
		if (estrelasY[i] > height) {
			estrelasX[i] = random(0,width);
			estrelasY[i] = -random(0,height); 		  
			}
		}
	}
		
	function asteroides(){
		for(i = 0; i < qtI; i++) {
			fill(255,0,0)
			image(asteroide1,iX[i],iY[i],70,70)
		}
  
		for(i = 0; i < qtI; i++) { 
		iY[i] = iY[i] + iVel[i]; 
		if (iY[i] > height) {
			iX[i] = random(50,width-50);
			iY[i] = -random(0,height); 		  
			}
		}
		
	}
	
	function colisoes(){
		for(i = 0; i < qtI; i++){
			if (dist(xj,yj,iX[i],iY[i]) < (35+35)){
				iX[i] = -500;
				iY[i] = 0;
				diminuirvida()
			}
		}
		conti++;
		if(conti > 17){
		conti = 0;
		} 
		for ( i = 0; i < qtTiros; i++) {
			gx = iX[i];
			gy = iY[i];
			xe = gx;
			ye = gy;
			if (dist(xd[i],yTiros[i],iX[i],iY[i]) < (35+25)){
				tirosAtivos[i] = false;
				yTiros[i] = -40;
				somexplosao.play();
				explosaoo();
				//time2++
				//if(time2%animeSpeed2==0){
					//image(explosao[sprite2],xe,ye,100,100);
					//sprite2++
					//if(sprite2==17){
						//sprite2=1
					//}
				//}	
				xd[i] = xd;
				iX[i] = -500;
				iY[i] = 0;
				addPontos()
			}
		}
		
		for(i = 0; i < qtI2; i++){
			if (dist(xj,yj,iX2[i],iY2[i]) < (35+35)){
				iX2[i] = -500;
				iY2[i] = 0;
				diminuirvida()
			}
		} 
		for ( i = 0; i < qtTiros; i++) {
			gx2 = iX2[i];
			gy2 = iY2[i];
			xe2 = gx2;
			ye2 = gy2;
			if (dist(xd[i],yTiros[i],iX2[i],iY[i]) < (35+25)){
				tirosAtivos[i] = false;
				yTiros[i] = -40;
				somexplosao.play();
				explosaoo();
				xd[i] = xd;
				iX2[i] = -300;
				iY2[i] = 0;
				addPontos()
			}
		}
		
		if (dist(xj,yj,xa,ya) < (35+35)){
				xa = random(0, width);
				ya = 0;
				diminuirvida2();		
		}
		for ( i = 0; i < qtTiros; i++) {
		
			if (dist(xd[i],yTiros[i],xa,ya) < (15 + 40)){
				tirosAtivos[i] = false;
				yTiros[i] = 0 - 40;
				xd[i] = xj;
				vidaa -= dvidaa;
				if(vidaa == 0){
					somexplosao.play();
					fill(255,100,0);
					image(itemvida, xo, yo, 70, 70);
					if(xo > width){
						xo = xa;
					}
					if( yo > height){
						yo = 0;
						xo = xa;
					}
					yo = ya + 0.2;
					xa = random(0,height);
					ya = 0 - 120;
					addPontos();
					vidaa = 20;
				}
			}
		}
		if (dist(xj,yj,xo,yo) < (35+35)){
			xo = 800;
			yo = 0;
			addvida();
		}
	}
	
	function explosaoo(){
		time2++
		if(time2%animeSpeed2===0){
			image(explosao[sprite],xe,ye);
			sprite2++
			if(sprite2==17){
				sprite2=1
				background(0);
			}
		}
	}
			
	
	function jogador(){
		fill(0,255,0)
		time++
		if(time%animeSpeed==0){
		image(gifnave[sprite],xj, yj, 70, 70);
		sprite++
		if(sprite==5){
		sprite=1;
		
		}
		}
	
		if (keyIsDown(37))
			xj-=5;

		if (keyIsDown(39))
			xj+=5;

		if (keyIsDown(38))
			yj-=5;

		if (keyIsDown(40))
			yj+=5;
			
		if (xj > 800){
			xj = 0;
		}
		if (xj < 0){
			xj = 800
		}
		if (yj>600){
			yj=600
		}
	}
  
	function tirosdanave(){
		if ( keyIsDown(70) && tempoTiro < 0 ) {
			tempoTiro = 5;   
			//somdetiro.play();
			//somdetiro.setVolume(0.1);
			for ( i = 0; i < qtTiros; i++) {
				if ( tirosAtivos[i] ==  false ) {
				tirosAtivos[i] = true;
				yTiros[i] = yj-15;
				xd[i]=xj+10;
				break; 
				} 
			} 
		}
		tempoTiro--;  
		for ( i = 0; i < qtTiros; i++) {
			if ( tirosAtivos[i] ) {
				image(tiro,xd[i], yTiros[i], 50, 50);	
				xd=xd	    
				yTiros[i] -= 10; 
				if (yTiros[i] < 0-40) {
				tirosAtivos[i] = false; 
				}
			} 
		}
	}
	
	function nivel1() {
		if(nivel==1){
			for(i = 0; i < qtI; i++) {
				fill(255,255,255);
				image(asteroide1, iX[i], iY[i], 70, 70)
			}
  
			for(i = 0; i < qtI; i++) { 
				//iY[i] = yI[i] + vI[i]; 
				if (iY[i] > height) {
					iX[i] = random(50,width-50);
					iY[i] = -random(0,height); 		  
				}
			}
		}
	}
	
	function nivel2(){
		if (nivel == 2){
			for(i = 0; i < 10; i++) {
				fill(255,255,255);
				image(asteroide1, iX[i], iY[i], 70, 70)
			}
			for(i = 0; i < 4; i++) { 
				iY[i] = iY[i] + iVel[i]; 
				if (iY[i] > height) {
					iX[i] = random(50,width-50);
					iY[i] = -random(0,height); 		  
				}
			}
			for(i = 0; i < qtI2; i++) {
				fill(255,255,255);
				image(asteroide1, iX2[i], iY2[i], 70, 70)
			}
			for(i = 0; i < qtI2; i++) { 
				iY2[i] = iY2[i] + iVel2[i]; 
				if (iY2[i] > height) {
					iX2[i] = random(50,width-50);
					iY2[i] = -random(0,height); 		  
				}
			}
			for(i = 0; i < qtI2; i++) { 
				iY2[i] = iY2[i] + iVel2[i]; 
				if (iY2[i] > height) {
					iX2[i] = random(50,width-50);
					iY2[i] = -random(0,height); 		  
				}
			}
		}	
	}
	
	function nivel3(){
		if (nivel == 3){
			for(i = 0; i < qtEstrelas; i++) {
				fill(255,255,255);
				rect(estrelasX[i],estrelasY[i],estrelasTam[i],estrelasTam[i])
			}
			for(i = 0; i < qtEstrelas; i++) { 
				estrelasY[i] = estrelasY[i] + estrelasVel[i]; 
				if (estrelasY[i] > height) {
					estrelasX[i] = random(0,width);
					estrelasY[i] = -random(0,height); 		  
				}
			}
	
			for(i = 0; i < qtI; i++) {
				fill(255,255,255);
				image(asteroide1, iX[i], iY[i], 70, 70)
			}
			for(i = 0; i < 4; i++) { 
				iY[i] = iY[i] + iVel[i]; 
				if (iY[i] > height) {
					iX[i] = random(50,width-50);
					iY[i] = -random(0,height); 		  
				}
			}
			for(i = 0; i < qtI; i++) {
				fill(255,255,255);
				image(asteroide1, iX[i], iY[i], 70, 70)
			}
			for(i = 0; i < 4; i++) { 
				iY[i] = iY[i] + iVel[i]; 
				if (iY[i] > height) {
					iX[i] = random(50,width-50);
					iY[i] = -random(0,height); 		  
				}
			}
		}
	}
	
	function nivel4(){
		if (nivel == 4){
			for(i = 0; i < qtEstrelas; i++) {
				fill(255,255,255);
				rect(estrelasX[i],estrelasY[i],estrelasTam[i],estrelasTam[i])
			}
			for(i = 0; i < qtEstrelas; i++) { 
				estrelasY[i] = estrelasY[i] + 2*estrelasVel[i]; 
				if (estrelasY[i] > height) {
					estrelasX[i] = random(0,width);
					estrelasY[i] = -random(0,height); 		  
				}
			}
	
			for(i = 0; i < qtI; i++) {
				fill(255,255,255);
				image(asteroide1, iX[i], iY[i], 70, 70)
			}
			for(i = 0; i < 4; i++) { 
				iY[i] = iY[i] + 2*iVel[i]; 
				if (iY[i] > height) {
					iX[i] = random(50,width-50);
					iY[i] = -random(0,height); 		  
				}
			}
			for(i = 0; i < qtI; i++) {
				fill(255,255,255);
				image(asteroide1, iX[i], iY[i], 70, 70)
			}
			for(i = 0; i < 4; i++) { 
				iY[i] = iY[i] + iVel[i]; 
				if (iY[i] > height) {
					iX[i] = random(50,width-50);
					iY[i] = -random(0,height); 		  
				}
			}
		}
	}
	
	function nivel5(){
		if (nivel == 5){
			fill(255,100,0);
			cont++;
			image(itemvida, xo, yo, 70, 70);
			if (cont >= 500){
				if(xo > width){
				xo = 0;
			}
			if( yo > height){
				yo = 0;
				xo = 900;	
			}
			cont = 0;
			}
			yo = yo + 5;
			for(i = 0; i < 10; i++) {
				fill(255,255,255);
				image(asteroide1, iX[i], iY[i], 70, 70)
			}
			for(i = 0; i < 4; i++) { 
				iY[i] = iY[i] + iVel[i]; 
				if (iY[i] > height) {
					iX[i] = random(50,width-50);
					iY[i] = -random(0,height); 		  
				}	 
			}
			
			for(i = 0; i < qtI2; i++) {
				fill(255,255,255);
				image(asteroide1, iX2[i], iY2[i], 70, 70)
			}	
  
			for(i = 0; i < qtI2; i++) { 
				iY2[i] = iY2[i] + iVel2[i]; 
				if (iY2[i] > height) {
					iX2[i] = random(50,width-50);
					iY2[i] = -random(0,height); 		  
				} 
			}
			for(i = 0; i < qtI2; i++) { 
				iY2[i] = iY2[i] + iVel2[i]; 
				if (iY2[i] > height) {
					iX2[i] = random(50,width-50);
					iY2[i] = -random(0,height); 		  
				} 
			}	

			image(asteroide2, xa, ya, 70, 70);
		
			if(xa > width){
				xa = 0;
			}
		

			if( ya > height){
				ya = 0;
				xa = random(0,height);		
			}
			ya = ya + 0.5;	
		}
	}
	
	function boss(){
		if (nivel == 6){
			contb++
			time3++
			if(time3%animeSpeed3===0){
				image(gifboss[sprite3], xb, yb, 100 , 100);
				sprite3++
				if(sprite3==8){
					sprite3=1
				}
				ybarra = 100;
				yb = yb + 5;
				if (yb >= 100){
					yb = 100;
					xb = xb + vb;
					if(xb > width || xb < -10){
						borda = true;
					}
					if(borda){
						if(xb > width){
							vb = -5;
						}
						if(xb < -10){
							vb = 5;
						}
					}	
				}
				for(i = 0; i < qtb; i++) {
					fill(255,255,255);
					image(tiroboss,xtb[i],ytb[i]+50,70,70)
				}
				for(i = 0; i < qtb; i++) { 
					ytb[i] = ytb[i] + vtb; 
					if (ytb[i] > height) {
						xtb[i] = xb;
						ytb[i] = yb; 		  
					}
				}
				for(i = 0; i < qtb; i++) { 
					if (dist(xj,yj,xtb[i],ytb[i]) < (35+35)){
						xtb[i] = xb;
						ytb[i] = yb;
						diminuirvida();
					} 
				}	
				for ( i = 0; i < qtTiros; i++) {
					if (dist(xd[i],yTiros[i],xb,yb) < (25+50)){
						tirosAtivos[i] = false;
						yTiros[i] = 0 - 40;
						xd[i] = xj;
						diminuirvidab();
					}
				}
			}				
		}	
	}			


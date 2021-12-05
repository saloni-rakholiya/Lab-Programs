# from node 0 to 24 and node 4 to 20
BEGIN{
  totalsent=0
  totalreceived=0
  sent10=0
  received10 = 0
  sent20=0
  received20 = 0
  sent30=0
  received30 = 0
  sent40=0
  received40 = 0
  sent50=0
  received50 = 0
}
{
  # if($1 == "+" && $4)
  if ($1=="r" && ($4=="20" || $4=="24")  )
  {
    received+=1
    if( $2 <= 10 ){
      received10+=1;
    }
    else if( $2 <= 20 ){
      received20+=1;
    }
    else if( $2 <= 30 ){
      received30+=1;
    }
    else if( $2 <= 40 ){
      received40+=1;
    }
    else if( $2 <= 50 ){
      received50+=1;
    }
  }
  else if ($1=="-" && ($3=="0" || $3=="4") )
  {
    sent+=1
    if( $2 <= 10 ){
      sent10+=1;
    }
    else if( $2 <= 20 ){
     sent20+=1;
    }
    else if( $2 <= 30 ){
      sent30+=1;
    }
    else if( $2 <= 40 ){
      sent40+=1;
    }
    else if( $2 <= 50 ){
      sent50+=1;
    }
  }

  
}
END{
  printf("\npackages transmitted is %d\n",sent)
  printf("packages received is %d\n",received)
  printf("Total package delivery ratio (PDR) is %f\n",received/sent)
  printf("Total package loss ratio (PLR) is %f\n", (sent-received)/sent)

  printf("\npackages transmitted is %d\n",sent10)
  printf("packages received is %d\n",received10)
  printf("package delivery ratio (PDR) 0-10sec is %f\n",received10/sent10)
  printf("package loss ratio (PLR) 0-10sec is %f\n", (sent10-received10)/sent10)

  printf("\npackages transmitted is %d\n",sent20)
  printf("packages received is %d\n",received20)
  printf("package delivery ratio (PDR) 10-20sec is %f\n",received20/sent20)
  printf("package loss ratio (PLR) 10-20sec is %f\n", (sent20-received20)/sent20)

  printf("\npackages transmitted is %d\n",sent30)
  printf("packages received is %d\n",received30)
  printf("package delivery ratio (PDR) 20-30sec is %f\n",received30/sent30)
  printf("package loss ratio (PLR) 20-30sec is %f\n", (sent30-received30)/sent30)

  printf("\npackages transmitted is %d\n",sent40)
  printf("packages received is %d\n",received40)
  printf("package delivery ratio (PDR) 30-40sec is %f\n",received40/sent40)
  printf("package loss ratio (PLR) 30-40sec is %f\n", (sent40-received40)/sent40)

  printf("\npackages transmitted is %d\n",sent50)
  printf("packages received is %d\n",received50)
  printf("package delivery ratio (PDR) 40-50sec is %f\n",received50/sent50)
  printf("package loss ratio (PLR) 40-50sec is %f\n", (sent50-received50)/sent50)


}

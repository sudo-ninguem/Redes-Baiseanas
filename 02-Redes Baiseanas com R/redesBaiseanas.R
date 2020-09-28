###################################### REDES BAYSEANAS #############################################

## Seguindo o mesmo exemplo de dados do python, qual seja, casos de acidente, vamos também fazer um exemplo para prever a probabilidade
## de um acidente, mas desta vez usando as redes baiseanas. 

install.packages("bnlearn") ## este é o pacote em R com as funções das redes bayseanas 
library(bnlearn) ## vamos usar esta biblioteca 

install.packages("caret", dependencies = T) ## esta é outra biblioteca nescessária para usar as redes bayseanas 
library(caret)

res <- hc(insurance) ## Aqui estamos colocando dentr da váriavel (res) o nosso banco de dados de casos

## mas repare que estamos usando a função (hc) e passando como parametro o nosso banco de dados  isso porque

## o hc representa hill climber, que como bem vimos é uma das formas de algóritimo de busca que o método

## rede baises pode utilizar, ou seja, ao passarmos o banco de dados já passamos o algoritimo de busca

## que iremos utilizar na criação da nossa I.A


plot(res) ## Podemos ver o grafico gerado correlacionando os atributos do nosso banco de dados 


################################### GERANDO O MODELO COM REDE BAISE############################3

modelo <- bn.fit(res, data = insurance)

## Dentro da váriavel modelo vamos usar a função (bn.ft) que serve justamente para criar um modelo de testes

## Para isso essa função deve receber 2 elementos sendo eles, a dependencia entre os elementos 

## Que no caso já criamos na váriavel (res) 

## E o segundo parametro que devemos passar é o nosso banco de dados que no caso é o arquivo (insurance)


## Após isso teremos todas as tabelas de probabilidades criadas a partir dos atributos 

## podemos acessar cada tabela de probabilidade passando o nome do atributo específico que queremos usar

modelo$GoodStudent ## Aqui vamos ver apenas as probabilidades do atributo (bom estudante)



######################### ANALISANDO CASOS COM NOSSA REDE BAISE ############################


joao <-cpquery(modelo, event =(Accident=="Moderate" | Accident=="Severe"),
        evidence =(Age=="Senior" & RiskAversion=="Adventurous" & MakeModel=="SportsCar"))

plot(joao)

maria <-cpquery(modelo, event =(Accident=="Moderate" | Accident=="Severe"),
                evidence =(Age=="Senior" & RiskAversion=="Adventurous" & MakeModel=="SportsCar"))

plot(maria)


## Perceba usamos 2 váriaveis aqui simulando pessoas, mas isso é o menos importante o que de fato é

## importante e a função (cpquery) que vai fazer justamente a previsão dos casos recebendo como parametro

## 1º = o modelo de relações que criamos justamente na váriavel chamada (modelo)

## 2º = Os eventos que queremos analisar, neste caso hipotético queremos analisar o evento acidente (moderado) ou (|) severo

## Neste caso poderiamos analisar diversos eventos condicionais ou isolados etc. 

## 3º = O terceiro parametro que passamos é as evidencias, ou seja, os dados que queremos submeter a nossa I.A para a previsão

## neste caso passamos apénas algumas evidencias, ou seja, não precisa ser todas, mas quanto mais evidencias melhor será

## a previsão da nossa I.A. Neste caso passamos como evidencia a idade, aversão a risco e o modelo de carro 

## Agora note que tanto nos eventos quanto nas evidencias devemos nos atentar a escrever da mesma forma que está os 

## (atributos) no nosso banco de dados e no modelo sob pena de DAR ERRO, pois vamos passar um dado não compátivel 

## Outra coisa a se observar é que usamos 2 váriaveis (maria e joão) simulando 2 casos passando OS MESMOS DADOS

## ENTRETANTO NOSSO ALGORÍTIMO RETORNOU RESULTADOS LEVEMENTE DIFERENCIADOS ISSO OCORRE PORQUE O CPQUERY TRABALHA COM

## ALGUNS ELEMENTOS ALEATÓRIOS. 

## Para poder minimizar essa aleatóriedade podemos passar o parametro (n=10000000) após as evidencias desta forma



pedrita <-cpquery(modelo, event =(Accident=="Moderate" | Accident=="Severe"),
                    evidence =(Age=="Senior" & RiskAversion=="Adventurous" & MakeModel=="SportsCar"), n =10000000)

goku <-cpquery(modelo, event =(Accident=="Moderate" | Accident=="Severe"),
                  evidence =(Age=="Senior" & RiskAversion=="Adventurous" & MakeModel=="SportsCar"), n =10000000)

plot(pedrita) ## 22%
plot(goku)  ## 22%

## Perceba que agora embora os valores tiveram um fator aleatóriedade este foi mínimo e em ambos os casos para fins

## de calculo o risco de acidente de ambas, usando os mesmos dados foram de 0.22, ou seja, 22%
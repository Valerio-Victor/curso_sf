

#' OBJETIVO: Importar os dados da API da ANEEL
#' AUTOR: Victor Valerio
#' ÚLTIMA ARTUALIZAÇÃO: 12-11-2022


library(magrittr, include.only = '%>%')

i <- 0
r <- 1

gd_bigdata = list()

repeat{
  url <-
    paste0("https://dadosabertos.aneel.gov.br/api/3/action/",
           "datastore_search?",
           "resource_id=b1bd71e7-d0ad-4214-9053-cbd58e9564a7&limit=32000&offset=",
           format(32000*i, scientific = FALSE))
  page <- httr::GET(url) # Requisicao API
  gd_list <- jsonlite::fromJSON(url) # Convertenndo em lista
  gd_data <- gd_list$result$records # Convertendo em tabela
  if(is.null(nrow(gd_data))==T){ # Encerrando loop se nao tiver
    dados
    break
  }
  gd_bigdata[[r]] <- gd_data # Criando uma lista de dados para cada i
  i = i+1
  r = r+1
}
gd <- dplyr::bind_rows(gd_bigdata) # Unindo todas as listas
list_cnpj = gd %>%
  subset(SigTipoConsumidor=="PJ")%>%
  dplyr::select("NumCPFCNPJ")%>%
  unique() %>%
  dplyr::as_tibble() #Obtendo a lista de CNPJs GDs
names(list_cnpj)[1]="cnpj"
write.csv(gd,"Dados/1.Consulta_CKAN_ANEEL.csv")
write.csv(list_cnpj,"Dados/2.Lista_CNPJs_com_GD.csv")




url <- paste0("https://dadosabertos.aneel.gov.br/api/3/action/",
              "datastore_search?",
              "resource_id=b1bd71e7-d0ad-4214-9053-cbd58e9564a7&limit=32000&offset=",
              format(32000*i, scientific = FALSE))


page <- httr::GET(url)


gd_list <- jsonlite::fromJSON(url) # Convertenndo em lista


gd_data <- gd_list$result$records # Convertendo em tabela



if(is.null(nrow(gd_data))==T){ # Encerrando loop se nao tiver
  dados
  break
}

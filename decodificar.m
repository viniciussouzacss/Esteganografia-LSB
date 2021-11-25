#***   Simples script de esteganografia ***
#***   Objetivo: Encontrar e recuperar mensagem na imagem ***

#*** Francisco Godinho Neto - 180141 ***#
#*** Geazi Antunes da Cruz - 180683 ***#
#*** Paola Rodrigues Lopes - 180115 ***#
#*** Vinicius Cavalcante Silva Souza - 180854 ***#

#Main function to proof the concept
function [resultado] = decodificar()
  
  # Recupera nome da imagem para decodificar
  nomeImagem = abreMenuImagens();
  
  # Recupera imagem para decodificar
  imagemComMsgOculta = imread(nomeImagem);
  
  for i=1:length(imagemComMsgOculta)
    # Para cada bit. Recupra o bit menos significativo
    bitsEscondidos(i)= dec2bin(~bitget(imagemComMsgOculta(i),1));
  endfor
  
  # Mosta o resultado na janela de comandos
  resultado = reshape(char(bin2dec(reshape(bitsEscondidos(1:imagemComMsgOculta(end)*7),[],7))),1,[]);
  
  # Mostra resultado no popup
  mostraTextoRecuperado('DECODIFICADOR', 'Texto Recuperado:', resultado);
endfunction

#*** Essa funcao abre uma janela para escolher a imagem que deseja usar ***#
function [nomeImagem] = abreMenuImagens()

  # Recupera a pasta atual
  pasta = fileparts(which('decodificar.m'));
  
  # Recupera arquivos da pasta atual com extencao TIF, PNG e JPG
  arquivos = [dir(fullfile(pasta,'*.bmp'));];
  
  for k = 1 : length(arquivos)
    [~, nomeArquivo, extencao] = fileparts(arquivos(k).name);
    nomesArquivos{k} = nomeArquivo;
  end
  
  # Ordenar em ordem alfabetica
  [nomesArquivos, ordernado] = sortrows(nomesArquivos');
  arquivos = arquivos(ordernado);
  button = menu('Selecione a imagem gerada que pretende decodificar?', nomesArquivos);
  if button == 0
    return;
  end
  # Recupera a base do nome do arquivo
  nomeArquivo = arquivos(button).name; % Assign the one on the button that they clicked on.
  
  # Recupera o nome do arquivo + extencao
  nomeImagem = fullfile(pasta, nomeArquivo);
endfunction

function [] = mostraTextoRecuperado(tituloCaixaMensagem, entradaMensagem, fraseBase)
  # Variavel de exemplo para a mensagem
  texto = fraseBase;
  
  # Exibe caixa de entrada para usuario digitar a mensagem
  valorExemplo = texto;
  inputdlg(entradaMensagem, tituloCaixaMensagem, [1, length(entradaMensagem) + 75], {num2str(valorExemplo)});
 endfunction
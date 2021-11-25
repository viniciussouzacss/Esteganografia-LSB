#***   Simples script de esteganografia ***
#***   Objetivo: Esconder mensagem na imagem ***

#*** Francisco Godinho Neto - 180141 ***#
#*** Geazi Antunes da Cruz - 180683 ***#
#*** Paola Rodrigues Lopes - 180115 ***#
#*** Vinicius Cavalcante Silva Souza - 180854 ***#

#Main function to proof the concept
function [resultado] = stego()
  
  # Recupera o nome da imagem que o usuário escolheu
  nomeImagemOriginal = abreMenuImagens();
  
  # Carrega a imagem que o usuário escolheu
  imagemOriginal = imread(nomeImagemOriginal);
  
  # Mostrar imagem escolhida pelo usuário
  subplot(2,1,1);
  imshow(imagemOriginal);
  subplot(2,1,2);
  
  # Recupera o texto que o usuário digitou para ser escondido
  textoEscondido = recuperarTextoPeloUsuario('Esteganografia', 'Escreva a mensagem que deseja esconder', 
  'Frase sem acento max 35 caracteres');
  
  # Esconde o texto na imagem
  novaImagem = esteganografar(imagemOriginal, textoEscondido);
  
  # Mostra a imagem com o texto escondido
  imshow(novaImagem);
  
  # Recupera nome da imagem com texto escondido
  nomeNovaImagem = recuperarTextoPeloUsuario('Esteganografia', 'De um nome para a nova imagem gerada (sem extencao)', '');
  
  imwrite(novaImagem, [nomeNovaImagem ".bmp"]);
  
  # Mosta mensagem para o usuario rodar o script de decodificao
  fprintf('Pronto! Agora execute o script "decodificar.m" para obter o texto escondido.')
endfunction

#*** Essa funcao esconde o texto na imagem, criando uma nova imagem ***#
function [novaImagem] = esteganografar(imagemOriginal, texto)
  # Recupera imagem original em outra variavel
  novaImagem = imagemOriginal;
  
  # Converte texto para caracteres ASCII
  textoDouble = double(texto);
  
  # Converte texto para binario
  textoBinario = vec(dec2bin(textoDouble));
  
  for i=1:length(textoBinario)
    
    # LSB - Define os bits menos significativos
    novaImagem(i) = bitset(imagemOriginal(i+1), 1, ~bin2dec(textoBinario(i)));
  endfor
  
  # Define o ultimo bit da imagem com o tamanho do texto
  novaImagem(end)=length(texto);
endfunction

#*** Essa funcao abre uma janela para escolher a imagem que deseja usar ***#
function [nomeImagem] = abreMenuImagens()

  # Recupera a pasta atual
  pasta = fileparts(which('cameraman.tif'));
  
  # Recupera arquivos da pasta atual com extencao TIF, PNG e JPG
  arquivos = [dir(fullfile(pasta,'*.TIF')); dir(fullfile(pasta,'*.PNG')); dir(fullfile(pasta,'*.jpg'))];
  
  for k = 1 : length(arquivos)
    [~, nomeArquivo, extencao] = fileparts(arquivos(k).name);
    nomesArquivos{k} = nomeArquivo;
  end
  
  # Ordenar em ordem alfabetica
  [nomesArquivos, ordernado] = sortrows(nomesArquivos');
  arquivos = arquivos(ordernado);
  button = menu('Selecione a imagem que pretende esteganografar?', nomesArquivos);
  if button == 0
    return;
  end
  # Recupera a base do nome do arquivo
  nomeArquivo = arquivos(button).name; % Assign the one on the button that they clicked on.
  
  # Recupera o nome do arquivo + extencao
  nomeImagem = fullfile(pasta, nomeArquivo);
endfunction

function [texto] = recuperarTextoPeloUsuario(tituloCaixaMensagem, entradaMensagem, fraseBase)
  # Variavel de exemplo para a mensagem
  texto = fraseBase;
  
  # Exibe caixa de entrada para usuario digitar a mensagem
  valorExemplo = texto;
  respostaUsuario = inputdlg(entradaMensagem, tituloCaixaMensagem, [1, length(entradaMensagem) + 75], {num2str(valorExemplo)});
  if isempty(respostaUsuario)
	  # Caso clique em cancelar ou mensagem seja vazia
	  close(hFig);
	  return;
  end; 
  # Receber as celulas
  whos respostaUsuario;
  # Converter para caracteres
  texto = cell2mat(respostaUsuario);
  whos texto;
 endfunction
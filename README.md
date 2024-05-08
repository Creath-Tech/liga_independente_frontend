# Guia de Instalação do Appium

O Appium é um servidor de automação de testes de código aberto utilizado para testar aplicações móveis. Ele permite que você teste aplicativos nativos, híbridos e da web em plataformas móveis iOS, Android e Windows. Este README fornece instruções passo a passo para instalar e configurar o Appium em um ambiente Windows.
Pré-requisitos

# Antes de instalar o Appium, você precisa instalar os seguintes softwares:

   1. Node.js e npm: O Appium é um servidor Node.js.
   2.Java Development Kit (JDK): Necessário para a execução de testes em Android.
   3.Android Studio: Para a configuração do Android SDK e emuladores.
   4.Git: Opcional, para clonar o repositório ou instalar dependências.

# Instalação dos Pré-requisitos

1.Node.js e npm:
    Baixe e instale o Node.js em nodejs.org.
    A instalação do Node.js já inclui o npm (Node Package Manager).

2.Java Development Kit (JDK):
    Baixe e instale o JDK através do site da Oracle.
    Configure a variável de ambiente JAVA_HOME para o diretório onde o JDK foi instalado.

3.Android Studio:
    Baixe e instale o Android Studio em developer.android.com/studio.
    Durante a instalação, certifique-se de incluir o Android SDK.

Git:
        Baixe e instale o Git de git-scm.com.

# Instalação do Appium

Instale o Appium via npm:


    npm install -g appium

(Opcional) Instale o Appium Desktop:
        Para uma interface gráfica do usuário facilitada, você pode instalar o Appium Desktop de github.com/appium/appium-desktop.
        Siga as instruções de instalação fornecidas na página.

# Configurando o Ambiente Android

Defina as variáveis de ambiente para o Android SDK:
        ANDROID_HOME: Defina esta variável para o local do seu SDK. Normalmente, C:\Users\<Seu-Usuario>\AppData\Local\Android\Sdk.
        Adicione as pastas platform-tools e tools ao seu PATH.

Crie e configure um dispositivo emulador usando o AVD Manager no Android Studio.
# Corrigindo o erro com o Vulkan

Se você está enfrentando problemas com a aceleração gráfica Vulkan ao usar emuladores no Android Studio, siga estas etapas:

Atualize os drivers da sua GPU:
        Certifique-se de que os drivers gráficos da sua placa de vídeo estão atualizados, pois os drivers desatualizados podem causar problemas com o Vulkan.

Habilite a aceleração por hardware:
        No Android Studio, vá para File > Settings > Emulator (ou Android Studio > Preferences > Emulator no macOS) e certifique-se de que a opção "Enable GPU emulation" está marcada.

Instale o Vulkan SDK:
        Baixe e instale o Vulkan SDK da LunarG para obter os drivers e ferramentas mais recentes, disponíveis em LunarXchange.

Verifique a configuração do emulador:
        No AVD Manager, edite seu dispositivo virtual e certifique-se de que a opção "Emulated Performance" está configurada para usar 'Hardware - GLES 2.0' para utilizar a aceleração por hardware.

# Caso você queira usar o vídeo dedicado do seu computador seguir os seguintes passos
   1. Crie o arquivo ~/.android/advancedFeatures.ini (para usuários do Windows o caminho deve ser C:\Users<username>.android\advancedFeatures.ini) com o seguinte conteúdo:

   Veja como desativar os aplicativos Vulkan para conversar com o emulador. Adicione as seguintes linhas a ~/.android/advancedFeatures.ini (crie este arquivo se ele ainda não existir):
      
      Vulkan = off

      GLDirectMem = on
   

# Verificando a Instalação

Verifique a instalação do Appium:

     appium --version 

Isso deve mostrar a versão do Appium instalada.

Execute o servidor Appium:


    appium 

Isso iniciará o servidor Appium na porta 4723 por padrão.

Escrevendo e Executando Testes

Escreva seus testes usando uma das bibliotecas de cliente do Appium (como Appium Java, Python, Ruby, etc.).
Execute os testes apontando para o servidor Appium e o dispositivo/emulador configurado.

Este README oferece uma visão geral básica para começar com o Appium em Windows. Certifique-se de explorar a documentação oficial do Appium para mais detalhes e guias avançados.


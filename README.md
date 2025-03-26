# TestMELI

TestMELI é um aplicativo iOS desenvolvido em Swift para listar e visualizar produtos do Mercado Livre. O projeto segue a arquitetura MVVM + Coordinator para melhor organização e manutenção do código.

## 📌 Funcionalidades
- 🔍 Busca e listagem de produtos
- 📄 Exibição de detalhes do produto
- 🏁 Tela de splash para carregamento inicial
- 🔑 Autenticação de usuário via API

## 🏗 Arquitetura do Projeto
O projeto segue o padrão **MVVM (Model-View-ViewModel)** combinado com **Coordinator Pattern** para gerenciamento de navegação.

### 📂 Estrutura de Pastas
```
TestMELI/
│── UI/                   # Configurações de UI e Extensões
│── Core/                 # Coordenadores, segurança e bindings
│── Source/               # Código principal do app
│   ├── Splash/           # Tela inicial
│   ├── ListProducts/     # Listagem de produtos
│   ├── DetailProduct/    # Detalhes do produto
│   ├── Login/            # Tela de login e autenticação
│── Network/              # Camada de requisições HTTP
│── Tests/                # Testes unitários
```

### 📜 Principais Componentes
- **ViewModel**: Separa a lógica de negócios da `ViewController`
- **Coordinator**: Gerencia a navegação entre telas
- **Service Layer**: Responsável pelas chamadas de API
- **Extensions**: Contém melhorias para classes nativas do Swift
- **Network Layer**: Centraliza todas as requisições HTTP para comunicação com a API

## 🔑 Autenticação e Login
O aplicativo permite que os usuários façam login utilizando uma API de autenticação. A camada de rede gerencia a autenticação e armazena tokens para requisições futuras.

### 🔹 Fluxo de Login
1. O usuário insere suas credenciais na tela de login.
2. A `LoginViewModel` envia as credenciais para a API de autenticação.
3. Se o login for bem-sucedido, um token de acesso é armazenado.
4. O usuário é redirecionado para a tela de listagem de produtos.

### 🔹 Como testar o login
Para autenticar no app, utilize as credenciais de teste fornecidas pela API:
```bash
Usuário: emilys
Senha: emilyspass
```
Caso o login seja bem-sucedido, o token retornado será usado para acessar a listagem de produtos.

## 🚀 Como Rodar o Projeto
1. Clone o repositório:
   ```bash
   git clone https://github.com/taylorjeftedasilva/meli-test.git
   ```
2. Abra o arquivo `TestMELI.xcodeproj` no Xcode
3. Execute o projeto no simulador ou dispositivo físico

## 🔧 Melhorias Futuras
- Implementar testes unitários para `ViewModels`
- Melhorar cache de imagens
- Refatorar para Swift Concurrency

📌 **Desenvolvido por**: Taylor Jefté da Silva


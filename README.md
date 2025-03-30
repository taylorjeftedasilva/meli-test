# TestMELI

TestMELI é um aplicativo iOS desenvolvido em Swift para listar e visualizar produtos do Mercado Livre. O projeto segue a arquitetura [MVVM](https://medium.com/@zebayasmeen76/mvvm-in-ios-swift-6afb150458fd) + [Coordinator](https://www.hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps) para melhor organização e manutenção do código.

> **Nota**: As APIs do Mercado Livre exigem autenticação para acesso aos dados. Para facilitar o desenvolvimento e os testes, o projeto utiliza a API [DummyJSON](https://dummyjson.com) para listar produtos e simular a autenticação de usuários.


## 📌 Funcionalidades
- 🔍 Busca e listagem de produtos
- 📄 Exibição de detalhes do produto
- 🏁 Tela de splash para carregamento inicial
- 🔑 Autenticação de usuário via API
- 🔎 Exibição de resultados de pesquisa
- ⚠️ Tela de erro para falhas na requisição

## 🏗 Arquitetura do Projeto
O projeto segue o padrão **MVVM (Model-View-ViewModel)** combinado com [**Coordinator Pattern**](https://medium.com/@batistagc/o-que-%C3%A9-para-que-serve-e-como-usar-coordinator-em-ios-4cb310ec1e86) para gerenciamento de navegação.

### 📂 Estrutura de Pastas
```
TestMELI/
│── UI/                   # Configurações de UI e Extensões
│── Core/                 # Coordenadores, segurança e bindings
│── Source/               # Código principal do app
│   ├── Splash/           # Tela inicial
│   ├── ListProducts/     # Listagem de produtos e pesquisa de items
│   ├── DetailProduct/    # Detalhes do produto
│   ├── Login/            # Tela de login e autenticação
│   ├── Error/            # Tela de error
│   ├── ResultSearch/     # Resultado das pesquisas
│── Network/              # Camada de requisições HTTP
TestMELITests/                # Testes unitários
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
2. (Opcional para a branch main) Utilize o [XcodeGen](https://medium.com/@daviddvd19/xcodegen-first-steps-%EF%B8%8F-a2d4655ced86) para gerar o arquivo TestMELI.xcodeproj.
3. Abra o arquivo `TestMELI.xcodeproj` no Xcode
4. Execute o projeto no simulador ou dispositivo físico

## 🔧 Melhorias Futuras
- Implementar funcionalidade de logout
- Otimizar o cache de imagens
- Remover strings hardcoded, utilizando um sistema de constantes ou localization
- Configurar pipeline de CI/CD para testes automatizados com cobertura mínima

📌 **Desenvolvido por**: Taylor Jefté da Silva


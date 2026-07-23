# RouteX

A Delphi microframework that abstracts route creation on top of [Horse](https://github.com/HashLoad/horse). It lets you define a single base URL that automatically handles all of an API's routes, eliminating the need to manually create a route for every endpoint.

> *Um microframework em Delphi que abstrai a criação de rotas sobre o [Horse](https://github.com/HashLoad/horse). Permite definir uma única URL base que passa a tratar automaticamente todas as rotas de uma API, eliminando a necessidade de criar manualmente uma rota para cada endpoint.*

> **Author:** Lucio Mello — [linkedin.com/in/lucio-mello-df](https://www.linkedin.com/in/lucio-mello-df)
> **Version:** 0.1 (2026)
>
> *Autor: Lucio Mello — Versão: 0.1 (2026)*

## Overview / Visão geral

In practice, RouteX works as a simplified reverse proxy: once you configure a base URL, a port, and a prefix, it redirects incoming requests to the destination API, forwarding the path, query string, and authentication header (Bearer Token), and returning the response to the original client.

> *Na prática, o RouteX funciona como um proxy reverso simplificado: ao configurar uma URL base, uma porta e um prefixo, ele passa a redirecionar as requisições recebidas para a API de destino, repassando path, query string e cabeçalho de autenticação (Bearer Token), e devolvendo a resposta ao cliente original.*

## How to use / Como usar
You can add the routex folder as a module of your application.

1. Import `TRoutex`
2. Use the `Configure` method to set the port, the local URL, the intended API (`BaseUrl`), and the required `Prefix`
3. Run `Start`

Voce pode adicionar a pasta routex como um módulo da sua aplicação. 
> *1. Importar `TRoutex`
> 2. Usar o método `Configure` para definir a porta, a URL local, a API pretendida (`BaseUrl`) e o `Prefix` necessário
> 3. Executar `Start`*

```pascal
uses
  Routex;

var
  Rx: TRoutex;
begin
  Rx := TRoutex.Create;
  try
    Rx.Configure(
      8080,                          // Port
      'https://api.destino.com.br',  // BaseUrl (destination API)
      '/v1',                         // Prefix
      'meu-token-de-acesso'          // Token (Bearer, optional)
    );
    Rx.Start;
  finally
    Rx.Free;
  end;
end.
```

With the configuration above, a request to `http://localhost:8080/clientes` is forwarded to `https://api.destino.com.br/v1/clientes`, including the header `Authorization: Bearer meu-token-de-acesso` (when provided). `Token` is optional — the RTTI-based validation explicitly skips that property; `Port`, `BaseUrl`, and `Prefix` remain mandatory, and their absence makes `Start` raise an `Exception`.

> *Com a configuração acima, uma requisição para `http://localhost:8080/clientes` é repassada para `https://api.destino.com.br/v1/clientes`, incluindo o header `Authorization: Bearer meu-token-de-acesso` (se informado). `Token` é opcional — a validação via RTTI ignora explicitamente essa propriedade; `Port`, `BaseUrl` e `Prefix` continuam obrigatórios, e sua ausência faz `Start` lançar uma `Exception`.*

## Architecture / Arquitetura

The project is organized into 8 units, each with a specific responsibility:

> *O projeto é organizado em 8 units, cada uma com uma responsabilidade específica:*

| Unit | Role | Description |
|---|---|---|
| `Routex.pas` | Facade | Exposes `TRoutex`/`IRoutex`, orchestrates `Configure`/`Start`/`Shutdown` |
| `Routex.Config.pas` | Configuration | `TConfig` — stores the configuration parameters (`Port`, `BaseUrl`, `Prefix`, `Token`) |
| `Routex.Client.pas` | HTTP client | `TClient` — builds the destination URL and executes GET/POST against the destination API |
| `Routex.Routes.pas` | Routing | Registers the Horse routes (root and GET/POST wildcards) and delegates to `TClient` |
| `Routex.Consumer.pas` | HTTP utility | `Consumer` function — a simple, standalone GET against any URL |
| `Routex.ValidarObjeto.pas` | Generic validation | `TValidarObjeto` — validates via RTTI whether an object's properties are filled (skips `Token`) |
| `Routex.Hash.Instancia.pas` | Instance identification | `THashInstance` — generates a unique hash for the running instance |
| `Routex.Core.pas` | Core (skeleton) | `TRoutexCore` — a class not yet implemented (placeholder) |

**Dependencies:** `Routex.pas` depends on `Routex.Client`, `Routex.Config`, `Routex.Routes`, `Routex.Consumer`, and `Routex.ValidarObjeto`. `Routex.Config` no longer references `Routex.ValidarObjeto` (that dependency was removed in this version). `Routex.Routes` depends on `Routex.Client` and `Routex.Config`, plus `System.JSON`. All networking units use Horse and `System.Net.HttpClient`. `Routex.Core` and `Routex.Hash.Instancia` remain independent and are not referenced by any other unit in the current state of the code.

> *Dependência entre units: Routex.pas depende de Routex.Client, Routex.Config, Routex.Routes, Routex.Consumer e Routex.ValidarObjeto. Routex.Config não referencia mais Routex.ValidarObjeto (dependência removida nesta versão). Routex.Routes depende de Routex.Client e Routex.Config, além de System.JSON. Todas as units de rede utilizam o Horse e o System.Net.HttpClient. Routex.Core e Routex.Hash.Instancia continuam independentes e não são referenciadas pelas demais units no estado atual do código.*

## Unit reference / Referência das units

### `Routex.pas` — main facade

Public interface of the framework. Defines the `IRoutex` interface and the `TRoutex` class, which concentrates the configuration, initialization, and shutdown operations of the service.

> *Interface pública do framework. Define a interface `IRoutex` e a classe `TRoutex`, que concentra as operações de configuração, inicialização e encerramento do serviço.*

| Method | Signature | Description |
|---|---|---|
| `Configure` | `procedure Configure(Port: Integer; BaseUrl: String; Prefix: String; Token: String)` | Frees a pre-existing `TConfig` (if any) and creates a new one, storing `Port`, `BaseUrl`, `Prefix`, and `Token` |
| `ValidarConfig` | `function ValidarConfig: boolean` | Instantiates a `TValidarObjeto` and uses it to validate the current `TConfig` via RTTI, storing the validation message in `FInstanceMessage` |
| `Start` | `procedure Start` | Calls `ValidarConfig`; raises an `Exception` if invalid. Frees a pre-existing `TClient` (if any), creates a new one, registers the routes via `RegisterRoutes`, and starts `THorse.Listen` on the configured port |
| `Shutdown` | `procedure Shutdown` | Stops the Horse listener (`THorse.StopListen`) and frees the `TClient` (`FreeAndNil`) |
| `Destroy` | `destructor Destroy; override` | Frees `FClient` and `FConfig` (`FreeAndNil`) when the instance is destroyed |
| `Consumer` | `function Consumer(URL: string): string` | Shortcut to the `Consumer` function in the `Routex.Consumer` unit |
| `GetReturnLog` | `function GetReturnLog: string` | Returns a log string with the time and the last initialization message |
| `Config` | `property TConfig` (read-only) | Exposes the current `TConfig` for external reading |
| `InstanceMessage` | `property String` (read/write) | Status/log message of the instance |

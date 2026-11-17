# Painel de Marketing — ONG Portal Saúde

Protótipo inicial isolado em `/painel-marketing/`, mantido no repositório institucional sem alterar as páginas públicas do site.

## Estado atual
- Interface responsiva com navegação e módulos: visão geral, contatos/captação, busca responsável de contatos, e-mail marketing, redes sociais, planejamento editorial, Google/estatísticas, relatórios, integrações e configurações.
- Os indicadores são demonstrativos; não há banco conectado, autenticação, coleta de contatos ou envio de e-mails.
- O bot de Instagram existente no cPanel da TargetHost deve ser preservado. Este painel não instala nem duplica o bot; a integração Meta fica pendente.
- O protótipo contém `noindex,nofollow`, mas isso não é controle de acesso. Não publicar como painel real nem inserir dados pessoais ou credenciais antes de implementar autenticação e backend.

## Próximas etapas de implementação
1. Confirmar plano TargetHost, tipo de painel (cPanel/Plesk), versão PHP, MySQL/MariaDB, SSL, subdomínio e acesso FTP/SFTP.
2. Criar aplicação PHP no servidor, fora do diretório público guardar segredos e configurar ambiente.
3. Implementar login seguro, sessões, perfis, CSRF, validação, limitação de tentativas, auditoria e backups.
4. Criar banco MySQL usando o schema inicial em `database/schema.sql`; revisar e adaptar antes de produção.
5. Conectar o bot Instagram já existente via endpoint/API documentado pelo próprio bot e depois configurar Meta OAuth/permissões/tokens.
6. Conectar Google Analytics e Search Console por OAuth com escopos mínimos.
7. Selecionar provedor de e-mail; autenticar domínio com SPF, DKIM e DMARC; implementar descadastramento e lista de supressão.
8. Implementar pesquisa de contatos apenas em fontes e condições permitidas, documentando finalidade, origem, base legal, retenção e oposição. E-mail público não equivale a autorização automática para marketing.
9. Testar em ambiente de homologação, revisar LGPD e segurança, e só então publicar em subdomínio privado.

## Princípios
- Nunca salvar senhas, tokens, chaves API ou dados de pacientes no GitHub.
- Não importar listas sem origem e base legal documentadas.
- Não disparar campanhas para contatos sem validação da finalidade e dos requisitos legais.
- O painel de marketing não deve armazenar informações clínicas ou dados sensíveis de saúde desnecessários.
- O site institucional em produção não deve ser alterado por esta pasta.

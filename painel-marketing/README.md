# Painel de Marketing — ONG Portal Saúde

Protótipo inicial isolado em `/painel-marketing/`, mantido no repositório institucional sem alterar as páginas públicas do site.

## Estado atual
- Interface responsiva com navegação e módulos: visão geral, contatos/captação, busca responsável de contatos, e-mail marketing, redes sociais, planejamento editorial, Radar da Saúde (Google Trends/Alerts/notícias), Planos de Saúde/ANS, Biblioteca Jurídica (legislação, ANS, STJ, CNJ e OAB), Gerador de Conteúdo educativo, SEO/visibilidade (Search Console, Analytics e ferramentas de palavras-chave), Google/estatísticas, relatórios, integrações e configurações.
- Os indicadores são demonstrativos; não há banco conectado, autenticação, coleta de contatos, monitoramento automático de notícias, publicação social ou envio de e-mails. Os novos módulos oferecem atalhos para ferramentas e fontes gratuitas e um gerador local de briefings educativos; integrações automáticas dependem de credenciais, APIs e backend.
- O bot de Instagram existente no cPanel da TargetHost deve ser preservado. Este painel não instala nem duplica o bot; a integração Meta fica pendente.
- O protótipo contém `noindex,nofollow`, mas isso não é controle de acesso. Não publicar como painel real nem inserir dados pessoais ou credenciais antes de implementar autenticação e backend.

## Próximas etapas de implementação
1. Confirmar plano TargetHost, tipo de painel (cPanel/Plesk), versão PHP, MySQL/MariaDB, SSL, subdomínio e acesso FTP/SFTP.
2. Criar aplicação PHP no servidor, fora do diretório público guardar segredos e configurar ambiente.
3. Implementar login seguro, sessões, perfis, CSRF, validação, limitação de tentativas, auditoria e backups.
4. Criar banco MySQL usando o schema inicial em `database/schema.sql`; revisar e adaptar antes de produção.
5. Conectar o bot Instagram já existente via endpoint/API documentado pelo próprio bot e depois configurar Meta OAuth/permissões/tokens.
6. Conectar Google Analytics e Search Console por OAuth com escopos mínimos.
7. Integrar fontes de pesquisa e monitoramento (Google Trends/Alerts, ANS e fontes oficiais), respeitando termos de uso, limites e revisão editorial; integrar Search Console/Analytics por OAuth.\n8. Selecionar provedor de e-mail; autenticar domínio com SPF, DKIM e DMARC; implementar descadastramento e lista de supressão.
9. Implementar pesquisa de contatos apenas em fontes e condições permitidas, documentando finalidade, origem, base legal, retenção e oposição. E-mail público não equivale a autorização automática para marketing.
10. Testar em ambiente de homologação, revisar LGPD e segurança, e só então publicar em subdomínio privado.

## Princípios
- Nunca salvar senhas, tokens, chaves API ou dados de pacientes no GitHub.
- Não importar listas sem origem e base legal documentadas.
- Não disparar campanhas para contatos sem validação da finalidade e dos requisitos legais.
- O painel de marketing não deve armazenar informações clínicas ou dados sensíveis de saúde desnecessários.
- O site institucional em produção não deve ser alterado por esta pasta.

USE loja_tech;

-- 1. View para esconder o CPF e dados sensíveis dos clientes (Segurança / LGPD)
-- Por que View? Permite dar acesso de leitura ao marketing sem expor o CPF da tabela original.
CREATE OR REPLACE VIEW vw_clientes_publico AS
SELECT id_cliente, nome, email, telefone
FROM clientes;

-- 2. View só com produtos acessíveis / promoção (abaixo de R$ 500,00)
-- Por que View? Permite que o sistema faça filtros adicionais (WHERE / ORDER BY) direto nela.
CREATE OR REPLACE VIEW vw_produtos_promocao AS
SELECT nome, preco, estoque
FROM produtos
WHERE preco < 500.00;

-- 3. View só com pedidos pendentes (para a equipe de atendimento)
-- Por que View? Facilita a consulta diária sem precisar repetir o filtro WHERE toda vez.
CREATE OR REPLACE VIEW vw_pedidos_pendentes AS
SELECT id_pedido, id_cliente, data_pedido, valor_total
FROM pedidos
WHERE status = 'pendente';

-- 4. View mostrando o produto junto com o nome da categoria (INNER JOIN)
-- Por que View? Esconde a complexidade do JOIN para relatórios ou ferramentas de BI.
CREATE OR REPLACE VIEW vw_produtos_categorias AS
SELECT p.nome AS produto, c.nome AS categoria, p.preco
FROM produtos p
INNER JOIN categorias c ON p.id_categoria = c.id_categoria;

-- 5. View com o resumo de compras por cliente (GROUP BY)
-- Por que View? Permite cruzar o total gasto por cliente com outras tabelas em consultas futuras.
CREATE OR REPLACE VIEW vw_total_por_cliente AS
SELECT id_cliente, COUNT(*) AS qtd_pedidos, SUM(valor_total) AS total_gasto
FROM pedidos
GROUP BY id_cliente;

-- ======================================================
-- TESTANDO AS VIEWS (Como se fossem tabelas normais)
-- ======================================================
SELECT * FROM vw_clientes_publico;
SELECT * FROM vw_produtos_promocao;
SELECT * FROM vw_pedidos_pendentes;
SELECT * FROM vw_produtos_categorias;
SELECT * FROM vw_total_por_cliente;
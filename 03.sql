use loja_tech;


-- 1, Listagem básica de clientes (nome e e-mail)
Select nome,email
From clientes;


-- 2, Filtro por faixa de preço (produtos abaixo de R$500,00)
select nome, preco
from produtos
where preco <500.00;


-- 3. Filtro por status de pedido ('pendente')
select *
from pedidos
where status = 'pendente';


-- 4. Ordenação de catágolo (do mais caro para o mais barato)
select nome, preco
from produtos
order by preco desc;


-- 5. Busca parcial (produtos com "Monitor" no nome)
select id_produto, nome, preco 
from produtos
where nome like '%Monitor%';


-- 6. Filtro composto (periférico = id_categoria 3 e estoque >40)
select nome, estoque
from produtos
where id_categoria =3
and estoque >40;


-- 7. Contagem total de registros com alias total_clientes
select count(*) As total_clientes
from clientes;


-- 8. Soma de valores com alias faturamento_bruto
select sum(valor_total) As faturamento_bruto
from pedidos;


-- 9. Junção simples entre duas tabelas (produto e sua categoria)
select p.nome As produto, c.nome As categorias
from produtos p
inner join categorias c ON p.id_categoria = c.id_categoria;


-- 10. Junção com filtro por cliente ('Ana Silva')
select pe.id_pedido, pe.status, pe.valor_total
from pedidos pe
inner join clientes c ON pe.id_cliente = c.id_cliente
where c.nome = 'Ana Silva';
-- Criação de banco de dados para o desafio com o cenario E-commerce --
 
create database ecommerce;
use ecommerce;

-- Table Criente 
create table clients(
	idClient int not null auto_increment primary key,
    Fname varchar(20),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    constraint unique_cpf_client unique (CPF)    
);

-- Tabela Endereço
create table address(
	idAddress int not null auto_increment primary key,
    idEndClient int,
    Rua varchar(20),
    Numero int,
    Bairro varchar(20),
    Pais varchar(20),
    CEP int, 
    constraint fk_address_client foreign key (idEndClient) references clients(idClient)
);

-- Table Produto 
create table product(
	idProduct int not null auto_increment primary key,
    Pname varchar(20) not null,
    Category enum('Eletronico', 'Vestimenta', 'Alimento', 'Ferramentas')not null,    
    Avaliacao float default 0    
);

-- Table Pagamento 
create table payment(
	idPayment int not null auto_increment primary key,
    idPaymentOrder int,
    paymentTyper enum('Dinheiro', 'Cartão','Boleto') not null,
    paymentStatus enum('Cancelado', 'Concluido') not null,
    paymentValue float default 0,
    constraint fk_payment_orders foreign key (idPaymentOrder) references orders(idOrder)
);

-- Table Pedido 
create table orders(
	idOrder int not null auto_increment primary key,
    idOrderClient int,
   idOrderPayment int,
    orderStatus enum('Concluido', 'Processando', 'Cancelado') not null,
    orderDescription varchar(245),
    sendValue float default 0,
    paymentCash boolean default false,
    constraint fk_order_client foreign key (idOrderClient) references clients(idClient),
   constraint fk_order_payment foreign key (idOrderPayment) references payment (idPayment)
);
-- Table Estoque 
create table productStorage(
	idProductStorage int not null auto_increment primary key,    
    idStoreLocation int,
    quantity int default 0,
    constraint fk_storege_local foreign key (idStoreLocation) references address(idAddress)
);

-- Table Fornecedor
create table supplier(
	idSupplier int not null auto_increment primary key,
    socialName varchar(25)not null,
    cnpj char(15)not null,
    contacto varchar(25) not null,
    constraint unique_supplier unique(cnpj)
);

-- Table Vendedor
create table seller(
	idSeller int not null auto_increment primary key,
    idSellerAddress int,
    socialName varchar(25)not null,
    AbstName varchar(25)not null,
    cnpj char(15)not null,
    cpf char(9)not null,
    contacto varchar(25) not null,
    constraint unique_seller unique(socialName,cnpj,cpf),
    constraint fk_seller_address foreign key (idSellerAddress) references address (idAddress)
);

create table productSeller(
   idPseller int,
   idProduct int,
   prodQuantity int default 1,
   primary key (idPseller,idProduct),
   constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
   constraint fk_product_product foreign key (idProduct) references product(idProduct)
);
create table productOrder(
   idPOorder int,
   idPOproduct int,
   poStatus enum('Disponivel', 'Sem estoque') default 'Disponivel',
   podQuantity int default 1,
   primary key (idPOproduct,idPOorder),
   constraint fk_POproduct_product foreign key (idPOproduct) references product(idProduct),
   constraint fk_POproduct_order foreign key (idPOorder) references orders(idOrder)
);
create table storageLocation(
   idLproduct int,
   idLstorage int,
   idLaddress int,
   primary key (idLproduct,idLstorage,idLaddress),
   constraint fk_Lproduct_product foreign key (idLproduct) references product(idProduct),
   constraint fk_Lproduct_postorage foreign key (idLstorage) references productStorage(idProductStorage),
   constraint fk_Lproduct_address foreign key (idLaddress) references address(idAddress)
);
create table productSupplier(
   idPsSuppliar int,
   idPsProduct int,
   psQuantaty int default 0,
   primary key (idPsSuppliar,idPsProduct),
   constraint fk_psproduct_supplier foreign key (idPsSuppliar) references supplier(idSupplier),
   constraint fk_psproduct_product foreign key (idPsProduct) references product(idProduct)
);

show tables;


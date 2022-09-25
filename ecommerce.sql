create database ecommerce;
use ecommerce;

create table person( 
	personId int auto_increment primary key,
    personName varchar(45) not null,
    document varchar(20) not null,
    address varchar(45),
    kind enum('pFisica','Pjuridica'),
    constraint unique_document_person unique (document)
    );
    
create table product( 
	productId int auto_increment primary key,
    productName varchar(45) not null,
    score float default 0,
    classification bool default false,
    category enum('eletronico','vestuario','livro','brinquedo','alimento','moveis') not null,
    size varchar(30),
    price float not null
    );
    
    create table shippingCompany( 
	SCId int auto_increment primary key,
    SCName varchar(45) not null,
    document varchar(20) not null
    );

    create table provider( 
	providerId int auto_increment primary key,
    personProviderId int,
    personName varchar(45) not null,
    kind enum('terceiro','loja'),
    constraint fk_person_provider foreign key (personProviderId) references person(personId)
    
    );
       create table productProvider( 
	productProviderId int auto_increment primary key,
    productIdFK int,
    providerIdFK int,
     constraint fk_provider foreign key (providerIdFK) references provider(providerId),
      constraint fk_product foreign key (productIdFK) references product(productId)
       
    );
    
    create table providerStorage( 
	storageId int auto_increment primary key,
    address varchar(45),
    ammount int not null default 0,
    providerStorageIdFK int,
    productProviderIdFK int,
	constraint fk_provider_storage foreign key (providerStorageIdFK) references provider(providerId),
	constraint fk_product_provider foreign key (productProviderIdFK) references productProvider(productProviderId)
       
    );
  
    create table paymentMethod( 
	methodId int auto_increment primary key,
    installment bool not null,
    method enum('pix','cartão de crédito','cartão de débito', 'boleto')
    );
    
    create table orders( 
	orderId int auto_increment primary key,
    installmentNumber int default 1,
    paymentMethodId int,
    constraint fk_payment foreign key (paymentMethodId) references paymentMethod(methodId)
    );  
         create table shipping( 
	shippingId int auto_increment primary key,
    shippingCompanyId int, 
    orderIdFK int,
    deliveryDate date,
    shippingFare float default 0,
    status enum('em separação','enviado','recebido'),
   constraint fk_shippingCompanyIdentification foreign key (shippingCompanyId) references shippingCompany(SCId),
   constraint fk_orderIdentification foreign key (orderIdFK) references orders(orderId)
    );
    create table productOrders( 
	productOrdersId int auto_increment primary key,
    orderIdFK int,
    productFK int,
    shippinFK int,
    ammount int,
	constraint fk_order_product foreign key (orderIdFK) references orders(orderId),
	constraint fk_products_in_this_order foreign key (productFK) references product(productId)	
    );
     show tables;
     desc orders;
     desc person;
     
     

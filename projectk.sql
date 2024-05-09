
use project;

create table borrower(borrower_CardNo int primary key,
borrower_BorrowerName varchar(50),
borrower_BorrowerAddress varchar(50),
borrower_BorrowerPhone varchar(30));

select * from borrower;

create table publisher(publisher_PublisherName varchar(100) primary key,
publisher_PublisherAddress varchar(100),
publisher_PublisherPhone varchar(30));

select * from publisher;

create table librarybranch(library_branch_BranchId tinyint primary key auto_increment,
library_branch_BranchName varchar(30),
library_branch_BranchAddress varchar(30));

select * from librarybranch;

create table books(book_BookID tinyint primary key,
book_Title varchar(50),
book_PublisherName varchar(50),
foreign key (book_PublisherName) references publisher(publisher_PublisherName) on update cascade);

select * from books;

create table authors(authorId int primary key auto_increment,
book_authors_AuthorName varchar(150),
book_authors_BookID tinyint,
foreign key (book_authors_BookID) references books(book_BookID) on update cascade);

select * from authors;
select count(*) from authors;

create table bookcopies(copiesID int primary key auto_increment,
book_copies_BookID tinyint,
foreign key (book_copies_BookID) references books(book_BookID) on update cascade, 
book_copies_BranchID tinyint,
foreign key (book_copies_BranchID) references librarybranch(library_branch_BranchId) on update cascade,
book_copies_No_Of_Copies tinyint);

select * from bookcopies;
select count(*) from bookcopies;

create table bookloans(LoansId int primary key auto_increment,
book_loans_BookID tinyint,
foreign key (book_loans_BookID) references books(book_BookID) on update cascade,
book_loans_BranchID tinyint,
foreign key (book_loans_BranchID) references librarybranch(library_branch_BranchId) on update cascade,
book_loans_CardNo int,
foreign key (book_loans_CardNo) references borrower(borrower_CardNo) on update cascade,
book_loans_DateOut varchar(30),
book_loans_DueDate varchar(30));

select * from bookloans;
select count(*) from bookloans;






-- 1.How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?

select bo.book_Title, lb.library_branch_BranchName,bc.book_copies_No_Of_Copies
from books bo
join bookcopies bc
on bo.book_BookID=bc.book_copies_BookID
join librarybranch lb
on bc.book_copies_BranchID=lb.library_branch_BranchId
where lb.library_branch_BranchName='Sharpstown' and bo.book_Title='The Lost Tribe';



-- 2.How many copies of the book titled "The Lost Tribe" are owned by each library branch?

select bo.book_Title, lb.library_branch_BranchName,bc.book_copies_No_Of_Copies
from books bo
join bookcopies bc
on bo.book_BookID=bc.book_copies_BookID
join librarybranch lb
on bc.book_copies_BranchID=lb.library_branch_BranchId
where bo.book_Title='The Lost Tribe';



-- 3.Retrieve the names of all borrowers who do not have any books checked out.

select b.borrower_BorrowerName
from borrower b
left join bookloans bl
on b.borrower_CardNo=bl.book_loans_CardNo
where bl.book_loans_CardNo is null;


-- 4.For each book that is loaned out from the "Sharpstown" branch and whose DueDate is 2/3/18, retrieve the book title, the borrower's name, and the borrower's address.

select lb.library_branch_BranchName,bl.book_loans_DueDate,bo.book_Title,b.borrower_BorrowerName,b.borrower_BorrowerAddress
from librarybranch lb
join bookloans bl
on lb.library_branch_BranchId=bl.book_loans_BranchID
join books bo
on bl.book_loans_BookID=book_BookID
join borrower  b
on b.borrower_CardNo=bl.book_loans_CardNo
where lb.library_branch_BranchName='sharpstown' and bl.book_loans_DueDate='2/3/18';


-- 5.For each library branch, retrieve the branch name and the total number of books loaned out from that branch


-- 6.Retrieve the names, addresses, and number of books checked out for all borrowers who have more than five books checked out.
 


-- 7.For each book authored by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central".

select a.book_authors_AuthorName,bo.book_Title,bc.book_copies_No_Of_Copies,lb.library_branch_BranchName
from authors a
join books bo
on a.book_authors_BookID=bo.book_BookID
join bookcopies bc
on bo.book_BookID=bc.book_copies_BookID
join librarybranch lb
on bc.book_copies_BranchID=lb.library_branch_BranchId
where a.book_authors_AuthorName='Stephen King' and lb.library_branch_BranchName='Central';


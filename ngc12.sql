CREATE TABLE authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(255) UNIQUE,
    country VARCHAR(255)
);

CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255) UNIQUE,
    author_id INT,
    publication_year INT,
    available_quantity INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

CREATE TABLE book_loans (
    loan_id INT PRIMARY KEY,
    book_id INT,
    borrower_name VARCHAR(255),
    loan_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- Add constraints to ensure date integrity
ALTER TABLE book_loans
ADD CONSTRAINT check_loan_dates CHECK (loan_date <= return_date);

-- Create indexes for faster retrieval of books by 'author_id' and finding overdue book loans
CREATE INDEX idx_books_author_id ON books(author_id);
CREATE INDEX idx_overdue_loans ON book_loans(return_date) WHERE return_date < CURRENT_DATE;

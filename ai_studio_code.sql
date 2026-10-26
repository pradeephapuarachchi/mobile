-- 1. Transactions Table
CREATE TABLE IF NOT EXISTS transactions (
    id TEXT PRIMARY KEY NOT NULL,
    type TEXT CHECK(type IN ('INCOME', 'EXPENSE')) NOT NULL,
    amount REAL NOT NULL CHECK(amount > 0),
    category_id TEXT NOT NULL,
    date TEXT NOT NULL, -- Format: YYYY-MM-DD
    description TEXT,
    payment_method TEXT CHECK(payment_method IN ('CASH', 'BANK_TRANSFER', 'CARD', 'CHEQUE')) DEFAULT 'CASH',
    invoice_no TEXT,
    created_at INTEGER NOT NULL,
    updated_at INTEGER,
    FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE RESTRICT
);

-- Fast Monthly Aggregation Indexes
CREATE INDEX IF NOT EXISTS idx_transactions_date ON transactions(date);
CREATE INDEX IF NOT EXISTS idx_transactions_month ON transactions(substr(date, 1, 7));
CREATE INDEX IF NOT EXISTS idx_transactions_type_month ON transactions(type, substr(date, 1, 7));

-- 2. Categories Table
CREATE TABLE IF NOT EXISTS categories (
    id TEXT PRIMARY KEY NOT NULL,
    name_si TEXT NOT NULL,
    name_en TEXT NOT NULL,
    type TEXT CHECK(type IN ('INCOME', 'EXPENSE')) NOT NULL,
    icon TEXT NOT NULL,
    color TEXT NOT NULL,
    is_custom INTEGER DEFAULT 0
);

-- 3. Business Profile Table
CREATE TABLE IF NOT EXISTS business_profile (
    id INTEGER PRIMARY KEY CHECK (id = 1),
    name TEXT NOT NULL,
    owner_name TEXT,
    reg_number TEXT,
    currency TEXT DEFAULT 'LKR',
    phone TEXT,
    address TEXT,
    updated_at INTEGER
);
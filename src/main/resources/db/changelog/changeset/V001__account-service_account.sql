CREATE TABLE owner (
    id         BIGSERIAL PRIMARY KEY UNIQUE,
    type       VARCHAR(128) DEFAULT 0 NOT NULL,
    owner_id   BIGINT NOT NULL UNIQUE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE currency (
    id       BIGSERIAL    PRIMARY KEY,
    country  VARCHAR(128) NOT NULL,
    currency VARCHAR(128) NOT NULL,
    code     CHAR(3)      NOT NULL,
    number   CHAR(3)      NOT NULL
);

CREATE TABLE account (
    id             BIGSERIAL     PRIMARY KEY UNIQUE,
    number         VARCHAR(20)   NOT NULL UNIQUE CHECK (LENGTH(number) >= 12 AND number SIMILAR TO '[0-9]+'),
    owner_id       BIGINT        NOT NULL,
    type           VARCHAR(128)  NOT NULL,
    currency_id    VARCHAR(3)    NOT NULL,
    status         VARCHAR(64)   NOT NULL DEFAULT 0,
    status_details VARCHAR(128),
    created_at     TIMESTAMPTZ   DEFAULT CURRENT_TIMESTAMP,
    updated_at     TIMESTAMPTZ   ON UPDATE CURRENT_TIMESTAMP,
    closed_at      TIMESTAMPTZ,
    version        BIGINT        NOT NULL DEFAULT 0

    CONSTRAINT fk_account_owner FOREIGN KEY (owner_id) REFERENCES owner (id),
    CONSTRAINT fk_account_currency FOREIGN KEY (currency_id) REFERENCES currency (id)
);

CREATE INDEX index_number_payment ON account (number);
CREATE INDEX index_owner_id ON account (owner_id);

INSERT INTO currency (country, currency, code, number) VALUES ('USA', 'US Dollar', 'USD', '840');
INSERT INTO currency (country, currency, code, number) VALUES ('The European Union', 'Euro', 'EUR', '978');
INSERT INTO currency (country, currency, code, number) VALUES ('Russia', 'Russian Ruble', 'RUB', '643');
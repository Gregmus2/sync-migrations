CREATE TABLE IF NOT EXISTS device_tokens
(
    device_token TEXT PRIMARY KEY NOT NULL,
    user_id      TEXT,
    group_id     TEXT,
    last_sync    INTEGER
);
CREATE TABLE IF NOT EXISTS operations
(
    id             SERIAL PRIMARY KEY NOT NULL,
    device_token   TEXT               NOT NULL,
    group_id       TEXT               NOT NULL,
    operation_type TEXT               NOT NULL,
    sql            TEXT               NOT NULL,
    args           TEXT,
    created_at     INTEGER            NOT NULL
);
CREATE TABLE IF NOT EXISTS related_entities
(
    operation_id INTEGER NOT NULL,
    entity_id    TEXT    NOT NULL,
    entity_name  TEXT    NOT NULL,
    PRIMARY KEY (operation_id, entity_id, entity_name),
    FOREIGN KEY (operation_id) REFERENCES operations (id) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE INDEX operations_group_id_idx ON operations (group_id, created_at);
CREATE INDEX operations_conflicts_query_idx ON operations (operation_type, group_id, id);

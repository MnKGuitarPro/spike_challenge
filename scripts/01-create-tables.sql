-- Crea la tabla para los datos del archivo "data_todotipo.csv"
CREATE TABLE data_todotipo (
                id_new_todo SMALLINT NOT NULL,
                corr_todo VARCHAR(4),
                popularity_todo TINYINT,
                danceability_todo FLOAT,
                energy_todo FLOAT,
                key_todo INT,
                loudness_todo FLOAT,
                mode_todo INT,
                speechiness_todo FLOAT,
                acousticness_todo FLOAT,
                instrumentalness_todo FLOAT,
                liveness_todo FLOAT,
                valence_todo FLOAT,
                tempo_todo FLOAT,
                duration_todo FLOAT,
                time_signature_todo INT,
                CONSTRAINT data_todotipo_pk PRIMARY KEY (id_new_todo)
)
-- Crea la tabla para los datos del archivo "data_test.csv"
CREATE TABLE data_test (
                id_new_test SMALLINT NOT NULL,
                corr_test VARCHAR(4),
                popularity_test TINYINT,
                danceability_test FLOAT,
                energy_test FLOAT,
                key_test INT,
                loudness_test FLOAT,
                mode_test INT,
                speechiness_test FLOAT,
                acousticness_test FLOAT,
                instrumentalness_test FLOAT,
                liveness_test FLOAT,
                valence_test FLOAT,
                tempo_test FLOAT,
                duration_test FLOAT,
                time_signature_test INT,
                CONSTRAINT id_new_test_pk PRIMARY KEY (id_new_test)
)
-- Crea la tabla para los datos del archivo "data_reggaeton.csv"
CREATE TABLE data_reggeaton (
                id_new SMALLINT NOT NULL,
                corr VARCHAR(4),
                popularity TINYINT,
                danceability FLOAT,
                energy FLOAT,
                key_1 INT,
                loudness FLOAT,
                mode INT,
                speechiness FLOAT,
                acousticness FLOAT,
                instrumentalness FLOAT,
                liveness FLOAT,
                valence FLOAT,
                tempo FLOAT,
                duration FLOAT,
                CONSTRAINT id_new_pk PRIMARY KEY (id_new)
)
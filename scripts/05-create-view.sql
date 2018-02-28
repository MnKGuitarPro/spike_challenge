-- Vista consolidación "data_todotipo.csv" y "data_reggaeton.csv"

CREATE VIEW view_consolidado AS
SELECT 
	TODOS.corr_todo AS corr
	,TODOS.popularity_todo AS popularity
	,TODOS.danceability_todo AS danceability
	,TODOS.energy_todo AS energy
	,TODOS.key_todo AS key_1
	,TODOS.loudness_todo AS loudness
	,TODOS.mode_todo AS mode
	,TODOS.speechiness_todo AS speechiness
	,TODOS.acousticness_todo AS acousticness
	,TODOS.instrumentalness_todo AS instrumentalness
	,TODOS.liveness_todo AS liveness
	,TODOS.valence_todo AS valence
	,TODOS.tempo_todo AS tempo
	,TODOS.duration_todo AS duration
	,TODOS.time_signature_todo AS time_signature
	,TODOS.id_new_todo AS id_new
	FROM data_todotipo TODOS
UNION ALL
SELECT 
	REGGAE.corr
	,REGGAE.popularity
	,REGGAE.danceability
	,REGGAE.energy
	,REGGAE.key_1
	,REGGAE.loudness
	,REGGAE.mode
	,REGGAE.speechiness
	,REGGAE.acousticness
	,REGGAE.instrumentalness
	,REGGAE.liveness
	,REGGAE.valence
	,REGGAE.tempo
	,REGGAE.duration
	,'' AS time_signature
	,REGGAE.id_new
	FROM data_reggeaton REGGAE
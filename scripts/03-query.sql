-- Query N°1

SELECT COUNT(*) AS 'Filas nulas de reggaeton' FROM data_reggeaton WHERE duration IS NULL;
SELECT COUNT(*) AS 'Filas nulas de todo el dataset' FROM data_todotipo WHERE duration_todo IS NULL;

-- Query N°2

SELECT
	MIN(popularity_todo) AS 'Popularidad mín.',MAX(popularity_todo) AS 'Popularidad máx.',AVG(popularity_todo) AS 'Popularidad prom.'
	,MIN(danceability_todo) AS 'Bailabilidad mín.',MAX(danceability_todo) AS 'Bailabilidad máx.',AVG(danceability_todo) AS 'Bailabilidad prom.'
	,MIN(energy_todo) AS 'Energía mín.',MAX(energy_todo) AS 'Energía máx.',AVG(energy_todo) AS 'Energía prom.'
	,MIN(loudness_todo) AS 'Ruido mín.',MAX(loudness_todo) AS 'Ruido máx.',AVG(loudness_todo) AS 'Ruido prom.'
	,MIN(speechiness_todo) AS 'Discurso mín.',MAX(speechiness_todo) AS 'Discurso máx.',AVG(speechiness_todo) AS 'Discurso prom.'
	,MIN(acousticness_todo) AS 'Acústica mín.',MAX(acousticness_todo) AS 'Acústica máx.',AVG(acousticness_todo) AS 'Acústica prom.'
	,MIN(instrumentalness_todo) AS 'Instrumentalización mín.',MAX(instrumentalness_todo) AS 'Instrumentalización máx.',AVG(instrumentalness_todo) AS 'Instrumentalización prom.'
	,MIN(liveness_todo) AS 'Viveza mín.',MAX(liveness_todo) AS 'Viveza máx.',AVG(liveness_todo) AS 'Viveza prom.'
	,MIN(valence_todo) AS 'Valencia mín.',MAX(valence_todo) AS 'Valencia máx.',AVG(valence_todo) AS 'Valencia prom.'
	,MIN(tempo_todo) AS 'Tempo mín.',MAX(tempo_todo) AS 'Tempo máx.',AVG(tempo_todo) AS 'Tempo prom.'
	,MIN(duration_todo) AS 'Duración mín.',MAX(duration_todo) AS 'Duración máx.',AVG(duration_todo) AS 'Duración prom.'
	FROM data_todotipo 
		WHERE 
			duration_todo IS NOT NULL;

-- Query N°3

SELECT
	AVG(popularity) AS 'Popularidad prom.',STDEVP(popularity) AS 'Popularidad StdDev.'
	,AVG(danceability) AS 'Bailabilidad prom.',STDEVP(danceability) AS 'Bailabilidad StdDev.'
	,AVG(energy) AS 'Energía prom.',STDEVP(energy) AS 'Energía StdDev.'
	,AVG(loudness) AS 'Ruido prom.',STDEVP(loudness) AS 'Ruido StdDev.'
	,AVG(speechiness) AS 'Discurso prom.',STDEVP(speechiness) AS 'Discurso StdDev.'
	,AVG(acousticness) AS 'Acústica prom.',STDEVP(acousticness) AS 'Acústica StdDev.'
	,AVG(instrumentalness) AS 'Instrumentalización prom.',STDEVP(instrumentalness) AS 'Instrumentalización StdDev.'
	,AVG(liveness) AS 'Viveza prom.',STDEVP(liveness) AS 'Viveza StdDev.'
	,AVG(valence) AS 'Valencia prom.',STDEVP(valence) AS 'Valencia StdDev.'
	,AVG(tempo) AS 'Tempo prom.',STDEVP(tempo) AS 'Tempo StdDev.'
	,AVG(duration) AS 'Duración prom.',STDEVP(duration) AS 'Duración StdDev.'
	FROM data_reggeaton;

-- Query N°4

EXEC clasificador_1;

-- Query N°5

EXEC clasificador_2;

-- Query N°6

EXEC clasificador_3;

-- Query N°7

EXEC clasificador_1_test;

-- Query N°8

EXEC clasificador_2_test;

-- Query N°9

EXEC clasificador_3_test;

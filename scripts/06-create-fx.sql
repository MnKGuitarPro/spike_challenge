-- Primer clasificador

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION esReggaeton(@id SMALLINT)
RETURNS BIT
AS
BEGIN
	DECLARE @danceability_min FLOAT = (SELECT MIN(danceability) FROM data_reggeaton);
	DECLARE @danceability_max FLOAT = (SELECT MAX(danceability) FROM data_reggeaton);
	DECLARE @danceability FLOAT = (SELECT danceability FROM view_consolidado WHERE id_new=@id);

	DECLARE @energy_min FLOAT = (SELECT MIN(energy) FROM data_reggeaton);
	DECLARE @energy_max FLOAT = (SELECT MAX(energy) FROM data_reggeaton);
	DECLARE @energy FLOAT = (SELECT energy FROM view_consolidado WHERE id_new=@id);
	
	DECLARE @res BIT = 0;
	
	IF((@danceability >= @danceability_min) AND (@danceability <= @danceability_max))
	BEGIN
		IF((@energy >= @energy_min) AND (@energy <= @energy_max))
		BEGIN
			SET @res=1;
		END
	END
	
	RETURN @res;
END
GO

-- Segundo clasificador

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION esReggaeton_2(@id SMALLINT)
RETURNS BIT
AS
BEGIN
	DECLARE @speechiness_min FLOAT = (SELECT MIN(speechiness) FROM data_reggeaton);
	DECLARE @speechiness_max FLOAT = (SELECT MAX(speechiness) FROM data_reggeaton);
	DECLARE @speechiness FLOAT = (SELECT speechiness FROM view_consolidado WHERE id_new=@id);

	DECLARE @valence_min FLOAT = (SELECT MIN(valence) FROM data_reggeaton);
	DECLARE @valence_max FLOAT = (SELECT MAX(valence) FROM data_reggeaton);
	DECLARE @valence FLOAT = (SELECT valence FROM view_consolidado WHERE id_new=@id);

	DECLARE @energy_min FLOAT = (SELECT MIN(energy) FROM data_reggeaton);
	DECLARE @energy_max FLOAT = (SELECT MAX(energy) FROM data_reggeaton);
	DECLARE @energy FLOAT = (SELECT energy FROM view_consolidado WHERE id_new=@id);

	DECLARE @acousticness_min FLOAT = (SELECT MIN(acousticness) FROM data_reggeaton);
	DECLARE @acousticness_max FLOAT = (SELECT MAX(acousticness) FROM data_reggeaton);
	DECLARE @acousticness FLOAT = (SELECT acousticness FROM view_consolidado WHERE id_new=@id);
	
	DECLARE @res BIT = 0;
	
	IF((@speechiness >= @speechiness_min) AND (@speechiness <= @speechiness_max))
	BEGIN
		IF((@valence >= @valence_min) AND (@valence <= @valence_max))
		BEGIN
			IF((@energy >= @energy_min) AND (@energy <= @energy_max))
			BEGIN
				IF((@acousticness >= @acousticness_min) AND (@acousticness <= @acousticness_max))
				BEGIN
					SET @res=1;
				END
			END
		END
	END
	
	RETURN @res;
END
GO

-- Tercer clasificador

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION esReggaeton_3(@id SMALLINT)
RETURNS BIT
AS
BEGIN
	DECLARE @instrumentalness_min FLOAT = (SELECT MIN(instrumentalness) FROM data_reggeaton);
	DECLARE @instrumentalness_max FLOAT = (SELECT MAX(instrumentalness) FROM data_reggeaton);
	DECLARE @instrumentalness FLOAT = (SELECT instrumentalness FROM view_consolidado WHERE id_new=@id);

	DECLARE @loudness_min FLOAT = (SELECT MIN(loudness) FROM data_reggeaton);
	DECLARE @loudness_max FLOAT = (SELECT MAX(loudness) FROM data_reggeaton);
	DECLARE @loudness FLOAT = (SELECT loudness FROM view_consolidado WHERE id_new=@id);

	DECLARE @liveness_min FLOAT = (SELECT MIN(liveness) FROM data_reggeaton);
	DECLARE @liveness_max FLOAT = (SELECT MAX(liveness) FROM data_reggeaton);
	DECLARE @liveness FLOAT = (SELECT liveness FROM view_consolidado WHERE id_new=@id);

	DECLARE @danceability_min FLOAT = (SELECT MIN(danceability) FROM data_reggeaton);
	DECLARE @danceability_max FLOAT = (SELECT MAX(danceability) FROM data_reggeaton);
	DECLARE @danceability FLOAT = (SELECT danceability FROM view_consolidado WHERE id_new=@id);
	
	DECLARE @res BIT = 0;
	
	IF((@instrumentalness >= @instrumentalness_min) AND (@instrumentalness <= @instrumentalness_max))
	BEGIN
		IF((@loudness >= @loudness_min) AND (@loudness <= @loudness_max))
		BEGIN
			IF((@liveness >= @liveness_min) AND (@liveness <= @liveness_max))
			BEGIN
				IF((@danceability >= @danceability_min) AND (@danceability <= @danceability_max))
				BEGIN
					SET @res=1;
				END
			END
		END
	END
	
	RETURN @res;
END
GO
-- Primer clasificador

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE clasificador_1
AS
BEGIN
	SELECT *,dbo.esReggaeton(id_new) AS '¿Es reggaeton?' FROM view_consolidado ORDER BY id_new;
END
GO

-- Segundo clasificador

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE clasificador_2
AS
BEGIN
	SELECT *,dbo.esReggaeton_2(id_new) AS '¿Es reggaeton?' FROM view_consolidado ORDER BY id_new;
END
GO

-- Tercer clasificador

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE clasificador_3
AS
BEGIN
	SELECT *,dbo.esReggaeton_3(id_new) AS '¿Es reggaeton?' FROM view_consolidado ORDER BY id_new;
END
GO

-- Primer clasificador sobre test

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE clasificador_1_test
AS
BEGIN
	SELECT *,dbo.esReggaeton(id_new_test) AS '¿Es reggaeton?' FROM data_test ORDER BY id_new_test;
END
GO

-- Segundo clasificador sobre test

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE clasificador_2_test
AS
BEGIN
	SELECT *,dbo.esReggaeton_2(id_new_test) AS '¿Es reggaeton?' FROM data_test ORDER BY id_new_test;
END
GO


-- Tercer clasificador sobre test

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE clasificador_3_test
AS
BEGIN
	SELECT *,dbo.esReggaeton_3(id_new_test) AS '¿Es reggaeton?' FROM data_test ORDER BY id_new_test;
END
GO
# SPIKE CHALLENGE

* La siguiente es mi respuesta al problema "*Detector de Reggeatones*" del *Spike Challenge*

## SOLUCIÓN VIA DB

* Cabe destacar que, analizando el total de preguntas, el camino correcto está en una **red neuronal** (usando MATLAB, el cual no tengo a mano ahora, aunque podría haber usado [R][r]), o mejor aun, creando un ***Support Vector Machine*** (usando [*WEKA*][weka]), sin embargo, quise usar esta oportunidad para intentar resolverlo utilizando una aproximación en base a `T-SQL`, usando funciones y procedimientos almacenados y matemática básica
* El objetivo es crear una base de datos con la información provista en los archivos CSV, y trabajar con ella directamente utilizando `T-SQL`

### PRE-REQUISITOS

1. Motor SQL Server
2. Base de datos creada. En mi caso se llama "spike_challenge"

### TRABAJO SOBRE LOS DATASET

1. Utilizar el *script* `scripts/01-create-tables.sql` para crear las tablas que vamos a utilizar
2. Se han creado tres tablas, una por cada archivo recibido. Notar que los tres archivos tienen (prácticamente) la misma estructura. La única diferencia es que *data_reggeaton.csv* no cuenta con el parámetro *time_signature*. A pesar de lo anterior, se decide dejar los datos en tablas diferentes para simplificar el cruce de datos y generación de funciones y *querys* para extraer información. La alternativa de generar todo en una única tabla puede servir si agregamos otro parámetro describiendo el origen de los datos (de qué archivo provienen). Notar además que el primer parámetro ("") se ha creado como un simple correlativo. Se ha optado por esta alternativa para generar la menor cantidad de manipulación sobre los *datasets* originales
3. Los atributos de las tablas se crearon considerando los tipos de datos descritos en la [documentación de la api][spotify-api-doc] de *Spotify*
4. Una vez tengamos las tres tablas en nuestra base de datos, podemos cargar los datos originales. Para ello podemos utilizar el archivo `scripts/02-insert-data.sql`

### RESPUESTA A PREGUNTAS

* A partir de este punto, hasta la última pregunta, usaremos los archivos `scripts/03-query.sql` y `scripts/04-query-result.sql`. El primero tiene una lista enumerada de consultas en `T-SQL` que utilizaremos, y el segundo, los resultados de esas consultas (los cuales se puede ver también [en la siguiente *url*][results]). En base a esos resultados se irán respondiendo una a una las preguntas

#### ANÁLISIS DE LOS DATASET

* La primer pregunta indica:
  > Analiza los dataset data_todotipo.csv y data_reggaeton.csv. ¿Qué puedes decir de los datos, distribuciones, missing, etc? ¿En qué se diferencian? Entregable: texto/imágenes

  * Primero, usaremos las "*Query N°1*", "*Query N°2*" y "*Query N°3*" para obtener algunos datos básicos
    ```sql
    SELECT COUNT(*) AS 'Filas nulas de reggaeton' FROM data_reggeaton WHERE duration IS NULL;
    ...
    SELECT
    MIN(popularity_todo) AS 'Popularidad mín.',MAX(popularity_todo) AS 'Popularidad máx.',AVG(popularity_todo) AS 'Popularidad prom.'
    ,MIN(danceability_todo) AS 'Bailabilidad mín.',MAX(danceability_todo) AS 'Bailabilidad máx.',AVG(danceability_todo) AS 'Bailabilidad prom.'
    ...
    SELECT
    AVG(popularity) AS 'Popularidad prom.',STDEVP(popularity) AS 'Popularidad StdDev.'
    ,AVG(danceability) AS 'Bailabilidad prom.',STDEVP(danceability) AS 'Bailabilidad StdDev.'
    ...
    FROM data_reggeaton;
    ```
  * Acá, primero calculamos los datos vacíos. Tenemos por ejemplo que *data_reggaeton.csv* (el cual llamaremos ***DR***) no tiene datos perdidos, a diferencia de *data_todotipo.csv* (el cual llamaremos ***DAll***) tiene $8$. Tenemos además datos interesantes, como que los valores mínimo y máximo de la "bailabilidad" están en el intervalo $\left[ 0.0627 - 0.942 \right]$ y sin embargo la desvicación estándar para datos de *reggaeton* es de $0.08$. Caso similar ocurre con "instrumentalización", donde tenemos un intervalo total de $\left[ 0 - 0.985 \right]$ con una desviación estándar para el *reggaeton* de $0.03$ sobre el promedio ($0.005$). Con esta información, podemos comenzar en las variables relevantes para la clasificación

#### *MERGE* Y CLASIFICACIÓN

* La segunda pregunta dice:
  > Consolida los dos datasets en uno solo y genera una marca para las canciones que sean reggaeton en base a los datasets. Entregable: csv con dataset y código (si es que usaste).

  * Para este caso, usaremos elementos un poco más elaborados. Primero, crearemos una *view* con el contenido del archivo `scripts/05-create-view.sql`
    ```sql
    CREATE VIEW view_consolidado AS
    SELECT 
    TODOS.corr_todo AS corr
    ...
    UNION ALL
    ...
    FROM data_reggeaton REGGAE
    ```
  * De la vista creada, podemos realizar consultas como `SELECT * FROM view_consolidado;`.  Con los datos de la primer pregunta, crearemos un primer clasificador que nos permita colocar una marca al *set* completo creado en base a la *view*. Para construir los clasificadores, analizaremos los valores de intervalo en que se mueven los datos del *dataset DR* y la desviación estándar en que se mueven los valores dentro del intervalo. Los datos de una columna que representen menor variabilidad indica que esa columna (o variable) es más estable y los datos se agrupan en mayor proporción dentro del intervalo, y por ende, la variable no es más representativa para clasificar.
  * Para ejemplificar lo anterior, consideraré la variable "*danceability*". Ella se mueve en el intervalo $\left[ 0.503 - 0.944 \right]$ y tiene una desviación estándar de $0.08$, por lo que nos puede servir para determinar que, si una canción tiene esa variable dentro de ese intervalo, probablemente sea de *reggaeton*. Lo mismo ocurre con la variable "*energy*" que está entre $\left[ 0.533 - 0.946 \right]$ con desviación estándar de $0.097$.
  * Crearemos un primer clasificador con las variables anteriormente descritas. Para ello, crearemos una función que nos permita identificar si determinada fila está o no dentro del intervalo, y por ende, si corresponde que sea clasificada como "*reggaeton*" (valor $1$) o "*no reggaeton*" (valor $0$). La función la creamos con el contenido del archivo `scripts/06-create-fx.sql` (**de ejecutar todo el código se creará más de una función, pero eso no eso no afecta negativamente los resultados**). Posteriormente, creamos el procedimiento almacenado descrito en `script/07-create-sp.sql` (**en este caso también crearemos más de un *store procedure* de ejecutar todo el código, pero tampoco afecta nuestra análisis**). Ahora, podemos ejecutar el siguiente código ("*Query N°4*" del archivo `scripts/03-query.sql` cuyo resultado está en `scripts/04-query-result.sql` y en el [link público][results]):
    ```sql
    EXEC clasificador_1;
    ```
  * Los resultados también se encuentran en el archivo `csv/spike_challenge_results - Query N°4.csv`

#### ENTRENAMIENTO DE MODELOS

* La tercer pregunta es:
  > Entrena uno o varios modelos (usando el/los algoritmo(s) que prefieras) para detectar qué canciones son reggaeton. Entregable: modelo en cualquier formato y código (si es que usaste)

  * Siguiente la lógica de la pregunta anterior, se han creado dos modelos más. Cada uno agrega más variables de validación para la clasificación. Estos modelos corresponden a las funciones en `T-SQL` llamadas `esReggaeton_2` y `esReggaeton_3` y sus resultados se obtienen invocando el código a continuación (el cual llama a su vez a procedimientos almacenados creados en la pregunta anterior):
    ```sql
    EXEC clasificador_2;
    EXEC clasificador_3;
    ```
  * Al igual que en el punto anterior, los resultados se encuentran en `scripts/04-query-result.sql`, [el documento de *Google Drive*][results], y los archivos `csv/spike_challenge_results - Query N°5.csv` y `csv/spike_challenge_results - Query N°6.csv`

#### COMPARACIÓN DE MODELOS

* La cuarta pregunta hace referencia a:
  > Evalúa tu modelo. ¿Qué performance tiene? ¿Qué métricas usas para evaluar esa performance? ¿Por qué elegiste ese algoritmo en particular? ¿Cómo podrías mejorar la performance ? Entregable: texto/imágenes
  * Dado que no resulta muy práctico evaluar en términos de tiempo de respuesta (por las características variables de la máquina donde se ejecuten los modelos), se deben considerar otras variables. Sin embargo, si queremos comparar entre las tres funciones para el mismo *set* de datos, notamos que las tres demoran lo mismo (1 segundo)
  * Si quisiera evaluar porcentualmente qué algoritmo debiera ser mejor que otro, podría tomar el siguiente índice:
    $\displaystyle\sum_{i}^{n} \frac{\left[ \frac{\sigma_{var_i} \times 100}{max\left( var_i \right) - min\left( var_i \right)} \right]}{100}$
  * Básicamente, se toma porcentual la representatividad de la desviación estándar sobre el intervalo de valores en que se mueve una variable ($var_i$) y luego el porcentaje de la suma de esas representatividades. Así tenemos que si usamos todas las variables el valor es $1$, y que en los clasificadores $1$, $2$ y $3$ tenemos que representan $0.184$, $0.436$ y $0.286$ respectivamente
  * Creo que el modelo podría perfeccionarse encontrando variables más representativas de lo que es el *reggaeton*, y que esas variables justamente no representen a otro estilo musical. Eso y alimentar los *datasets* con conjuntos que permitan sacar matemáticamente valores más certeros

#### PRUEBA DE UN MODELO

* Finalmente, la quinta pregunta dice:
  > Aplica tu modelo sobre el dataset “data_test.csv”, agregándole a cada registro dos nuevos campos: marca_reggaeton (un 1 cuando es reggaetón, un 0 cuando no lo es) y probabilidad_reggaeton (probabilidad de que la canción sea reggaeton). ¿Cómo elegiste cuáles marcar? ¿De qué depende que predigas la existencia de mayor o menor cantidad de reggaetones? Entregable: texto/imágenes
  * Finalmente, para probar los modelos se pueden ejecutar las consultas "*Query N°7*", "*Query N°8*" y "*Query N°9*" del archivo `scripts/03-query.sql` para obtener la clasificación final:
    ```sql
    EXEC clasificador_1_test;
    EXEC clasificador_2_test;
    EXEC clasificador_3_test;
    ```
  * Los resultados se encuentran en `scripts/04-query-result.sql` y [en la *url*][results] entregada previamente
  * Dados los resultados, se evitó calcular una probabilidad, dado que todos los cálculos artiméticos daban resultados que no permitían sacar conclusiones contundentes, aun así, la clasificación se lleva a cabo en base al valor de ciertas variables (dependiendo el clasificador) de una canción determinada. Si las variables están dentro de un intervalo conocido de valores (los cuales ya se saben que pertenecen a canciones del grupo a buscar) entonces la canción se marca con un $1$, caso contrario, con un $0$. Como conclusión, mezclando este análisis con otro hecho en `R` o *WEKA* se puede llegar a conclusiones más completas, pero, en vista de que para este experimento el objetivo era sólo usar `T-SQL` mezclado con *db*, se subentiende que crear una máquina de clasificación en base a `querys` puede resultar *estático* y difícil de interpretar (hay que usar un poco de creatividad matemática)

[r]: https://www.r-project.org/
[weka]: https://www.cs.waikato.ac.nz/ml/weka/
[spotify-api-doc]: https://beta.developer.spotify.com/documentation/web-api/reference/tracks/get-audio-features/
[results]: https://docs.google.com/spreadsheets/d/1eyt5JjwZY-a0_IZdz39Obxnp6y_616HcWcrGNxWKPsA/edit?usp=sharing
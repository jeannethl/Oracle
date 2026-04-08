-----=================================== VALIDACION DE DATOS ======================================
-- ======================================== Version 1.0.5 =========================================
----------------------------------------===== PERSONAS =====
-----CANTIDAD TOTAL DE CLIENTES MIGRADO
SELECT /*+ PARALLEL(tpersona,4) */
    COUNT(1) AS total_clientes_migrados
FROM
    tpersona
WHERE
    cpersona > 2
    AND fhasta = Timestamp '2999-12-31 00:00:00.0';
----- =============================================================================================
-----CANTIDAD DE CLIENTES POR TIPO DE DOCUMENTO
SELECT /*+ PARALLEL(tp,4) */
    tp.ctipoidentificacion AS tipo_documento,
    tid.descripcion        AS desc_tipo_doc,
    COUNT(1)               AS cantidad
FROM
    tpersona tp LEFT OUTER JOIN ttiposidentificacion tid ON (tid.cidioma = 'ES'
                                                             AND tid.ctipoidentificacion = tp.ctipoidentificacion
                                                             AND tid.fhasta = Timestamp '2999-12-31 00:00:00.0')
WHERE
    tp.cpersona > 2
    AND tp.fhasta = Timestamp '2999-12-31 00:00:00.0'
GROUP BY
    tp.ctipoidentificacion,
    tid.descripcion
ORDER BY
    tp.ctipoidentificacion;
----- =============================================================================================
-----CANTIDAD DE CLIENTES POR TIPO PERSONA (NATURAL/JURIDICO)
SELECT /*+ PARALLEL(tpersona,4) */
    ctipopersona AS tipo_persona,
    COUNT(1)     AS cantidad
FROM
    tpersona
WHERE
    cpersona > 2
    AND fhasta = Timestamp '2999-12-31 00:00:00.0'
GROUP BY
    ctipopersona;
----- =============================================================================================
----- =============================================================================================
-----CANTIDAD DE CLIENTES POR ESTATUS
SELECT /*+ PARALLEL(tpersona,4) */
    CESTATUSPERSONA AS estatus_persona,
    COUNT(1)     AS cantidad
FROM
    tpersona
WHERE
    cpersona > 2
    AND fhasta = Timestamp '2999-12-31 00:00:00.0'
GROUP BY
    CESTATUSPERSONA;
----- =============================================================================================
----------------------------------------===== CUENTAS FINANCIERAS =====
-----CANTIDAD TOTAL DE CUENTAS MIGRADO
SELECT /*+ PARALLEL(tc,4) */
    COUNT(1) AS cantidad_cuentas
FROM
    tcuenta tc
WHERE
    tc.cpersona_cliente > 2
    AND tc.csubsistema = '04'
    AND tc.fhasta = Timestamp '2999-12-31 00:00:00.0';
----- =============================================================================================
----- CANTIDAD POR GRUPO DE PRODUCTO (Ahorro, Corriente, etc.)
SELECT /*+ PARALLEL(tc,4)*/
    tc.cgrupoproducto AS cod_linea_negocio,
    tgp.descripcion   AS linea_negocio,
    COUNT(1)          AS cantidad_cuentas
FROM
    tcuenta tc LEFT OUTER JOIN tgruposproducto tgp ON (tgp.cidioma = 'ES'
                                                       AND tgp.cpersona_compania = tc.cpersona_compania
                                                       AND tgp.csubsistema = tc.csubsistema
                                                       AND tgp.cgrupoproducto = tc.cgrupoproducto
                                                       AND tgp.fhasta = tc.fhasta)
WHERE tc.cpersona_cliente > 2
    AND tc.csubsistema = '04'
    AND tc.fhasta = Timestamp '2999-12-31 00:00:00.0'
GROUP BY
    tc.CGRUPOPRODUCTO,
    tgp.descripcion
ORDER BY
    tc.cgrupoproducto;
----- =============================================================================================
----- CANTIDAD POR TIPO DE PRODUCTO (Ahorros, Corrientes, etc.)
SELECT /*+ PARALLEL(tc,4) */
    tc.cgrupoproducto AS cod_linea_negocio,
    tgp.descripcion   AS linea_negocio,
    tc.cproducto      AS cod_producto,
    tpr.descripcion   AS producto,
    COUNT(1)          AS cantidad_cuentas
FROM
    tcuenta tc LEFT OUTER JOIN tgruposproducto tgp ON (tgp.cidioma = 'ES'
                                                       AND tgp.cpersona_compania = tc.cpersona_compania
                                                       AND tgp.csubsistema = tc.csubsistema
                                                       AND tgp.cgrupoproducto = tc.cgrupoproducto
                                                       AND tgp.fhasta = tc.fhasta)
               LEFT OUTER JOIN tproducto tpr ON (tpr.cidioma = 'ES'
                                                 AND tpr.cpersona_compania = tc.cpersona_compania
                                                 AND tpr.csubsistema = tc.csubsistema
                                                 AND tpr.cgrupoproducto = tc.cgrupoproducto
                                                 AND tpr.cproducto = tc.cproducto
                                                 AND tpr.fhasta = tc.fhasta)
WHERE tc.cpersona_cliente > 2
    AND tc.csubsistema = '04'
    AND tc.fhasta = Timestamp '2999-12-31 00:00:00.0'
GROUP BY
    tc.CGRUPOPRODUCTO,
    tgp.descripcion, 
    tc.CPRODUCTO,
    tpr.descripcion
ORDER BY
    tc.cgrupoproducto,
    tc.cproducto;
----- =============================================================================================
----- CANTIDAD DE CUENTAS ACTIVA / INACTIVA
SELECT /*+ PARALLEL(tc,4) */
    tc.cestatuscuenta AS cod_estatus_cuenta,
    tec.descripcion   AS estatus_cuenta,
    COUNT(1)          AS cantidad_cuentas
FROM
    tcuenta tc LEFT OUTER JOIN testatuscuenta tec ON (tec.cidioma = 'ES'
                                                      AND tec.csubsistema = tc.csubsistema
                                                      AND tec.cestatuscuenta = tc.cestatuscuenta
                                                      AND tec.fhasta = tc.fhasta)
WHERE
    tc.cpersona_cliente > 2
    AND tc.csubsistema = '04'
    AND tc.fhasta = Timestamp '2999-12-31 00:00:00.0'
GROUP BY
    tc.cestatuscuenta,
    tec.descripcion
ORDER BY
    tc.cestatuscuenta;
----- =============================================================================================
----------------------------------------===== PERSONA-CUENTAS =====
----- CANTIDAD DE CUENTAS POR PERSONAS
--** En este query si no se especifica un filtro para personas, se buscarán todas las personas
-- existentes, lo cual será
--**contraproducente ya que el tiempo del query será demasiado exagerado.
--====VERSION 1
SELECT /*+ PARALLEL(tcp,4) PARALLEL(tp,4) */
    tcp.cpersona   AS penumper,
    tp.nombrelegal AS nombre_persona,
    COUNT(1)       AS cantidad_cuentas
FROM
    tcuentaspersona tcp JOIN tpersona tp ON (tp.cpersona = tcp.cpersona
                                             AND tp.fhasta = tcp.fhasta)
WHERE
    tcp.cpersona > 2
    AND tcp.cpersona_compania = 2
    AND tcp.fhasta = Timestamp '2999-12-31 00:00:00.0'
    /*el siguiente criterio se ha dejado para evitar que el query se vaya a buscar datos de todas
    las personas del esquema
    lo cual generara un tiempo de respuesta excesivamente alto*/
    AND rownum <= 5000
    --AND tcp.CPERSONA = 14
GROUP BY
    tcp.cpersona,
    tp.nombrelegal
ORDER BY
    tcp.cpersona;

--=====VERSION = 2
SELECT COUNT (1),
    A.CPERSONA_CLIENTE
FROM TCUENTA A
WHERE A.CPERSONA_CLIENTE > 2
      AND A.CSUBSISTEMA = '04'
      AND A.FHASTA = TIMESTAMP '2999-12-31 00:00:00.0'
      AND ROWNUM < 5000
GROUP BY A.CPERSONA_CLIENTE;
    
----- =============================================================================================
----- CANTIDAD DE FIRMANTES POR CUENTAS
SELECT /*+ PARALLEL(tcf,4) */
    tcf.ccuenta AS cuenta,
    COUNT(1)       cantidad_firmantes
FROM
    TCUENTAFIRMANTES tcf
WHERE
    tcf.cpersona_compania = 2
    AND tcf.cpersona > 2
    AND tcf.fhasta = Timestamp '2999-12-31 00:00:00.0'
    /*el siguiente criterio se ha dejado para evitar que el query se vaya a buscar datos de todas
    las personas del esquema
    lo cual generara un tiempo de respuesta excesivamente alto*/
    AND rownum <= 5000
GROUP BY
    tcf.ccuenta
ORDER BY
    tcf.ccuenta;
----- =============================================================================================    
----- CANTIDAD DE CUENTAS POR CONDICION DE CLIENTE
SELECT /*+ PARALLEL(tcp,4)*/
    tcp.crelacionproducto AS cod_relacion_producto,
    trp.descripcion       AS relacion_producto,
    COUNT(1)              AS cantidad_cuentas
FROM
    tcuentaspersona tcp LEFT OUTER JOIN trelacionproducto trp ON (trp.cidioma = 'ES'
                                                                  AND trp.crelacionproducto = tcp.crelacionproducto
                                                                  AND trp.fhasta = tcp.fhasta)
WHERE
    tcp.cpersona > 2
    AND tcp.CPERSONA_COMPANIA = 2
    AND tcp.fhasta = Timestamp '2999-12-31 00:00:00.0'
GROUP BY
    tcp.crelacionproducto,
    trp.descripcion
ORDER BY
    tcp.crelacionproducto;
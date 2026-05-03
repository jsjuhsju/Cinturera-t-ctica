Config = {}

-- Configuración de los trabajos legales (puedes añadir más como 'sheriff', 'fbi')
Config.LegalJobs = {
    ['police'] = true,
    ['sheriff'] = true
}

-- CONFIGURACIÓN DE ROPA (IDs de los componentes de GTA V)
-- Componente 9 suele ser chalecos/accesorios de pecho
-- Componente 8 suele ser camisas interiores o cinturones (depende de tu pack de ropa)

Config.Clothing = {
    -- EQUIPO PARA LEGALES (Policía, etc)
    Legal = {
        belt = { id = 10, texture = 0 },     -- ID del cinturón policial
        vest = { id = 15, texture = 0 },     -- ID del chaleco policial
        holster_empty = 10,                  -- Componente cuando NO tiene el arma
        holster_full = 11                    -- Componente cuando TIENE el arma
    },

    -- EQUIPO PARA ILEGALES (Mafias, bandas o civiles)
    Illegal = {
        belt = { id = 6, texture = 0 },      -- ID de cartuchera criminal
        vest = { id = 12, texture = 0 },     -- ID de chaleco ligero/discreto
        holster_empty = 6,
        holster_full = 7
    }
}

-- CONFIGURACIÓN DE MUNICIÓN (Items de Ox_Inventory)
Config.Ammo = {
    ['9mm'] = {
        item_bullet = 'ammo_9mm',
        item_mag_empty = 'mag_pistol_empty',
        item_mag_full = 'mag_pistol_full',
        capacity = 15 -- Balas por cargador
    },
    ['7.62'] = {
        item_bullet = 'ammo_762',
        item_mag_empty = 'mag_ak_empty',
        item_mag_full = 'mag_ak_full',
        capacity = 30 -- Balas por cargador (Cuerno de Chivo)
    }
}

-- SISTEMA DE PESO
Config.WeightBonus = 10.0 -- Cuántos KG extra da el cinto (ej: 10kg)

-- TIEMPOS DE ANIMACIÓN (en milisegundos)
Config.DrawTime = 800 -- Tiempo que tarda en sacar el arma

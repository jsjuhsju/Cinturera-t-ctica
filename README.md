# 🛡️ Sistema Táctico Integrado (Cinturera y Chaleco v2.0)

Sistema avanzado de equipamiento táctico para FiveM, diseñado específicamente para integrarse con **ox_inventory** y proporcionar un realismo superior en el manejo de armas, munición y equipo de protección.

## 🚀 Características Principales

* **Fundas Dinámicas:** Visualización de armas en la cintura/pierna que aparecen y desaparecen al desenfundar.
* **Balística Realista:** Sistema de cargadores con metadata. Requiere unir balas + cargador vacío para obtener un cargador funcional.
* **Diferenciación de Roles:** Configuraciones distintas para trabajos legales (Policía/Sheriff) e ilegales (Bandas/Mafias).
* **Módulo de Chaleco:** Sistema de placas de cerámica que proporcionan blindaje real al personaje.
* **Animaciones Tácticas:** Desenfundado desde la pierna (pistolas) y desde el pecho (fusiles).
* **Optimización:** Incluye comandos de ajuste de posición (`/ajustar`) y persistencia tras desconexión.

## 🛠️ Instalación

1. Descarga los archivos en la carpeta `resources/[scripts]/tactical_belt`.
2. Añade los siguientes items a tu `ox_inventory/data/items.lua`:

```lua
['cinto_tactico'] = { label = 'Cinturera Táctica', weight = 500, stack = false, close = true },
['chaleco_tactico'] = { label = 'Chaleco Porta-Placas', weight = 1500, stack = false, close = true },
['placa_ceramica'] = { label = 'Placa Balística', weight = 2000, stack = true, close = true },
['mag_pistol_empty'] = { label = 'Cargador Pistola Vacío', weight = 100, stack = true },
['mag_pistol_full'] = { label = 'Cargador Pistola Lleno', weight = 200, stack = true },
['ammo_9mm'] = { label = 'Munición 9mm', weight = 10, stack = true },


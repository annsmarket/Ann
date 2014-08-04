# AM

    require "#{process.env['UPPERCASE_IO_PATH']}/BOOT"

    BOOT
        CONFIG:
            defaultBoxName: "Market"
            isDevMode: true
            webServerPort: 8889

        NODE_CONFIG:
            dbName: 'ann'

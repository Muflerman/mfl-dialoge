$(document).ready(function () {
    // Escuchar mensajes desde el cliente
    window.addEventListener('message', function (event) {
        const data = event.data;

        if (data.action === 'openDialogue') {
            openDialogue(data.data);
        } else if (data.action === 'closeDialogue') {
            closeDialogue();
        }
    });

    // Función para abrir el diálogo
    function openDialogue(dialogueData) {
        // Establecer nombre del NPC
        $('#npc-name').text(dialogueData.name);

        // Establecer texto del diálogo
        $('#dialogue-message').text(dialogueData.text);

        // Limpiar opciones anteriores
        $('#dialogue-options').empty();

        // Crear opciones
        dialogueData.options.forEach(function (option, index) {
            const optionElement = $(`
                <div class="dialogue-option" data-option-id="${option.id}">
                    <span class="option-number">${option.id}</span>
                    <div class="option-content">
                        <span class="option-label">${option.label}</span>
                        <span class="option-description">${option.description}</span>
                    </div>
                </div>
            `);

            // Agregar evento de clic
            optionElement.on('click', function () {
                selectOption(option.id);
            });

            // Agregar tecla numérica
            $(document).on('keydown', function (e) {
                if (e.key == option.id) {
                    selectOption(option.id);
                }
            });

            $('#dialogue-options').append(optionElement);
        });

        // Mostrar el diálogo
        $('#dialogue-container').fadeIn(300);
    }

    // Función para seleccionar una opción
    function selectOption(optionId) {
        // Enviar al cliente
        $.post(`https://${GetParentResourceName()}/selectOption`, JSON.stringify({
            optionId: optionId
        }));

        // Cerrar el diálogo
        closeDialogue();
    }

    // Función para cerrar el diálogo
    function closeDialogue() {
        $('#dialogue-container').addClass('dialogue-closing');

        setTimeout(function () {
            $('#dialogue-container').hide().removeClass('dialogue-closing');

            // Limpiar listeners de teclado
            $(document).off('keydown');
        }, 300);

        // Notificar al cliente
        $.post(`https://${GetParentResourceName()}/closeDialogue`, JSON.stringify({}));
    }

    // Cerrar con ESC
    $(document).on('keydown', function (e) {
        if (e.key === 'Escape' && $('#dialogue-container').is(':visible')) {
            closeDialogue();
        }
    });
});

// Función helper para obtener el nombre del recurso
function GetParentResourceName() {
    let resourceName = 'mfl-dialogue';

    if (window.location.href.includes('://')) {
        const match = window.location.href.match(/cfx-nui-([a-z0-9_-]+)\//i);
        if (match) {
            resourceName = match[1];
        }
    }

    return resourceName;
}

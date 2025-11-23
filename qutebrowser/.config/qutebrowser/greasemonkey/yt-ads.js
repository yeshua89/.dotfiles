// ==UserScript==
// @name         YouTube Ad Skipper (Lite)
// @version      2.1.0
// @description  Salta anuncios de YouTube sin romper funcionalidad
// @author       Enhanced for Tokyo Night
// @match        *://*.youtube.com/*
// @run-at       document-end
// ==/UserScript==

(function() {
    'use strict';

    // Función para saltar anuncios
    function skipAds() {
        // Buscar botón de skip
        const skipButton = document.querySelector('.ytp-ad-skip-button, .ytp-ad-skip-button-modern, .videoAdUiSkipButton');
        if (skipButton) {
            skipButton.click();
        }

        // Acelerar el tiempo del anuncio
        const video = document.querySelector('video');
        if (video && document.querySelector('.ad-showing')) {
            video.muted = true;
            video.currentTime = video.duration || 9999;
            video.playbackRate = 16;
        }
    }

    // Bloquear solo popups de Premium (menos agresivo)
    function removeAnnoyances() {
        const selectors = [
            'ytd-mealbar-promo-renderer',
        ];

        selectors.forEach(selector => {
            document.querySelectorAll(selector).forEach(el => {
                if (el && el.parentNode) {
                    el.remove();
                }
            });
        });
    }

    // Ejecutar periódicamente pero menos frecuente
    setInterval(skipAds, 1000);
    setInterval(removeAnnoyances, 2000);
})();

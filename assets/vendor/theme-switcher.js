// Allows CSS theme switching through the assignment of a single
// attribute on the <html> tag. Persists the selected theme in localStorage.
// Not hooked into LiveView in any way -- no need to over-complicate things.

const DEFAULT_THEME = 'default';
const THEME_SWITCHER_CLASS = '.theme-switch';
const THEME_ATTR = 'data-theme';
const ACTIVE_CLASS = 'active';
const MODE_SWITCHER_ID = 'mode-switch';
const DARK_MODE_CLASS = 'dark-mode';
const LIGHT_MODE_CLASS = 'light-mode';
const STORAGE_KEYS = {
  THEME: 'theme',
  COLOR_MODE: 'colorMode'
};

class ThemeManager {
  constructor() {
    this.init();
  }

  init() {
    this.loadPreferences();
    this.setupEventListeners();
    this.applyTheme();
    this.updateModeToggle();
  }

  loadPreferences() {
    const savedTheme = localStorage.getItem(STORAGE_KEYS.THEME);
    if (savedTheme) {
      document.documentElement.setAttribute(THEME_ATTR, savedTheme);
    }
    this.darkMode = localStorage.getItem(STORAGE_KEYS.COLOR_MODE) === DARK_MODE_CLASS;
  }

  setupEventListeners() {
    document.querySelectorAll(THEME_SWITCHER_CLASS).forEach(btn => {
      btn.addEventListener('click', () => {
        const theme = btn.id;
        this.setTheme(theme);
      });
    });

    document.getElementById(MODE_SWITCHER_ID)?.addEventListener('click', () => {
      this.toggleColorMode();
    });

    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', e => {
      if (!localStorage.getItem(STORAGE_KEYS.COLOR_MODE)) {
        this.applySystemColorMode(e.matches);
      }
    });
  }

  setTheme(theme) {
    const html = document.documentElement;

    if (theme === DEFAULT_THEME) {
      html.removeAttribute(THEME_ATTR);
    } else {
      html.setAttribute(THEME_ATTR, theme);
    }

    localStorage.setItem(STORAGE_KEYS.THEME, theme === DEFAULT_THEME ? '' : theme);
    this.updateActiveButton(theme);
    this.applyColorMode();
  }

  toggleColorMode() {
    this.darkMode = !this.darkMode;
    localStorage.setItem(STORAGE_KEYS.COLOR_MODE, this.darkMode ? DARK_MODE_CLASS : LIGHT_MODE_CLASS);
    this.applyColorMode();
    this.updateModeToggle();
  }

  applySystemColorMode(isDark) {
    this.darkMode = isDark;
    this.applyColorMode();
    this.updateModeToggle();
  }

  applyTheme() {
    this.applyColorMode();
    const currentTheme = document.documentElement.getAttribute(THEME_ATTR) || DEFAULT_THEME;
    this.updateActiveButton(currentTheme);
  }

  applyColorMode() {
    const html = document.documentElement;
    html.classList.remove(DARK_MODE_CLASS);

    if (this.darkMode) {
      html.classList.add(DARK_MODE_CLASS);
    }
  }

  updateActiveButton(theme) {
    document.querySelectorAll(THEME_SWITCHER_CLASS).forEach(btn => {
      btn.classList.toggle(ACTIVE_CLASS, btn.id === theme);
    });
  }

  updateModeToggle() {
    const toggle = document.getElementById(MODE_SWITCHER_ID);
    if (toggle) {
      toggle.textContent = this.darkMode ? '☀️' : '🌙';
    }
  }
}

document.addEventListener('DOMContentLoaded', () => {
  new ThemeManager();
});

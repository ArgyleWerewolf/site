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
const TRANSITIONING_MODE_CLASS = 'transitioning-mode';
const TRANSITIONING_THEME_CLASS = 'transitioning-theme';
const TRANSITIONING_CLASS_DURATION = 1500;
const STORAGE_KEYS = {
  THEME: 'theme',
  COLOR_MODE: 'colorMode'
};

class ThemeManager {
  constructor() {
    this.initialLoad = true;
    this.previousDarkMode = null;
    this.previousTheme = null;
    this.init();
  }

  init() {
    this.loadPreferences();
    this.setupEventListeners();
    this.applyTheme();
    this.updateModeToggle();
    this.initialLoad = false;
    this.previousDarkMode = this.darkMode;
    this.previousTheme = document.documentElement.getAttribute(THEME_ATTR) || DEFAULT_THEME;
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
    const currentTheme = html.getAttribute(THEME_ATTR) || DEFAULT_THEME;

    if (theme === DEFAULT_THEME) {
      html.removeAttribute(THEME_ATTR);
    } else {
      html.setAttribute(THEME_ATTR, theme);
    }

    localStorage.setItem(STORAGE_KEYS.THEME, theme === DEFAULT_THEME ? '' : theme);
    this.updateActiveButton(theme);
    this.applyColorMode();

    if (!this.initialLoad && theme !== currentTheme) {
      this.applyTransitionClass(TRANSITIONING_THEME_CLASS);
    }

    this.previousTheme = theme;
  }

  toggleColorMode() {
    this.darkMode = !this.darkMode;
    localStorage.setItem(STORAGE_KEYS.COLOR_MODE, this.darkMode ? DARK_MODE_CLASS : LIGHT_MODE_CLASS);
    this.applyColorMode();
    this.updateModeToggle();

    if (!this.initialLoad) {
      this.applyTransitionClass(TRANSITIONING_MODE_CLASS);
    }
  }

  applySystemColorMode(isDark) {
    this.darkMode = isDark;
    this.applyColorMode();
    this.updateModeToggle();

    if (!this.initialLoad && this.darkMode !== this.previousDarkMode) {
      this.applyTransitionClass(TRANSITIONING_MODE_CLASS);
    }
    this.previousDarkMode = this.darkMode;
  }

  applyTransitionClass(className) {
    const html = document.documentElement;
    html.classList.add(className);

    setTimeout(() => {
      html.classList.remove(className);
    }, TRANSITIONING_CLASS_DURATION);
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

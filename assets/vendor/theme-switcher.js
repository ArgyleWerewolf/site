// Allows CSS theme switching through the assignment of a single
// attribute on the <html> tag. Persists the selected theme in localStorage.
// Not hooked into LiveView in any way -- no need to over-complicate things.

const DEFAULT_THEME = 'default';
const THEME_SWITCHER = '.theme-switch';
const THEME_ATTR = 'data-theme';
const ACTIVE_CLASS = 'active';
const STORAGE_KEY = 'theme';

const setTheme = (theme) => {
  const html = document.documentElement;

  theme === DEFAULT_THEME
    ? html.removeAttribute(THEME_ATTR)
    : html.setAttribute(THEME_ATTR, theme);

  theme === DEFAULT_THEME
    ? localStorage.removeItem(STORAGE_KEY)
    : localStorage.setItem(STORAGE_KEY, theme);

  updateActiveButton(theme);
};

const updateActiveButton = (theme) => {
  document.querySelectorAll(THEME_SWITCHER).forEach(btn => {
    btn.classList.toggle(ACTIVE_CLASS, btn.id === theme);
  });
};

document.querySelectorAll(THEME_SWITCHER).forEach(btn => {
  btn.addEventListener('click', () => setTheme(btn.id));
});

window.addEventListener('DOMContentLoaded', () => {
  const savedTheme = localStorage.getItem(STORAGE_KEY);
  setTheme(savedTheme || DEFAULT_THEME);
});

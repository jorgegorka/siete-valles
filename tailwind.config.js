const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  plugins: [
    // ...
    require("@tailwindcss/forms"),
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
      },
    },
  },
};

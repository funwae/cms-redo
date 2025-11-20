module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/*_web/**/*.*ex"
  ],
  theme: {
    extend: {
      colors: {
        'cms-black': '#050308',
        'cms-charcoal': '#0b0f18',
        'cms-charcoal-light': '#111827',
        'cms-orange': '#f97316',
        'cms-purple': '#7e22ce',
        'cms-aqua': '#22d3ee',
        'cms-sand': '#fbbf77',
      },
      fontFamily: {
        'heading': ['Space Grotesk', 'sans-serif'],
        'body': ['Inter', 'system-ui', 'sans-serif'],
      },
    },
  },
  plugins: [
    require('daisyui'),
  ],
  daisyui: {
    themes: [
      {
        codemyspec: {
          "primary": "#f97316",
          "secondary": "#7e22ce",
          "accent": "#22d3ee",
          "neutral": "#0b0f18",
          "base-100": "#050308",
          "base-200": "#0b0f18",
          "base-300": "#111827",
        },
      },
    ],
  },
}

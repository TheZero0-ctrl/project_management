const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        primary: '#4C51BF',
        secondary: '#38B2AC',
        accent1: '#F59E0B',
        accent2: '#D97706',
        accent3: '#F472B6',
        accent4: '#C026D3',
        accent5: '#10B981', 
        error: '#EF4444',
        success: '#34D399',
        notice: '#6B7280',
        alert: '#F87171'
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}

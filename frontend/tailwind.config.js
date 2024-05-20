module.exports = {
    content: ["src/**/*.elm"],
    darkMode: "media", // or 'media' or 'class'
    theme: {
        fontFamily: {
            'display': ['Oslo Sans', 'Arial'],
            'body': ['Oslo Sans', 'Arial'],
            'sans': ['Oslo Sans', 'Arial'],
            'mono': ['JetBrains Mono', 'monospace'],
            'light': ['OsloSans-Light', 'Arial']
        },
        opacity: {},
        extend: {
            dropShadow: {
                'dark': '0 0px 10px rgba(255, 255, 255, 0.3)'
            },
            animation: {
                'fadeIn': 'fade 750ms ease-out forwards',
                'fadeInBody': 'fade 750ms 400ms ease-out forwards'
            },
            keyframes: {
                fade: {
                    'from': {opacity: '0', transform: 'translateY(1rem)'},
                    'to': {opacity: '1', transform: 'translateY(0)'}
                },
            }
        }
    },
    variants: [],
    plugins: [],
}

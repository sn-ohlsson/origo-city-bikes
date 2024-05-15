import "@oslokommune/punkt-assets/dist/fonts/OsloSans-Regular.woff2"
import "@oslokommune/punkt-assets/dist/fonts/OsloSans-Medium.woff2"
import "@oslokommune/punkt-assets/dist/fonts/OsloSans-RegularItalic.woff2"

// Types for Elm Land interop functions
namespace ElmLand {
    export type FlagsFunction =
        (
            {preferredColorScheme}: { preferredColorScheme: string }
        ) => unknown
}


// This is called BEFORE your Elm app starts up
//
// The value returned here will be passed as flags
// into your `Shared.init` function.
export const flags = ({env}) => {
    return {
        preferredColorScheme: getColorScheme()
    }
}


function getColorScheme() {
    const savedScheme = localStorage.getItem('colorScheme');
    console.log("Get color: " + savedScheme)
    if (savedScheme != null) {
        console.log("test")
        return savedScheme;
    } else {
        if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
            return "dark"
        } else {
            return "light"
        }
    }
}
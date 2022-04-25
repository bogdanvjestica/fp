function randomBackground () {
    const images =  [
                        "https://static1.simpleflyingimages.com/wordpress/wp-content/uploads/2022/02/Tom-Boon-202.jpg",
                        "https://www.hocu.ba/wp-content/uploads/2019/01/Wizz_Air_Appointed_New_Chief_Flight_Operations_Officer.jpg",
                        "https://www.transportenvironment.org/wp-content/uploads/2021/05/ryanair2.jpg",
                        "https://najnovijevijesti.hr/wp-content/uploads/2022/03/Air-Serbia.jpg",
                        "https://investitor.me/wp-content/uploads/2018/05/as.png",
                        "https://thesrpskatimes.com/wp-content/uploads/2020/03/wizzcorona.jpg",
                        "https://images.unsplash.com/photo-1542296332-2e4473faf563?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
                        "img/airmontenegro.jpg",
                        "https://images.unsplash.com/photo-1531147646552-1eec68116469?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80"
                    ]
    let i = Math.floor(Math.random() * images.length);
    $('body').css("background-image", "url(\"" + images[i] + "\")")
    setTimeout(randomBackground, 10000)
}

$(document).ready(function () {
    /* RESP. */
    randomBackground()
    $("\
        <button class='navbar-toggler' type='button' data-toggle='collapse' data-target='#collapsibleNavbar'>\
            <span class='navbar-toggler-icon'></span>\
        </button>\
    ").insertAfter(".navbar-brand")
    let expr =  sessionStorage.getItem("id") !== null &&
                sessionStorage.getItem("name") !== null &&
                sessionStorage.getItem("surname") !== null &&
                sessionStorage.getItem("email") !== null
    
    if (expr) {
        $('#mnLogin').append("\
                                <i class='fa fa-unlock' id='logout'></i>\
                                <span>" + sessionStorage.getItem("name") + " " + sessionStorage.getItem("surname") + "</span>\
                            ")
        let path = window.location.href
        if(path.substring(path.lastIndexOf('/')) == '/login')
            window.location.href = '/'
    }
    else {
        $('#mnLogin').append("\
                                <i class='fa fa-lock'></i>\
                                <span>You are admin?</span>\
                            ")
        let path = window.location.href
        if(path.substring(path.lastIndexOf('/')) == '/add')
            window.location.href = '/'
    }

    $('#mnLogin').click(function () {
        if(expr) {
            if(confirm("Do you really want to log out?")) {
                sessionStorage.clear() 
            }
        }
    })
})
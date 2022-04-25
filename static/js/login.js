$(document).ready(function () {
    $("#login").submit(function () {
        let email = $("#email").val()
        let password = $("#password").val()
        let pack = {}
        pack["email"] = email
        pack["password"] = password

        const url = "http://localhost:8080/auth" //virtual path

        $.ajax(url, {
            method: "POST",
            data: pack,
            success: function(data) {
                let v = JSON.parse(data)
                console.log(v)
                if (!jQuery.isEmptyObject(v)) {
                    $('#allow').text("Successful login. Please wait ...")
                    $("#allow").css("display", "block")
                    $("#deny").css("display", "none")
                    $('#email').val("")
                    $('#password').val("")
                    sessionStorage.setItem("id", v["id"])
                    sessionStorage.setItem("name", v["name"])
                    sessionStorage.setItem("surname", v["surname"])
                    sessionStorage.setItem("email", v["email"])
                    setTimeout(function () {
                        window.location.href = '/'
                    }, 3000)
                }
                else {
                    $('#deny').text("Login data is incorrect. Please try again ...")
                    $("#deny").css("display", "block")
                    $('#email').val("")
                    $('#password').val("")
                }
            },
            error: function() {
                console.log("Desila se greska.")
            },
            timeout: 3000
        })

        
        return false
    })

})

$(document).ready(function () {
    $("#insert").submit(function () {
        let name = $("#name").val()
        let content = $("#content").val().replace(/\n/g, "<br />");
        let pack = {}
        pack["name"] = name
        pack["content"] = content

        const url = "http://localhost:8080/newPost" //virtual path

        $.ajax(url, {
            method: "POST",
            data: pack,
            success: function(data) {
                let v = JSON.parse(data)
                if (v["success"] == "true") {
                    $('#allow').text("Saving data ... Please wait!")
                    $("#allow").css("display", "block")    
                    setTimeout(function () {
                        window.location.href = '/news'
                    }, 3000)
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

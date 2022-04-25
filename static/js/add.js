$(document).ready(function () {
    $("#msg").css("display", "none")
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
                    $('#msgID').text("Uspjesno ste dodali novu objavu.")
                    $("#msg").css("display", "inline-block")
                    $('#name').val("")
                    $('#content').val("") 
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

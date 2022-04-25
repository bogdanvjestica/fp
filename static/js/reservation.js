console.log("Aaaaaaaaaaaaaaaaa")
$(document).ready(function () {
    $("#reservation").submit(function () {
        let pnr = $("#pnr").val()
        let surname = $("#surname").val()
        let podaci = {}
        podaci["pnr"] = pnr
        podaci["surname"] = surname

        const url = "http://localhost:8080/getReservation" //virtual path

        console.log(podaci)

        $.ajax(url, {
            method: "GET",
            data: podaci,
            success: function(data) {
                console.log(JSON.stringify(podaci))
                console.log(data)
                let v = JSON.parse(data)
                console.log(v['lol'])
                console.log("SUCCESS!", v)
            },
            error: function() {
                console.log("ERROR!")
            }
        })
        return false
    })
})

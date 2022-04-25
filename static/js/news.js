$(document).ready(function () {
    let active = -1
    let expr =  sessionStorage.getItem("id") !== null &&
                sessionStorage.getItem("name") !== null &&
                sessionStorage.getItem("surname") !== null &&
                sessionStorage.getItem("email") !== null
    
    if(expr) {
        $('.add').css("display", "block")
    }

    $('.txt').each(function () {
        let elem = $(this)
        let txt = elem.text()
        elem.text(txt.substring(0, 200) + " ...")
    })

    $('.more').click(function () {
        let btn = $(this)
        let id = btn.attr('id')
        active = id
        $('.col-md-12').css("display", "none");
        if (expr) {
                let more = $('#more-admin-' + id)
                more.css("display", "block")

                $('#closebtn-admin-' + id).click (function () {
                    $('.col-md-12').css("display", "block");
                    more.css("display", "none")
                })
            }
            else {
                let more = $('#more-' + id)
                more.css("display", "block")

                $('#closebtn-' + id).click (function () {
                    $('.col-md-12').css("display", "block");
                    more.css("display", "none")
                })
            }
    })

    $('.rempost').click(function () {
        if(confirm("Are you sure you want to delete this post?")) {
            let btn = $(this)
            let id = btn.attr('id');
            let pack = {}
            pack['id'] = id

            const url = "http://localhost:8080/deletePost" //virtual path

            $.ajax(url, {
                method: "POST",
                data: pack,
                success: function() {
                    $('#allow').text("Removing data ... Please wait!")
                    $("#allow").css("display", "block")    
                    setTimeout(function () {
                        location.reload()
                    }, 3000)
                },
                error: function() {
                    console.log("Desila se greska.")
                }
            })
            return false
        }
    })

    $("[id^='update-']").submit(function () {
        let f = $(this)
        if(f.attr('id') == "update-" + active) {
            let id = $("#postID-" + active).val()
            let name = $("#name-" + active).val()
            let content = $("#content-" + active).val().replace(/\n/g, "<br />");
            let pack = {}
            pack["id"] = id
            pack["name"] = name
            pack["content"] = content

            console.log(pack)
            const url = "http://localhost:8080/updatePost" //virtual path

            $.ajax(url, {
                method: "POST",
                data: pack,
                success: function(data) {
                    let v = JSON.parse(data)
                    if (v["success"] == "true") {
                        $('#allow').text("Saving data ... Please wait!")
                        $("#allow").css("display", "block")    
                        setTimeout(function () {
                            location.reload()
                        }, 3000)
                    }
                },
                error: function() {
                    console.log("Desila se greska.")
                },
                timeout: 3000
            })
        }
        return false
    })
})

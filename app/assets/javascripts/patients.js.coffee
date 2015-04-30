class @Patient
  constructor: ->
    @datePicker()
    @otherPrice()
    @checkPaid()
    @addNote()
    @focusPatient()
    @changeMonth()

  datePicker: =>
    $("#datetimepicker4").datetimepicker pickTime: false

  otherPrice: =>
    $(".patients").delegate "select", "change", ->
      selected_value = $("select option:selected").last().text()
      console.log(selected_value)
      if (selected_value == "Khac")
        $("select option:selected").last().parent().parent().parent().parent().siblings(".other-price").removeClass("hidden")
      console.log("how are you?")
      return

  checkPaid: =>
    $("#is_paid").change ->
      target = $(this)
      target.val(target.prop('checked'))
      is_paid = target.prop('checked')
      patient_id = $(target).parent().data("patient-id")
      $.ajax
        type: "PUT"
        url: "/admin/patients/"+patient_id+"/paid"
        data:
          is_paid: is_paid

        dataType: "json"
        success: (data) ->
          target.attr("checked", data["is_paid"])
          return

        error: (errors, status) ->

  addNote: =>
    $(".patients").delegate ".add-note", "click", ->
      $('#add-des').modal('hide')

  focusPatient: =>
    $(".patients").delegate ".tbl-list-patients tbody .patient", "click", (e)->
      $(".patient").css("background-color", "white")
      $(e.currentTarget).css("background-color", "#67BCDB")
      return

  changeMonth: =>
    $("#date_month").change (e)->
      year = $("#date_year").val()
      month = $(e.currentTarget).val()
      $.ajax
        type: "GET"
        url: "/admin/patients/load_weeks_of_month"
        data:
          month: month
          year: year

        success: (data) ->
          $(".weeks_of_month").html(data)
          return

        error: (errors, status) ->




    

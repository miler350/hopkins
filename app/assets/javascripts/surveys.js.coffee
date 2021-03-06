$ ->
  if $("#surveys").length
    setTimeout ->
      $.get "users/completed_surveys", (response)->
        response.data.surveys.forEach (surveyData)->
          class_name = surveyData.name.toLowerCase().replace(" ", "-")
          question = $("#surveys .#{class_name}")
          if surveyData.completed
            question.find('.completed').html('Completed')
            question.attr('href', "javascript: void(0)")
          else
            if surveyData.display
              question.attr('href', surveyData.url)
            else
              question.attr('href', "javascript: void(0)")

        $('.survey-remaining').html(response.data.left_surveys)
    , 100
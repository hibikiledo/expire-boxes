module ApplicationHelper

  def bootstrap_dialog_loading(id)
    html = <<-HTML
      <div id="#{id}" class="modal fade">
        #{render 'dashboard/shared/loading_dialog'}
      </div>
      <script>
        $("##{id}").on("show.bs.modal", function (e) {
          $("##{id}").html('#{escape_javascript(render 'dashboard/shared/loading_dialog')}');
        });
      </script>  
    HTML
    html.html_safe
  end

end

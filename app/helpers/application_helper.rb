module ApplicationHelper

  def bootstrap_dialog_loading(id)
    html = <<-HTML
      <div id="#{id}" class="modal fade">
        #{render 'dashboard/shared/loading_dialog'}
      </div>
    HTML
    html.html_safe
  end

end

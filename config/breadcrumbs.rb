crumb :root do
  link "Dashboard", dashboard_path
end

crumb :boxes do
  link "Boxes", dashboard_boxes_path
  parent :root
end

crumb :box do |box|
  link box.label, dashboard_boxes_path
  parent :boxes
end

crumb :new_box do
  link "+", new_dashboard_box_path
  parent :boxes
end

crumb :accesses do |box|
  link "Accesses", dashboard_box_accesses_path
  parent :box, box
end

crumb :new_access do |box|
  link "+", new_dashboard_box_access_path
  parent :accesses, box
end

crumb :items do |box|
  link "Items", dashboard_box_items_path(box)
  parent :box, box
end

crumb :item do |box, item|
  link item.label, dashboard_box_item_path(box, item)
  parent :items, box
end

crumb :new_item do |box|
  link "+", new_dashboard_box_item_path(box)
  parent :items, box
end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).

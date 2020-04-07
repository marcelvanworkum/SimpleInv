module ApplicationHelper
  def flash_class(level)
    base = "alert alert-dismissible fade show "
    case level
      when "notice" then return base + "alert-info"
      when "success" then return base + "alert-success"
      when "error" then return base + "alert-danger"
      when "alert" then return base + "alert-warning"
    end
  end

end

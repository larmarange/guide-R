step_with_na <- function(model,
                         full_data = eval(model$call$data),
                         ...) {
  # data with no NAs
  if (is.null(full_data)) {
    ...data_no_na <- model.frame(model)
  } else {
    ...data_no_na <- get_all_vars(model, data = full_data) |> na.omit()
  }
  
  # assign ...data_no_na in parent.frame()
  assign("...data_no_na", ...data_no_na, envir = parent.frame())
  
  # refit the model without NAs
  model_no_na <- update(
    model,
    formula = terms(model),
    data = ...data_no_na
  )
  
  # apply step()
  model_simplified <- step(model_no_na, ...)
  
  # recompute simplified model using full data
  if (is.null(full_data)) {
    update(
      model,
      formula = terms(model_simplified)
    )
  } else {
    update(
      model,
      formula = terms(model_simplified),
      data = full_data
    )
  }
}

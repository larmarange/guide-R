step_with_na <- function(model,
                         full_data = NULL, ...) {
  # assign the model in parent environment
  assign("...full.model", model, pos = 1) 
  # refit the model without NAs
  model_no_na <- update(
    ...full.model,
    formula = terms(...full.model),
    data = model.frame(...full.model))
  # apply step()
  model_simplified <- step(model_no_na, ...)
  # recompute simplified model using full data
  if (is.null(full_data)) {
    update(model,
           formula = terms(model_simplified))
  } else {
    update(model,
           formula = terms(model_simplified),
           data = full_data)
  }
}

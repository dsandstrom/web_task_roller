module FormsHelper
  def form_errors(obj)
    return if obj.errors.none?

    <<~HTML
      <section class="error error-card">
        <h3 class="card-title">Couldn't send the Email</h3>
        #{form_errors_messages(obj)}
      </section>
    HTML
  end

  private

    def form_error_item(message)
      "<li>#{message}</li>"
    end

    def form_errors_list(obj)
      form_error_items = obj.errors.full_messages.map do |message|
        form_error_item(message)
      end

      <<~HTML
        <ol>
          #{form_error_items.join}
        </ol>
      HTML
    end

    def form_errors_messages(obj)
      message_count =
        "Please correct the #{pluralize(obj.errors.count, 'error')} below:"

      <<~HTML
        <main class="card-body">
          <p>#{message_count}</p>
          #{form_errors_list(obj)}
        </main>
      HTML
    end

    def pluralize(amount, word)
      return word if amount == 1

      "#{word}s"
    end
end

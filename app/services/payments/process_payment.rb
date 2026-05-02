module Payments
  class ProcessPayment
    def initialize(params, headers)
      @params = params
      @idempotency_key = headers["Idempotency-Key"]
    end

    def call
      return failure("Missing Idempotency-Key") unless @idempotency_key

      existing = IdempotencyKey.find_by(key: @idempotency_key)

      if existing
        return success(existing.response)
      end

      ActiveRecord::Base.transaction do
        invoice = Invoice.find(@params[:invoice_id])

        payment = Payment.create!(
          invoice: invoice,
          amount: invoice.amount,
          status: :success,
          idempotency_key: @idempotency_key,
          tenant_id: Current.tenant.id
        )

        invoice.update!(status: :paid)

        response = {
          payment_id: payment.id,
          invoice_id: invoice.id,
          status: "success"
        }

        IdempotencyKey.create!(
          key: @idempotency_key,
          response: response,
          tenant_id: Current.tenant.id
        )

        success(response)
      end
    rescue => e
      failure(e.message)
    end

    private

    def success(data)
      { success: true, data: data }
    end

    def failure(error)
      { success: false, error: error }
    end
  end
end

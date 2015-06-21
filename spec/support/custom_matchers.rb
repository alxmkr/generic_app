# Pundit
RSpec::Matchers.define :permit do |action|
  match do |policy|
    begin
      policy.public_send("#{action}?")
    rescue
      false
    end
  end

  failure_message do |policy|
    "#{policy.class} does not permit #{action} on #{policy.record} for #{policy.user.inspect}."
  end

  failure_message_when_negated do |policy|
    "#{policy.class} does not forbid #{action} on #{policy.record} for #{policy.user.inspect}."
  end
end

RSpec::Matchers.define :be_permitted do
  match do |request_block|
    begin
      request_block.call
      true
    rescue Pundit::NotAuthorizedError
      false
    end
  end

  supports_block_expectations
  failure_message { "expected that request would be permitted" }
  failure_message_when_negated { "expected that request would not be permitted" }
end

RSpec::Matchers.define :have_errors do |count|
  match do |object|
    return false if object.valid?
    count ? object.errors.count == count : true
  end

  failure_message do |object|
    "expected that #{object} would have #{count ? pluralize(count, 'error') + ' ' : 'errors'}"
  end

  failure_message_when_negated do |object|
    "expected that #{object} would not have errors"
  end
end
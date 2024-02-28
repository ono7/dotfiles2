....

class CallbackBase:
    pass

# skips logging if a tag called "sensitive" is defined
class CallbackModule(CallbackBase):
    # ... existing methods ...

    def v2_runner_on_ok(self, result):
        if result._result.get("failed", False) or 'sensitive' in result._task.tags:
            return  # Skip logging
        # ... rest of the method ...

    def v2_runner_on_failed(self, result, ignore_errors=False):
        if 'sensitive' in result._task.tags:
            return  # Skip logging
        # ... rest of the method ...

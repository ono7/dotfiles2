# ... existing code ...

class CallbackModule(CallbackBase):
    # ... existing methods ...

    def v2_runner_on_ok(self, result):
        if result._result.get("failed", False) or result._task.get_vars().get('sensitive_task', False):
            return  # Skip logging
        # ... rest of the method ...

    def v2_runner_on_failed(self, result, ignore_errors=False):
        if result._task.get_vars().get('sensitive_task', False):
            return  # Skip logging
        # ... rest of the method ...

def init_state(goal, deadline, constraints, level, weekday_mins, weekend_mins):
    return {
        "goal": goal,
        "deadline": deadline,
        "constraints": constraints,
        "level": level,
        "weekday_mins": weekday_mins,
        "weekend_mins": weekend_mins,
        "day_number": 1,
        "recent_summary": None,
    }


def summarize_day(task_results):
    done = task_results.count("done")
    partial = task_results.count("partial")
    skipped = task_results.count("skipped")

    return {
        "tasks_done": done,
        "tasks_partial": partial,
        "tasks_skipped": skipped,
        "had_overrun": partial > 0,
    }


def update_state(state, daily_summary):
    state["recent_summary"] = daily_summary
    state["day_number"] += 1
    return state

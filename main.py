from planner import generate_daily_tasks


test_input = {
    "goal": "Help me learn python fundamental",
    "constraints": ["no work after 9pm"],
    "level": 1,
    "available_minutes": 60,
    "recent_summary": None,
}

output = generate_daily_tasks(test_input)
print(output)

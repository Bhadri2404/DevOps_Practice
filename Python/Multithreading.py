import threading
import subprocess

def check_and_start_service(service_name):
    """Check if a service is running; if not, start it."""
    try:
        # Check service status
        result = subprocess.run(
            ["systemctl", "is-active", service_name],
            capture_output=True,
            text=True
        )

        status = result.stdout.strip()

        if status == "active":
            print(f"✅ {service_name} is already running.")
        else:
            print(f"⚠️  {service_name} is stopped (status: {status}). Starting it...")

            # Start the service
            start_result = subprocess.run(
                ["sudo", "systemctl", "start", service_name],
                capture_output=True,
                text=True
            )

            if start_result.returncode == 0:
                print(f"✅ {service_name} started successfully.")
            else:
                print(f"❌ Failed to start {service_name}: {start_result.stderr.strip()}")

    except Exception as e:
        print(f"❌ Error handling {service_name}: {e}")

# Define services to manage
services = ["nginx", "docker", "ssh"]

# Create threads — one per service
threads = []
for service in services:
    t = threading.Thread(target=check_and_start_service, args=(service,))
    threads.append(t)

# Start all threads in parallel
for t in threads:
    t.start()

# Wait for all threads to complete
for t in threads:
    t.join()

print("\n🎯 All services have been checked.")

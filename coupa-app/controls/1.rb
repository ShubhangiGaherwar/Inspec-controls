cmd1="ls /mnt/apps | grep coupa"
ser=command(cmd1).stdout.split("\n")

control "App checks" do                                # A unique ID for this control
  impact 1.0                                          # Just how critical is
  title "App instance reachability"

  ser.each do |ins|

        describe command("curl -kIH 'host: #{ins}' https://localhost 2>/dev/null  | egrep 'HTTP.*302|HTTP.*200'") do
          its ('stdout') { should match /HTTP.*302|HTTP.*200/ }
        end

    end
  end

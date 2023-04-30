module BlueHydra
  module Pulse
    def send_event(key,hash)
      if BlueHydra.pulse
        begin
          SensorEvent.send_event(key,hash)
        rescue
          #for open source users who don't have send event (because they aren't sensors)
          return false
        end
      end
    end

    def reset
      if BlueHydra.pulse ||  BlueHydra.pulse_debug

        BlueHydra.logger.info("Sending db reset to pulse")

        json_msg = JSON.generate({
          type:    "reset",
          source:  "blue-hydra",
          version: BlueHydra::VERSION,
          sync_version: BlueHydra::SYNC_VERSION,
        })
        if BlueHydra::PULSE_TRACKER.allowed_to_ship_reset?
          BlueHydra::Pulse.do_send(json_msg)
          BlueHydra::PULSE_TRACKER.update_reset_at
        else
          BlueHydra.logger.warn("Reset throttled, dont spam the cloud")
        end
      end
    end

    def hard_reset
      if BlueHydra.pulse ||  BlueHydra.pulse_debug

        BlueHydra.logger.info("Sending db hard reset to pulse")

        json_msg = JSON.generate({
          type:    "reset",
          source:  "blue-hydra",
          version: BlueHydra::VERSION,
          sync_version: "ANYTHINGBUTTHISVERSION",
        })

        if BlueHydra::PULSE_TRACKER.allowed_to_ship_hard_reset?
          BlueHydra::Pulse.do_send(json_msg)
          BlueHydra::PULSE_TRACKER.update_hard_reset_at
        else
          BlueHydra.logger.warn("Hard reset throttled, dont spam the cloud")
        end
      end
    end

    def do_send(json)
      BlueHydra::Pulse.do_debug(json) if BlueHydra.pulse_debug
      return unless BlueHydra.pulse
      begin
        # write json data to result socket
        TCPSocket.open('127.0.0.1', 8244) do |sock|
          BlueHydra.logger.info json.inspect
          sock.write(json)
          sock.write("\n")
          sock.flush
        end
      rescue => e
        BlueHydra.logger.warn "Unable to connect to Hermes (#{e.message}), unable to send to pulse"
      end
    end

    def do_debug(json)
      File.open("pulse_debug.log", 'a') { |file| file.puts(json) }
    end

    module_function :do_debug, :do_send, :send_event, :reset, :hard_reset
  end
end

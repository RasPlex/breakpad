# Workflow

## Generating the symbols after a build

After running a build, do "./make_syms.sh" to get the symbols and strip the binary.

This puts the symbols in a specific directory structure needed in order to decode the minidump.

## Generating the traces

It is important you comment out the line in CrashSubmitter.cpp that deletes the traces after uploading them.

Run "./get_traces.sh" to generate the stack traces. All available crashes are decoded and put into the "traces" folder. There is really verbose output in the ".err" file that you probably don't need.

## Cleaning up

Run ./clean.sh to move all the crash reports and traces to an archive folder, so that you can delete them at your convenienence, and they don't clutter up future debugging.

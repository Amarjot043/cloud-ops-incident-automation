Incident 1 - nginx service outage
- I created a new cronjob to run every 2 minutes. The task that was automated through this job is for checking if nginx service is stopped & start it.
- Challenges i had during doing this was, even after configuring the script & manually testing it, cron was still not able to kick the job.
  After hours of step by step debugging,I just realised that crond was not running in background. This refreshed my memory & kind of gave me
   a reality check that...in such scenarios i really need to be looking as basics first. For example, instead of spending hours on debugging,
  i could have asked myself...hey is cron a service? if so is it running? & then could have moved from there. But neverthless, it was good experience.

Incident 2 - Disk cleanup
- I realised that i set the alarm that triggered the alerts if disk usage goes more than 80%.
- To apply an automatic fix to this, i wrote a python script to cleanup the disk if usage goes higher than 80%.

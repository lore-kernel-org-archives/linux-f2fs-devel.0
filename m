From: Marc Lehmann <schmorp@schmorp.de>
Subject: Re: near disk full performance (full 8TB)
Date: Sun, 4 Oct 2015 11:40:41 +0200
Message-ID: <20151004094041.GA3177@schmorp.de>
References: <20150926032218.GA4311@schmorp.de>
	<20150926052551.GA2243@schmorp.de>
	<20150926075253.GD13619@jaegeuk-mac02.hsd1.ca.comcast.net>
	<20150926135957.GB9860@schmorp.de>
	<20150928175944.GA16945@jaegeuk-mac02.mot.com>
	<20150929110204.GA7608@schmorp.de>
	<20150929231310.GA6010@jaegeuk-mac02.mot.com>
	<20151001121120.GA7340@schmorp.de>
	<20151001185124.GA9803@schmorp.de>
	<20151002164645.GA2446@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <schmorp@schmorp.de>) id 1Zifml-0001zT-Ub
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 04 Oct 2015 09:40:51 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Zifmj-00072x-RF
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 04 Oct 2015 09:40:51 +0000
Content-Disposition: inline
In-Reply-To: <20151002164645.GA2446@jaegeuk-mac02.mot.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On Fri, Oct 02, 2015 at 09:46:45AM -0700, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> Hmm, this is because of FS metadata flushes in background.
> I pushed one patch, can you get it through v3.18 branch?

I continued to write the same ~2TB data set to the disk, with the same
kernel module, giving me 85MB/s and 66MB/s throughput, respectively. This
was due to extended periods where write performance was around 30-40MB/s,
followed by shorter periods where it was >100MB/s. After using
"disable_ext_identify", this *seemed* to improve somewhat. I did this on
the theory that the zones near the end of the device (assuming f2fs would
roughly fill from the beginning) get larger, causing more pressure on
the disk (which has only 128MB of RAM to combine writes), but the result
wasn't conclusive either wayy.

For the fourth set, which wouldn't fully fit, I choose pdfs (larger
average filesize), and used the new kernel, either of which might have
helped.

I configured f2fs like this:

   echo 16 >ipu_policy
   echo 100 >min_ipu_util
   echo 100000 >reclaim_segments
   echo 1 >gc_idle
   echo   500 >gc_min_sleep_time
   echo 90000 >gc_max_sleep_time
   echo 30000 >gc_no_gc_sleep_time

Performance was ok'ish (as during the whole test) till about 200GB were
left out of 8.1 (metric) TB.

I started to make a trace around the 197GB mark:

http://data.plan9.de/f2fs.near_full.xz

status at beginning: http://ue.tst.eu/a4fc2a2522f3e372c7e92255cad1f3c3.txt
rsync was writing at this point, and I think you can see GC activity.

at 173851.953639, I ^S'ed rsync, which, due to -v, would cause it to pause
after a file. there was regular (probably GC) activity, but most of the
time, the disk was again idle, something I simply wouldn't expect from the
GC config (see next mail).

status after pausing rsync: http://ue.tst.eu/26c170d7d9f946d60926a5cdca814bbe.txt

I unpaused rsync at 174004.438302
status before unpausing rsync: http://ue.tst.eu/cc22fafa0efcb1cadae5a3849dff873b.txt

At 174186.324000, speed went down to ~2MB/s, and looking at the traces, it
seems f2fs is writing random 2MB segments, which would explain the speed.

I stopped at this point and started to prepare this mail. I could see
constant but very low activity afterwards, roughly every 30s.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\

------------------------------------------------------------------------------

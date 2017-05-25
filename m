From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs Crash Consistency Problem
Date: Thu, 25 May 2017 16:44:54 -0700
Message-ID: <20170525234454.GA36886@jaegeuk-macbookpro.roam.corp.google.com>
References: <d5ab8383-25f3-ffd6-c506-20993348c499@gmail.com>
	<20170413211935.GA3826@jaegeuk.local>
	<bfeb7627-cd9c-6074-1655-38e87166a30b@gmail.com>
	<20170512001431.GA9575@jaegeuk.local>
	<a5d7e55f-c246-8c5d-c32c-de299f5d3e03@gmail.com>
	<20170517180109.GC21506@jaegeuk.local>
	<2ac7e872-d127-679e-a66f-52b585ae6813@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1dE2RC-0007ET-Kt
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 May 2017 23:45:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dE2RB-0008PN-AV
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 May 2017 23:45:02 +0000
Content-Disposition: inline
In-Reply-To: <2ac7e872-d127-679e-a66f-52b585ae6813@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Raouf Rokhjavan <rokhjavan.r@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 05/25, Raouf Rokhjavan wrote:
> 
> Hi
> 
> First of all, I'm really really sorry for my absence and replying too late.
> 
> On 05/17/17 22:31, Jaegeuk Kim wrote:
> > On 05/17, Raouf Rokhjavan wrote:
> > > Hi,
> > > 
> > > Since I want to make sure that my system, having a database app, stay
> > > operational after the power failure, I test database system on top of f2fs.
> > > Accordingly, I use sysbench and dm-log-writes to serve this purpose. I took
> > > advantage of lua scripting facility in sysbench to implement write only
> > > operations in database:
> > > 
> > > #sysbench --test=/home/roraouf/Projects/CrashConsistencyTest/locals/var/lib/dbtests/sysbench-lua/tests/db/oltp_write_only.lua
> > > --db-driver=mysql --oltp-table-size=1000 --mysql-db=sysbench
> > > --mysql-user=sysbench --mysql-password=password --max-requests=100
> > > --num-threads=1 --mysql-socket=/mnt/crash_consistency/f2fs/mysql/mysql.sock
> > > run
> > > 
> > > I ran this test on 3 configurations:
> > > 1- ext4 (ordered, noatime) - success 15/15
> > > 2- ext4 (norecovery, noatime) - success 0/15
> > > 3- f2fs (noatime) - success 3/15
> > > 
> > > Success, here, means whether file system is operational without running fsck
> > > and fixing after each replay.
> > > As the result show, ext4 with ordered journaling could surmount this test,
> > > but ,as it had been expected, ext4 without journaling like ext2 needs fsck
> > > to recover file system after simulated power loss.
> > > The surprising part of this test is f2fs. As f2fs always maintains a stable
> > > checkpoint of file system, and based on its FAST paper, it always rolls back
> > > to its stable checkpoint after power loss, I didn't expect to see f2fs in
> > > inconsistent state after replaying logs as fsck.f2fs reports. (It's
> > > necessary to mention that we check consistency of f2fs after mkfs.f2fs.
> > > ext4's results verify this notion.)
> > > 
> > > Unfortunately, the results are not reproducible, and inconsistency occurs in
> > > different logs; moreover, fsck.f2fs passes this test occasionally.
> > > To give more accurate information, I uploaded the output of fsck.f2fs on
> > > Google Drive.
> > > 
> > > https://drive.google.com/open?id=0BxdqCs3G6wd3UWtDTmRGbFBiYmc
> > Hi,
> Honestly speaking, I didn't expect to encountered such a confusing condition
> when I decided to verify the resiliency of f2fs after power failure!!! :)
> 
> The main thing which baffles me is that I haven't seen consistent behavior
> between ext4 and f2fs.
> As I told before, ext4 pass all sysbench which replays single log-writes
> following up with fsck. It doesn't reflect any inconsistency.
> Moreover, ext4 with norecovery  option,as we expect, fails in all tests and
> needs to fix the file system after simulated power-failure.
> On the contrary, f2fs show peculiar behaviors. It haphazardly passes or
> fails a test on different runs!
> > Could you please check:
> > - did you use a snapshot device?
> In order to prove that I use dm-snap appropriately in my scripts, I
> developed fsck_snap_f2fs_only.sh which logs  the CKPTs of f2fs in different
> stages: before, during, and after snapshot. You can see it here:
> CKPT version output, passed test -
> https://drive.google.com/file/d/0BxdqCs3G6wd3aTNPS1pfRWlIWk0/view?usp=sharing
> fsck output, passed test -
> https://drive.google.com/file/d/0BxdqCs3G6wd3Nm5DSk9DX0tLUDg/view?usp=sharing
> 
> > - what command was issued at #1687?
> An important thing is that failures don't occur at fixed positions;
> consequently, they aren't reproducible. In terms of command issued at #1687,
> I don't know exactly since I call sysbench program in my bash script to run
> a write-only database benchmark while I'm capturing disk logs via
> log-writes; on the other hand, sysbench calls a lua script to accomplish
> this task.
> 
> > - how's result of fsck.f2fs -d 3?
> I run another test (with FSCK_SCRIPT=./fsck_script/fsck_snap.sh in config)
> to capture the inconsistent condition. The outputs are available  here:
> fsck outputs, failed test -
> https://drive.google.com/file/d/0BxdqCs3G6wd3cy04TXd6QTBsbzA/view?usp=sharing
> fsck -d3 output, failed test -
> https://drive.google.com/file/d/0BxdqCs3G6wd3MXVzUHBGZEhlSFk/view?usp=sharing
> 
> > - can you share your log-dev image?
> After you asked me to share my log-dev, I got intrigued to replay again the
> log-dev which has inconsistency, but ,surprisingly, f2fs.fsck doesn't
> complain at that point, and it again reflects unpredictable behaviors!!!
> What I mean is that, during replaying the log-dev in which fsck.f2fs had
> reported inconsistency, fsck_snap.sh passed one time and failed another time
> at different log number!!! A couple of theories come to my mind:
> 1)  A bug in log-wirtes causes this behavior.
> 2) The virtualized  block-device in vmware causes this behavior - because
> It's not SSD.
> 3) Something is wrong with fsck.f2fs.
> 
> Another important thing is continuous errors in kernel log during replaying
> and checking the consistency of file system:
> - Buffer I/O error on dm-2, logical block X, async page read (replay-base;
> snapshot origin device )
> - Buffer I/O error on dm-3, logical block Y, async page read (replay-cow;
> cow based snapshot device)
> - ...
> - buffer_io_error: Z calls suppressed
> However, these kernel log error are generated in all conditions,
> f2fs{success, fail} and ext4.
> 
> *** IMPORTANT ***
> The most interesting part of my tests happened when I add
> fsck_snap_f2fs_only.sh to check the correctness of using dm-snapshot in my
> scripts. As I told I get CKPT by calling dump.f2fs and grep CKPT and log it,
> just that; however, the results are absolutely surprising. 15/15 tests
> passed. I don't know why because there is no change in my tests' logic. The
> main difference is that tests take longer to finish since I call more
> program to grep CKPT.
> 
> I put the codes of my tests on github, you can run it and get the results:
> http://github.com/raoufro/CrashConsistencyTest.git
> 
> What causes the weird behavior of f2fs in these tests?

Taking a look at your script, I think you need to wipe cow-dev. Otherwise it
gives stale data.

Thanks,

> 
> Regards,
> 
> > 
> > Thanks,
> > 
> > > Regards,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

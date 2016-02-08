From: Dave Chinner <david@fromorbit.com>
Subject: xfstests/091 failures
Date: Mon, 8 Feb 2016 15:58:38 +1100
Message-ID: <20160208045838.GC19486@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <david@fromorbit.com>) id 1aSduR-0005Ri-TX
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 08 Feb 2016 04:58:47 +0000
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aSduQ-0002my-HA for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 08 Feb 2016 04:58:47 +0000
Received: from dave by dastard with local (Exim 4.80)
	(envelope-from <david@fromorbit.com>) id 1aSduI-00076V-VR
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 08 Feb 2016 15:58:38 +1100
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Hi f2fs folks,

When I run xfstests on f2fs, i see several tests failing reliably.
I'm running on a ramdisk with a sector size of 4k. The first test to
fail is generic/091, and it fails pretty quickly:

$ diff -u tests/generic/091.out /home/dave/src/xfstests-dev/results//f2fs/generic/091.out.bad
--- tests/generic/091.out       2014-01-20 16:57:33.000000000 +1100
+++ /home/dave/src/xfstests-dev/results//f2fs/generic/091.out.bad       2016-02-08 15:21:02.701375087 +1100
@@ -1,7 +1,18 @@
 QA output created by 091
 fsx -N 10000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
-fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
-fsx -N 10000 -o 32768 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
-fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
-fsx -N 10000 -o 32768 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -R -W
-fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z -W
+mapped writes DISABLED
+skipping insert range behind EOF
+skipping insert range behind EOF
+truncating to largest ever: 0x11e00
+dowrite: write: Invalid argument
+LOG DUMP (7 total operations):
+1(  1 mod 256): SKIPPED (no operation)
+2(  2 mod 256): SKIPPED (no operation)
+3(  3 mod 256): FALLOC   0x2e0f2 thru 0x3134a  (0x3258 bytes) PAST_EOF
+4(  4 mod 256): SKIPPED (no operation)
+5(  5 mod 256): SKIPPED (no operation)
+6(  6 mod 256): TRUNCATE UP    from 0x0 to 0x11e00
+7(  7 mod 256): WRITE    0x73400 thru 0x79fff  (0x6c00 bytes) HOLE
+Log of operations saved to "/mnt/test/junk.fsxops"; replay with --replay-ops
+Correct content saved for comparison
+(maybe hexdump "/mnt/test/junk" vs "/mnt/test/junk.fsxgood")

It looks like the first write() call is failing with -EINVAL, which
seems like a bug. Tests generic/114, generic/240 and generic/263
also all fail with unexpected EINVAL errors to read/write calls.
generic/102 fails with a short write, which may or may not be the
same problem....

>From a quick look, it seems that the issue is that EINVAL is being
returned when non-aligned IO are being done, probably direct IO.
These tests pass just fine on the same block device using XFS, so
I suspect there's a logical vs physical sector size detection
problem somewhere in the f2fs code...

FWIW, a ramdisk on x86-64 has the following capabilities:

# blockdev --report /dev/ram0
RO    RA   SSZ   BSZ   StartSec            Size   Device
rw   256   512  4096          0      4096000000   /dev/ram0
# blkid -i /dev/ram0
DEVNAME=/dev/ram0
MINIMUM_IO_SIZE=4096
PHYSICAL_SECTOR_SIZE=4096
LOGICAL_SECTOR_SIZE=512
#

which says it can do 512 byte IOs even though the physical sector
size is 4k. i.e. it can emulate 512 byte sector devices correctly.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140

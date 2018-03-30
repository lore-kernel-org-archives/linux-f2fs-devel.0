From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] libf2fs: reset wanted_total_sectors by new
 sector_size
Date: Fri, 30 Mar 2018 09:23:49 -0700
Message-ID: <20180330162349.GB44823@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180327171908.15092-1-jaegeuk@kernel.org>
 <7561e573-9d88-60f0-868f-4a4b59d588cb@huawei.com>
 <50951b88-ccfc-836c-34c0-7347ff1f747a@huawei.com>
 <d49db6fe-d3db-9dc6-d4ce-5955b0dd01c3@huawei.com>
 <d2baabc6-e4cb-0bdc-fccb-fe3b0cdc813e@huawei.com>
 <20180330153909.GA44823@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1f1woo-0001al-8h
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Mar 2018 16:23:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f1wom-0062Hl-8A
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Mar 2018 16:23:58 +0000
Content-Disposition: inline
In-Reply-To: <20180330153909.GA44823@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Junling Zheng <zhengjunling@huawei.com>
Cc: katao <katao@xiaomi.com>, Jaegeuk Kim <jaegeuk@google.com>, linux-f2fs-devel@lists.sourceforge.net

On 03/30, Jaegeuk Kim wrote:
> On 03/30, Junling Zheng wrote:
> > On 2018/3/30 19:26, Chao Yu wrote:
> > > On 2018/3/30 18:51, Junling Zheng wrote:
> > >> Hi,
> > >>
> > >> On 2018/3/30 17:28, Chao Yu wrote:
> > >>> Hi All,
> > >>>
> > >>> On 2018/3/28 1:19, Jaegeuk Kim wrote:
> > >>>> From: katao <katao@xiaomi.com>
> > >>>>
> > >>>> The args of wanted_total_sectors is calculated based
> > >>>> on the DEFAULT_SECTOR_SIZE(512Bytes).get_device_info(i)
> > >>>> may be reset dev_sector_size, we should reset the number
> > >>>> of wanted_total_sectors.
> > >>>>
> > >>>> This bug was reported to Google Issue Tracker.
> > >>>> Link: https://issuetracker.google.com/issues/76407663
> > >>>
> > >>> I don't think this is the right way, since now we have changed previous
> > >>> sector_counter's meaning, some applications, for example, like xfstests will get
> > >>> device's real sector size via blockdev --getsize64, then calculate total wanted
> > >>> sector count by total_wanted_size / real_sector_size, if we changed default
> > >>> sector size to 512bytes, xfstests will pass a wrong sector number, result in
> > >>> getting wrong partition size.
> > >>>
> > >>> For something worse, in order to get the correct sector number, we have to
> > >>> change the way of calculation method of xfstests for new mkfs, but how can
> > >>> xfstests know the current version of mkfs is new or old...
> > >>>
> > >>> I think the change didn't consider backward compatibility of mkfs, so, in order
> > >>> to keep that, we'd better to let user pass the right sector number based on
> > >>> their device, or we can introduce a new parameter to indicate user wanted total
> > >>> size.
> > >>>
> > >>> How do you think?
> > >>>
> > >>
> > >> Agree. It's not backward-compatible. Most users can pass the correct sector number
> > >> calculated by the real sector size. For those very few users using 512B despite of
> > >> the actual sector size, all we need to do is informing them the real sector size.
> > > 
> > > The problem is via passed sector number, we can't know user has already knew the
> > > real sector size or not, so we don't have any chance to info them.
> > > 
> > 
> > Yeah, we can't guess users' behaviors. And only when wanted size is over device size,
> > we can inform users the real sector size.
> 
> So, current problem would be that wanted_total_sectors is given by:
> - device sector size in xfstests
> - 4KB in fs_mgr in Android
> - 512B in recovery in Android
> 
> And, my concern is why user always needs to think about sector_size to give
> target image size, and I thought 512B would be good to set as a default smallest
> value.
> 
> Setting it 512B by default can give some confusion to users tho, it won't hurt
> the existing partitions or images. So, I bet users will get noticed quickly,
> when formatting new partition under this rule.

So, I just integrated two patches in terms of this issue. Could you take a
look at this?

>From 9e615dd0a350d336a8067c64d9ef2bb7ce43a3e5 Mon Sep 17 00:00:00 2001
From: katao <katao@xiaomi.com>
Date: Tue, 27 Mar 2018 13:25:46 +0800
Subject: [PATCH] libf2fs,mkfs.f2fs: reset wanted_total_sectors by new
 sector_size

Use 512 bytes as the sector size criterion while specifying the
amount of sectors passed to mkfs.

Then, the args of wanted_total_sectors is calculated based
on the DEFAULT_SECTOR_SIZE(512Bytes). get_device_info(i)
may be reset dev_sector_size, we should reset the number
of wanted_total_sectors.

Signed-off-by: katao <katao@xiaomi.com>
Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
---
 lib/libf2fs.c           | 21 ++++++++++++++++++---
 man/mkfs.f2fs.8         |  2 +-
 mkfs/f2fs_format_main.c |  2 +-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index ffdbccb..af1ca65 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -812,8 +812,21 @@ int get_device_info(int i)
 #ifdef BLKSSZGET
 		if (ioctl(fd, BLKSSZGET, &sector_size) < 0)
 			MSG(0, "\tError: Using the default sector size\n");
-		else if (dev->sector_size < sector_size)
+		else if (dev->sector_size < sector_size){
+			/*
+			 * wanted_total_sectors need to be reset by new
+			 * sector_size.
+			 */
+			if (c.wanted_total_sectors != -1) {
+				c.wanted_total_sectors =
+					(c.wanted_total_sectors *
+						dev->sector_size) / sector_size;
+				MSG(0, "Warn: change wanted sectors = %"PRIu64""
+					" (in %u bytes)\n",
+					c.wanted_total_sectors, sector_size);
+			}
 			dev->sector_size = sector_size;
+		}
 #endif
 #ifdef BLKGETSIZE64
 		if (ioctl(fd, BLKGETSIZE64, &dev->total_sectors) < 0) {
@@ -1008,9 +1021,11 @@ int f2fs_get_device_info(void)
 		if (get_device_info(i))
 			return -1;
 
-	if (c.wanted_total_sectors < c.total_sectors) {
-		MSG(0, "Info: total device sectors = %"PRIu64" (in %u bytes)\n",
+	MSG(0, "Info: total device sectors = %"PRIu64" (in %u bytes)\n",
 				c.total_sectors, c.sector_size);
+	if (c.wanted_total_sectors < c.total_sectors) {
+		MSG(0, "Info: wanted sectors = %"PRIu64" (in 512 bytes)\n",
+				c.wanted_total_sectors);
 		c.total_sectors = c.wanted_total_sectors;
 		c.devices[0].total_sectors = c.total_sectors;
 	}
diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
index c2f9c86..e48ce39 100644
--- a/man/mkfs.f2fs.8
+++ b/man/mkfs.f2fs.8
@@ -63,7 +63,7 @@ mkfs.f2fs \- create an F2FS file system
 is used to create a f2fs file system (usually in a disk partition).
 \fIdevice\fP is the special file corresponding to the device (e.g.
 \fI/dev/sdXX\fP).
-\fIsectors\fP is optionally given for specifing the filesystem size.
+\fIsectors\fP (in 512 bytes) is optionally given for specifing the filesystem size.
 .PP
 The exit code returned by
 .B mkfs.f2fs
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index e522b2f..f8361b2 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -55,7 +55,7 @@ static void mkfs_usage()
 	MSG(0, "  -S sparse mode\n");
 	MSG(0, "  -t 0: nodiscard, 1: discard [default:1]\n");
 	MSG(0, "  -z # of sections per zone [default:1]\n");
-	MSG(0, "sectors: number of sectors. [default: determined by device size]\n");
+	MSG(0, "sectors: number of sectors (in 512 bytes). [default: determined by device size]\n");
 	exit(1);
 }
 
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

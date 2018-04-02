From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] libf2fs: reset wanted_total_sectors by new
 sector_size
Date: Mon, 2 Apr 2018 13:03:36 -0700
Message-ID: <20180402200336.GA19195@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180327171908.15092-1-jaegeuk@kernel.org>
 <7561e573-9d88-60f0-868f-4a4b59d588cb@huawei.com>
 <50951b88-ccfc-836c-34c0-7347ff1f747a@huawei.com>
 <d49db6fe-d3db-9dc6-d4ce-5955b0dd01c3@huawei.com>
 <d2baabc6-e4cb-0bdc-fccb-fe3b0cdc813e@huawei.com>
 <20180330153909.GA44823@jaegeuk-macbookpro.roam.corp.google.com>
 <f9465bc9-714d-2a9c-684d-0351ceb82724@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1f35g9-0004pa-5s
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 02 Apr 2018 20:03:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f35g7-000qJm-8Q
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 02 Apr 2018 20:03:45 +0000
Content-Disposition: inline
In-Reply-To: <f9465bc9-714d-2a9c-684d-0351ceb82724@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: katao <katao@xiaomi.com>, Jaegeuk Kim <jaegeuk@google.com>, linux-f2fs-devel@lists.sourceforge.net

On 04/02, Chao Yu wrote:
> On 2018/3/30 23:39, Jaegeuk Kim wrote:
> > On 03/30, Junling Zheng wrote:
> >> On 2018/3/30 19:26, Chao Yu wrote:
> >>> On 2018/3/30 18:51, Junling Zheng wrote:
> >>>> Hi,
> >>>>
> >>>> On 2018/3/30 17:28, Chao Yu wrote:
> >>>>> Hi All,
> >>>>>
> >>>>> On 2018/3/28 1:19, Jaegeuk Kim wrote:
> >>>>>> From: katao <katao@xiaomi.com>
> >>>>>>
> >>>>>> The args of wanted_total_sectors is calculated based
> >>>>>> on the DEFAULT_SECTOR_SIZE(512Bytes).get_device_info(i)
> >>>>>> may be reset dev_sector_size, we should reset the number
> >>>>>> of wanted_total_sectors.
> >>>>>>
> >>>>>> This bug was reported to Google Issue Tracker.
> >>>>>> Link: https://issuetracker.google.com/issues/76407663
> >>>>>
> >>>>> I don't think this is the right way, since now we have changed previous
> >>>>> sector_counter's meaning, some applications, for example, like xfstests will get
> >>>>> device's real sector size via blockdev --getsize64, then calculate total wanted
> >>>>> sector count by total_wanted_size / real_sector_size, if we changed default
> >>>>> sector size to 512bytes, xfstests will pass a wrong sector number, result in
> >>>>> getting wrong partition size.
> >>>>>
> >>>>> For something worse, in order to get the correct sector number, we have to
> >>>>> change the way of calculation method of xfstests for new mkfs, but how can
> >>>>> xfstests know the current version of mkfs is new or old...
> >>>>>
> >>>>> I think the change didn't consider backward compatibility of mkfs, so, in order
> >>>>> to keep that, we'd better to let user pass the right sector number based on
> >>>>> their device, or we can introduce a new parameter to indicate user wanted total
> >>>>> size.
> >>>>>
> >>>>> How do you think?
> >>>>>
> >>>>
> >>>> Agree. It's not backward-compatible. Most users can pass the correct sector number
> >>>> calculated by the real sector size. For those very few users using 512B despite of
> >>>> the actual sector size, all we need to do is informing them the real sector size.
> >>>
> >>> The problem is via passed sector number, we can't know user has already knew the
> >>> real sector size or not, so we don't have any chance to info them.
> >>>
> >>
> >> Yeah, we can't guess users' behaviors. And only when wanted size is over device size,
> >> we can inform users the real sector size.
> > 
> > So, current problem would be that wanted_total_sectors is given by:
> > - device sector size in xfstests
> > - 4KB in fs_mgr in Android
> > - 512B in recovery in Android
> > 
> > And, my concern is why user always needs to think about sector_size to give
> > target image size, and I thought 512B would be good to set as a default smallest
> > value.
> 
> Of course, IMO, the most direct way is let user pass image size to mkfs.f2fs
> instead of caculated sector size, I think that will make all happy.

No, it can become too large number.

> 
> > 
> > Setting it 512B by default can give some confusion to users tho, it won't hurt
> > the existing partitions or images. So, I bet users will get noticed quickly,
> > when formatting new partition under this rule.
> 
> For those f2fs users, who makes image based on non-512B sector device, once they
> upgrade mkfs.f2fs, they will encounter this issue, that may make bad reputation.
> 
> For interface in f2fs private ioctl, sysfs entry, or syscall, we keep the rule
> that once we want to do some change on it, we will not change the old interface
> directly, instead, introduce a new one to keep backward compatibility of old
> one. Still, I hope we can keep that rule in mkfs.f2fs parameter.

Okay, so in order to give more flexible ways, it'd be fine to add
wanted_sector_size by "-w" so that we could blow out all the existing concern
like this.

From: katao <katao@xiaomi.com>
Date: Tue, 27 Mar 2018 13:25:46 +0800
Subject: [PATCH] libf2fs,mkfs.f2fs: add wanted_sector_size for
 wanted_total_sectors

The wanted_total_sectors was determined by device sector size, but sometimes
we don't know precise sector_size by default. So, let's give wanted_sector_size
in such the ambiguous situation.

Signed-off-by: katao <katao@xiaomi.com>
Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
---
 include/f2fs_fs.h       |  1 +
 lib/libf2fs.c           | 13 +++++++++++++
 man/mkfs.f2fs.8         |  8 ++++++++
 mkfs/f2fs_format_main.c |  6 +++++-
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 053ccbe..2d75d39 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -335,6 +335,7 @@ struct f2fs_configuration {
 	u_int64_t device_size;
 	u_int64_t total_sectors;
 	u_int64_t wanted_total_sectors;
+	u_int64_t wanted_sector_size;
 	u_int64_t target_sectors;
 	u_int32_t sectors_per_blk;
 	u_int32_t blks_per_seg;
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index ffdbccb..bb7fe2e 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -593,6 +593,7 @@ void f2fs_init_configuration(void)
 	c.blks_per_seg = DEFAULT_BLOCKS_PER_SEGMENT;
 	c.rootdev_name = get_rootdev();
 	c.wanted_total_sectors = -1;
+	c.wanted_sector_size = -1;
 	c.zoned_mode = 0;
 	c.zoned_model = 0;
 	c.zone_blocks = 0;
@@ -900,6 +901,18 @@ int get_device_info(int i)
 				dev->zone_blocks);
 	}
 #endif
+	/* adjust wanted_total_sectors */
+	if (c.wanted_total_sectors != -1) {
+		MSG(0, "Info: wanted sectors = %"PRIu64" (in %"PRIu64" bytes)\n",
+				c.wanted_total_sectors, c.wanted_sector_size);
+		if (c.wanted_sector_size == -1) {
+			c.wanted_sector_size = dev->sector_size;
+		} else if (dev->sector_size != c.wanted_sector_size) {
+			c.wanted_total_sectors *= c.wanted_sector_size;
+			c.wanted_total_sectors /= dev->sector_size;
+		}
+	}
+
 	c.total_sectors += dev->total_sectors;
 	return 0;
 }
diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
index c2f9c86..442c0ea 100644
--- a/man/mkfs.f2fs.8
+++ b/man/mkfs.f2fs.8
@@ -53,6 +53,10 @@ mkfs.f2fs \- create an F2FS file system
 .I nodiscard/discard
 ]
 [
+.B \-w
+.I specific sector_size for target sectors
+]
+[
 .B \-z
 .I #-of-sections-per-zone
 ]
@@ -125,6 +129,10 @@ Specify 1 or 0 to enable/disable discard policy.
 If the value is equal to 1, discard policy is enabled, otherwise is disable.
 The default value is 1.
 .TP
+.BI \-w "sector-size"
+Specify the sector size in bytes along with given target sectors.
+Without it, the sectors will be calculated by device sector size.
+.TP
 .BI \-z " #-of-sections-per-zone"
 Specify the number of sections per zone. A zone consists of multiple sections.
 F2FS allocates segments for active logs with separated zones as much as possible.
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index e522b2f..19f0854 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -54,6 +54,7 @@ static void mkfs_usage()
 	MSG(0, "  -s # of segments per section [default:1]\n");
 	MSG(0, "  -S sparse mode\n");
 	MSG(0, "  -t 0: nodiscard, 1: discard [default:1]\n");
+	MSG(0, "  -w wanted sector size\n");
 	MSG(0, "  -z # of sections per zone [default:1]\n");
 	MSG(0, "sectors: number of sectors. [default: determined by device size]\n");
 	exit(1);
@@ -102,7 +103,7 @@ static void parse_feature(const char *features)
 
 static void f2fs_parse_options(int argc, char *argv[])
 {
-	static const char *option_string = "qa:c:d:e:l:mo:O:s:S:z:t:f";
+	static const char *option_string = "qa:c:d:e:l:mo:O:s:S:z:t:fw:";
 	int32_t option=0;
 
 	while ((option = getopt(argc,argv,option_string)) != EOF) {
@@ -166,6 +167,9 @@ static void f2fs_parse_options(int argc, char *argv[])
 		case 'f':
 			force_overwrite = 1;
 			break;
+		case 'w':
+			c.wanted_sector_size = atoi(optarg);
+			break;
 		default:
 			MSG(0, "\tError: Unknown option %c\n",option);
 			mkfs_usage();
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

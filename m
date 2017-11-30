From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/7] f2fs: spread f2fs_k{m,z}alloc
Date: Thu, 30 Nov 2017 19:28:19 +0800
Message-ID: <20171130112823.100494-3-yuchao0@huawei.com>
References: <20171130112823.100494-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eKN1P-00026c-0l
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 11:28:51 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eKN1N-0000eo-Mj
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Nov 2017 11:28:50 +0000
In-Reply-To: <20171130112823.100494-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Use f2fs_k{m,z}alloc as much as possible to increase fault injection
points.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c |  2 +-
 fs/f2fs/super.c   | 16 +++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index ce6bf4290dbe..176a2b97e6d3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3503,7 +3503,7 @@ static int build_curseg(struct f2fs_sb_info *sbi)
 	struct curseg_info *array;
 	int i;
 
-	array = kcalloc(NR_CURSEG_TYPE, sizeof(*array), GFP_KERNEL);
+	array = f2fs_kzalloc(sbi, sizeof(*array) * NR_CURSEG_TYPE, GFP_KERNEL);
 	if (!array)
 		return -ENOMEM;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index dca579b7fd50..2a4b469a5bda 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2155,14 +2155,15 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 	if (nr_sectors & (bdev_zone_sectors(bdev) - 1))
 		FDEV(devi).nr_blkz++;
 
-	FDEV(devi).blkz_type = kmalloc(FDEV(devi).nr_blkz, GFP_KERNEL);
+	FDEV(devi).blkz_type = f2fs_kmalloc(sbi, FDEV(devi).nr_blkz,
+								GFP_KERNEL);
 	if (!FDEV(devi).blkz_type)
 		return -ENOMEM;
 
 #define F2FS_REPORT_NR_ZONES   4096
 
-	zones = kcalloc(F2FS_REPORT_NR_ZONES, sizeof(struct blk_zone),
-			GFP_KERNEL);
+	zones = f2fs_kzalloc(sbi, sizeof(struct blk_zone) *
+				F2FS_REPORT_NR_ZONES, GFP_KERNEL);
 	if (!zones)
 		return -ENOMEM;
 
@@ -2302,8 +2303,8 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 	 * Initialize multiple devices information, or single
 	 * zoned block device information.
 	 */
-	sbi->devs = kcalloc(max_devices, sizeof(struct f2fs_dev_info),
-				GFP_KERNEL);
+	sbi->devs = f2fs_kzalloc(sbi, sizeof(struct f2fs_dev_info) *
+						max_devices, GFP_KERNEL);
 	if (!sbi->devs)
 		return -ENOMEM;
 
@@ -2507,8 +2508,9 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		int n = (i == META) ? 1: NR_TEMP_TYPE;
 		int j;
 
-		sbi->write_io[i] = kmalloc(n * sizeof(struct f2fs_bio_info),
-								GFP_KERNEL);
+		sbi->write_io[i] = f2fs_kmalloc(sbi,
+					n * sizeof(struct f2fs_bio_info),
+					GFP_KERNEL);
 		if (!sbi->write_io[i]) {
 			err = -ENOMEM;
 			goto free_options;
-- 
2.15.0.55.gc2ece9dc4de6


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

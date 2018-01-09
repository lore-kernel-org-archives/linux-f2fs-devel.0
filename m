From: "Gaoxiang (OS)" <gaoxiang25@huawei.com>
Subject: [PATCH RFC 1/2] mkfs.f2fs: max_nat_bitmap_size should be
 aligned up in segment
Date: Tue, 9 Jan 2018 08:00:33 +0000
Message-ID: <9047C53C18267742AB12E43B65C7F9F70BCC620D@dggemi505-mbs.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <gaoxiang25@huawei.com>) id 1eYoq6-0006RV-PU
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Jan 2018 08:00:54 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189] helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eYoq5-0007fR-1t
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Jan 2018 08:00:54 +0000
Content-Language: zh-CN
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, "chao@kernel.org" <chao@kernel.org>
Cc: heyunlei <heyunlei@huawei.com>, "Duwei (Device OS)" <weidu.du@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

max_nat_bitmap_size should be aligned up in segment, rather than
aligned down

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fsck/resize.c      | 3 +--
 mkfs/f2fs_format.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fsck/resize.c b/fsck/resize.c
index 143ad5d..9a9f54a 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -69,8 +69,7 @@ static int get_new_sb(struct f2fs_super_block *sb)
 		set_sb(cp_payload, 0);
 	}
 
-	max_nat_segments = (max_nat_bitmap_size * 8) >>
-					get_sb(log_blocks_per_seg);
+	max_nat_segments = SEG_ALIGN(max_nat_bitmap_size * 8);
 
 	if (get_sb(segment_count_nat) > max_nat_segments)
 		set_sb(segment_count_nat, max_nat_segments);
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index a130001..49dd93c 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -302,7 +302,7 @@ static int f2fs_prepare_super_block(void)
 		set_sb(cp_payload, 0);
 	}
 
-	max_nat_segments = (max_nat_bitmap_size * 8) >> log_blks_per_seg;
+	max_nat_segments = SEG_ALIGN(max_nat_bitmap_size * 8);
 
 	if (get_sb(segment_count_nat) > max_nat_segments)
 		set_sb(segment_count_nat, max_nat_segments);
-- 
2.1.4



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

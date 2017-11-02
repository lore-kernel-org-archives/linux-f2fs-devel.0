From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH v2 1/9] fsck.f2fs: do not set fix_on directly
Date: Thu, 2 Nov 2017 11:56:04 +0800
Message-ID: <20171102035612.217263-2-shengyong1@huawei.com>
References: <20171102035612.217263-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <shengyong1@huawei.com>)
 id 1eA6cL-0002J6-Aw
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 03:56:33 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1eA6cJ-00015o-SY
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 03:56:33 +0000
In-Reply-To: <20171102035612.217263-1-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: shengyong1@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Do not set fix_on if it is allowed by user.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/main.c  | 2 +-
 fsck/mount.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index c9411eb..93037e1 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -429,7 +429,7 @@ static void do_fsck(struct f2fs_sb_info *sbi)
 				c.fix_on = 1;
 			break;
 		}
-	} else {
+	} else if (c.preen_mode) {
 		/*
 		 * we can hit this in 3 situations:
 		 *  1. fsck -f, fix_on has already been set to 1 when
diff --git a/fsck/mount.c b/fsck/mount.c
index 29af3b7..17da814 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -2031,7 +2031,6 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
 				 */
 				ASSERT_MSG("Invalid nat entry[0]: "
 					"blk_addr[0x%x]\n", ni.blk_addr);
-				c.fix_on = 1;
 				fsck->chk.valid_nat_entry_cnt--;
 			}
 
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

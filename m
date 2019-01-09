From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] fsck.f2fs: fix incorrect boundary of
 IS_VALID_NID()
Date: Wed, 9 Jan 2019 10:48:25 +0800
Message-ID: <20190109024825.11524-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gh3vL-0007K4-2q
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 09 Jan 2019 02:48:55 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gh3v8-005fur-9k
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 09 Jan 2019 02:48:53 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org

nid should never equal to max_nid, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index 0d0d5e2cc399..82ecb05ddc5e 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -369,7 +369,7 @@ static inline block_t sum_blk_addr(struct f2fs_sb_info *sbi, int base, int type)
 
 static inline bool IS_VALID_NID(struct f2fs_sb_info *sbi, u32 nid)
 {
-	return (nid <= (NAT_ENTRY_PER_BLOCK *
+	return (nid < (NAT_ENTRY_PER_BLOCK *
 			le32_to_cpu(F2FS_RAW_SUPER(sbi)->segment_count_nat)
 			<< (sbi->log_blocks_per_seg - 1)));
 }
-- 
2.18.0.rc1

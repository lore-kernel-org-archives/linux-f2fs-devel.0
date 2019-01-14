From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH 2/2] f2fs: add brackets for macros
Date: Mon, 14 Jan 2019 22:05:14 +0800
Message-ID: <20190114140514.197758-2-shengyong1@huawei.com>
References: <20190114140514.197758-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1gj2s8-0006mp-Cr
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 14 Jan 2019 14:05:48 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gj2s2-001BUz-W0
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 14 Jan 2019 14:05:45 +0000
In-Reply-To: <20190114140514.197758-1-shengyong1@huawei.com>
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
Cc: linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/f2fs.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index eeede26339a8..70eb7b085b2e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -254,7 +254,7 @@ struct discard_entry {
 /* max discard pend list number */
 #define MAX_PLIST_NUM		512
 #define plist_idx(blk_num)	((blk_num) >= MAX_PLIST_NUM ?		\
-					(MAX_PLIST_NUM - 1) : (blk_num - 1))
+					(MAX_PLIST_NUM - 1) : ((blk_num) - 1))
 
 enum {
 	D_PREP,			/* initial */
@@ -2764,9 +2764,9 @@ static inline int get_inline_xattr_addrs(struct inode *inode)
 
 #define F2FS_OLD_ATTRIBUTE_SIZE	(offsetof(struct f2fs_inode, i_addr))
 #define F2FS_FITS_IN_INODE(f2fs_inode, extra_isize, field)		\
-		((offsetof(typeof(*f2fs_inode), field) +	\
+		((offsetof(typeof(*(f2fs_inode)), field) +	\
 		sizeof((f2fs_inode)->field))			\
-		<= (F2FS_OLD_ATTRIBUTE_SIZE + extra_isize))	\
+		<= (F2FS_OLD_ATTRIBUTE_SIZE + (extra_isize)))	\
 
 static inline void f2fs_reset_iostat(struct f2fs_sb_info *sbi)
 {
@@ -2795,8 +2795,8 @@ static inline void f2fs_update_iostat(struct f2fs_sb_info *sbi,
 
 #define __is_large_section(sbi)		((sbi)->segs_per_sec > 1)
 
-#define __is_meta_io(fio) (PAGE_TYPE_OF_BIO(fio->type) == META &&	\
-				(!is_read_io(fio->op) || fio->is_meta))
+#define __is_meta_io(fio) (PAGE_TYPE_OF_BIO((fio)->type) == META &&	\
+				(!is_read_io((fio)->op) || (fio)->is_meta))
 
 bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 					block_t blkaddr, int type);
-- 
2.17.1

From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH v2] f2fs: check if file namelen exceeds max value
Date: Mon, 7 Jan 2019 15:02:34 +0800
Message-ID: <20190107070234.181785-1-shengyong1@huawei.com>
References: <20190104115357.831-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1ggPAm-0006Cv-UW
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Jan 2019 07:18:08 +0000
Received: from dfwrgout.huawei.com ([206.16.17.72] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1ggPAk-001081-RQ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Jan 2019 07:18:08 +0000
In-Reply-To: <20190104115357.831-1-shengyong1@huawei.com>
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

Dentry bitmap is not enough to detect incorrect dentries. So this patch
also checks the namelen value of a dentry.

Signed-off-by: Gong Chen <gongchen4@huawei.com>
Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
v2->v1: Sorry, my bad. Fix incorrect brackets.
---
 fs/f2fs/dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index c0c845da12fa..e3a4094c194f 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -810,7 +810,8 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 
 		/* check memory boundary before moving forward */
 		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
-		if (unlikely(bit_pos > d->max)) {
+		if (unlikely(bit_pos > d->max ||
+				le16_to_cpu(de->name_len) > F2FS_NAME_LEN)) {
 			f2fs_msg(sbi->sb, KERN_WARNING,
 				"%s: corrupted namelen=%d, run fsck to fix.",
 				__func__, le16_to_cpu(de->name_len));
-- 
2.17.1

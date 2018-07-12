From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] fsck.f2fs: init quota_file before re-create
 quota file
Date: Thu, 12 Jul 2018 11:36:41 +0800
Message-ID: <20180712033641.142398-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1fdSPm-0003HL-So
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Jul 2018 03:37:10 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fdSPk-00FjJW-Ng
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Jul 2018 03:37:10 +0000
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
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

`quota_handle->qh_qf->filesize' is not initialized by quota_create_file().
It contains random value, which is updated to quota file's i_size in
quota_file_close(). Since quota file is re-created, `filesize' can be
initialized as 0.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/quotaio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fsck/quotaio.c b/fsck/quotaio.c
index afadf56..26f8a71 100644
--- a/fsck/quotaio.c
+++ b/fsck/quotaio.c
@@ -160,6 +160,7 @@ errcode_t quota_file_create(struct f2fs_sb_info *sbi, struct quota_handle *h,
 	f2fs_ino_t qf_inum = sb->qf_ino[qtype];
 	errcode_t err = 0;
 
+	memset(&h->qh_qf, 0, sizeof(h->qh_qf));
 	h->qh_qf.sbi = sbi;
 	h->qh_qf.ino = qf_inum;
 	h->write = quota_write_nomount;
-- 
2.17.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

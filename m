From: Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] f2fs: change error code to -ENOMEM from -EINVAL
Date: Tue,  1 Jan 2019 21:33:11 +0800
Message-ID: <20190101133311.18120-1-cgxu519@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <cgxu519@gmx.com>) id 1geKAt-0003su-4L
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 01 Jan 2019 13:33:39 +0000
Received: from mout.gmx.net ([212.227.15.19])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1geKAr-009VE4-07
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 01 Jan 2019 13:33:39 +0000
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
Cc: Chengguang Xu <cgxu519@gmx.com>, linux-f2fs-devel@lists.sourceforge.net

The error case of failing allocating memory should
return -ENOMEM.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index af58b2cc21b8..913274365f93 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -269,7 +269,7 @@ static int f2fs_set_qf_name(struct super_block *sb, int qtype,
 	if (!qname) {
 		f2fs_msg(sb, KERN_ERR,
 			"Not enough memory for storing quotafile name");
-		return -EINVAL;
+		return -ENOMEM;
 	}
 	if (F2FS_OPTION(sbi).s_qf_names[qtype]) {
 		if (strcmp(F2FS_OPTION(sbi).s_qf_names[qtype], qname) == 0)
-- 
2.17.2

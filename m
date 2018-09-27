From: Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH 1/2] f2fs: remove QUOTA flag setting in
 f2fs_set_qf_name()
Date: Thu, 27 Sep 2018 23:23:13 +0800
Message-ID: <20180927152314.23190-1-cgxu519@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <cgxu519@gmx.com>) id 1g5Y9C-0002lL-Ab
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 27 Sep 2018 15:24:10 +0000
Received: from mout.gmx.net ([212.227.17.21])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1g5Y9A-007ppb-87
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 27 Sep 2018 15:24:10 +0000
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

Mount flag QUOTA is the same as flag USRQUOTA in f2fs, so should not
set flag QUOTA in f2fs_set_qf_name().

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 fs/f2fs/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 896b885f504e..e2abd45c2cdd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -286,7 +286,6 @@ static int f2fs_set_qf_name(struct super_block *sb, int qtype,
 		goto errout;
 	}
 	F2FS_OPTION(sbi).s_qf_names[qtype] = qname;
-	set_opt(sbi, QUOTA);
 	return 0;
 errout:
 	kfree(qname);
-- 
2.17.1

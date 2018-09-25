From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/6] f2fs: fix to recover inode's i_gc_failures
 during POR
Date: Tue, 25 Sep 2018 15:36:00 +0800
Message-ID: <20180925073603.102125-3-yuchao0@huawei.com>
References: <20180925073603.102125-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1g4htQ-0001qE-69
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 25 Sep 2018 07:36:24 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g4htO-00AMrI-0n
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 25 Sep 2018 07:36:24 +0000
In-Reply-To: <20180925073603.102125-1-yuchao0@huawei.com>
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

inode.i_gc_failures is used to indicate that skip count of migrating
on blocks of inode, we should guarantee it can be recovered in sudden
power-off case.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/recovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 4a0f49654573..71577f30a889 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -267,6 +267,8 @@ static int recover_inode(struct inode *inode, struct page *page)
 
 	F2FS_I(inode)->i_advise = raw->i_advise;
 	F2FS_I(inode)->i_flags = le32_to_cpu(raw->i_flags);
+	F2FS_I(inode)->i_gc_failures[GC_FAILURE_PIN] =
+				le16_to_cpu(raw->i_gc_failures);
 
 	recover_inline_flags(inode, raw);
 
-- 
2.18.0.rc1

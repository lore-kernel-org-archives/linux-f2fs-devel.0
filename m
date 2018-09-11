From: Wang Shilong <wangshilong1991@gmail.com>
Subject: [PATCH v2 2/3] ext4: fix to detect failure of
 dquot_initialize in project ioctl
Date: Wed, 12 Sep 2018 08:57:17 +0900
Message-ID: <1536710238-16858-2-git-send-email-wshilong1991@gmail.com>
References: <1536710238-16858-1-git-send-email-wshilong1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wangshilong1991@gmail.com>) id 1fzsXJ-00088z-6F
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 11 Sep 2018 23:57:37 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fzsXH-00Egz9-Lm
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 11 Sep 2018 23:57:37 +0000
Received: by mail-pf1-f193.google.com with SMTP id s13-v6so46512pfi.7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Sep 2018 16:57:35 -0700 (PDT)
In-Reply-To: <1536710238-16858-1-git-send-email-wshilong1991@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: adilger@dilger.ca, wshilong@ddn.com, dchinner@redhat.com

From: Wang Shilong <wshilong@ddn.com>

We return most failure of dquota_initialize() except
inode evict, this could make a bit sense, for example
we allow file removal even quota files are broken?

But it dosen't make sense to allow setting project
if quota files etc are broken.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
v1->v2:
based it on one patchset, to make reviewers happy.
---
 fs/ext4/ioctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index f81102bd3203..781dd699bd7b 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -359,7 +359,9 @@ static int ext4_ioctl_setproject(struct file *filp, __u32 projid)
 		brelse(iloc.bh);
 	}
 
-	dquot_initialize(inode);
+	err = dquot_initialize(inode);
+	if (err)
+		return err;
 
 	handle = ext4_journal_start(inode, EXT4_HT_QUOTA,
 		EXT4_QUOTA_INIT_BLOCKS(sb) +
-- 
2.17.1

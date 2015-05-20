From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/4] f2fs crypto: check encryption for tmpfile
Date: Tue, 19 May 2015 17:43:25 -0700
Message-ID: <1432082606-55975-3-git-send-email-jaegeuk@kernel.org>
References: <1432082606-55975-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Yus6t-0007sk-35
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 20 May 2015 00:43:47 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Yus6s-00028q-FW for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 20 May 2015 00:43:47 +0000
In-Reply-To: <1432082606-55975-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch adds to check encryption for tmpfile in early stage.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/namei.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index dded2b0..47066b0 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -531,6 +531,11 @@ static int __f2fs_tmpfile(struct inode *dir, struct dentry *dentry,
 	}
 
 	f2fs_lock_op(sbi);
+
+	err = f2fs_get_encryption_info(dir);
+	if (err)
+		goto out;
+
 	err = acquire_orphan_inode(sbi);
 	if (err)
 		goto out;
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y

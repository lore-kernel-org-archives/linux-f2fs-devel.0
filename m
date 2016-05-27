From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/4] f2fs: inject to produce some orphan inodes
Date: Thu, 26 May 2016 17:25:22 -0700
Message-ID: <1464308724-71070-2-git-send-email-jaegeuk@kernel.org>
References: <1464308724-71070-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b65ap-00033z-Te
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 May 2016 00:25:35 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b65ap-0000C1-5J
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 May 2016 00:25:35 +0000
In-Reply-To: <1464308724-71070-1-git-send-email-jaegeuk@kernel.org>
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

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  | 3 +++
 fs/f2fs/inode.c | 5 +++++
 fs/f2fs/super.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5daba19..c4697b7 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -45,6 +45,7 @@ enum {
 	FAULT_ORPHAN,
 	FAULT_BLOCK,
 	FAULT_DIR_DEPTH,
+	FAULT_EVICT_INODE,
 	FAULT_MAX,
 };
 
@@ -74,6 +75,8 @@ static inline bool time_to_inject(int type)
 		return false;
 	else if (type == FAULT_DIR_DEPTH && !IS_FAULT_SET(type))
 		return false;
+	else if (type == FAULT_EVICT_INODE && !IS_FAULT_SET(type))
+		return false;
 
 	atomic_inc(&f2fs_fault.inject_ops);
 	if (atomic_read(&f2fs_fault.inject_ops) >= f2fs_fault.inject_rate) {
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index bdd814d..11cb60a 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -345,6 +345,11 @@ void f2fs_evict_inode(struct inode *inode)
 	if (inode->i_nlink || is_bad_inode(inode))
 		goto no_delete;
 
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	if (time_to_inject(FAULT_EVICT_INODE))
+		goto no_delete;
+#endif
+
 	sb_start_intwrite(inode->i_sb);
 	set_inode_flag(inode, FI_NO_ALLOC);
 	i_size_write(inode, 0);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a5b5739..27f76819e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -49,6 +49,7 @@ char *fault_name[FAULT_MAX] = {
 	[FAULT_ORPHAN]		= "orphan",
 	[FAULT_BLOCK]		= "no more block",
 	[FAULT_DIR_DEPTH]	= "too big dir depth",
+	[FAULT_EVICT_INODE]	= "evict_inode fail",
 };
 
 static void f2fs_build_fault_attr(unsigned int rate)
-- 
2.6.3


------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e

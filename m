From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 2/3] f2fs: add f2fs_drop_inode tracepoint
Date: Mon, 27 Feb 2017 13:02:58 +0000
Message-ID: <20170227130259.19987-2-houpengyang@huawei.com>
References: <20170227130259.19987-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1ciKxo-0002eY-SP
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 13:03:40 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ciKxc-0003kv-4P
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 13:03:40 +0000
In-Reply-To: <20170227130259.19987-1-houpengyang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 fs/f2fs/super.c             | 7 +++++--
 include/trace/events/f2fs.h | 7 +++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 751e106..746296e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -624,6 +624,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 
 static int f2fs_drop_inode(struct inode *inode)
 {
+	int ret;
 	/*
 	 * This is to avoid a deadlock condition like below.
 	 * writeback_single_inode(inode)
@@ -656,10 +657,12 @@ static int f2fs_drop_inode(struct inode *inode)
 			spin_lock(&inode->i_lock);
 			atomic_dec(&inode->i_count);
 		}
+		trace_f2fs_drop_inode(inode, 0);
 		return 0;
 	}
-
-	return generic_drop_inode(inode);
+	ret = generic_drop_inode(inode);
+	trace_f2fs_drop_inode(inode, ret);
+	return ret;
 }
 
 int f2fs_inode_dirtied(struct inode *inode, bool sync)
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index ff31ccf..c80fcad0 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -315,6 +315,13 @@ DEFINE_EVENT(f2fs__inode_exit, f2fs_unlink_exit,
 	TP_ARGS(inode, ret)
 );
 
+DEFINE_EVENT(f2fs__inode_exit, f2fs_drop_inode,
+
+	TP_PROTO(struct inode *inode, int ret),
+
+	TP_ARGS(inode, ret)
+);
+
 DEFINE_EVENT(f2fs__inode, f2fs_truncate,
 
 	TP_PROTO(struct inode *inode),
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot

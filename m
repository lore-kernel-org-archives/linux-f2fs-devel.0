From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/3 V2] f2fs: check filename length in
	recover_dentry
Date: Mon, 23 Dec 2013 11:12:21 +0800
Message-ID: <002201ceff8c$efbd2da0$cf3788e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1VuvxT-0004ye-Sv
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 23 Dec 2013 03:13:31 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VuvxR-0002pp-PG
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 23 Dec 2013 03:13:31 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MY800H3LOYAQH60@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 23 Dec 2013 12:13:22 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: '???' <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In current flow, we will get Null return value of f2fs_find_entry in
recover_dentry when name.len is bigger than F2FS_NAME_LEN, and then we
still add this inode into its dir entry.
To avoid this situation, we must check filename length before we use it.

Another point is that we could remove the code of checking filename length
In f2fs_find_entry, because f2fs_lookup will be called previously to ensure of
validity of filename length.

V2:
 o add WARN_ON() as Jaegeuk Kim suggested.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/dir.c      |    3 ---
 fs/f2fs/recovery.c |    6 ++++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 07ad850..f0b4630 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -190,9 +190,6 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
 	unsigned int max_depth;
 	unsigned int level;
 
-	if (unlikely(namelen > F2FS_NAME_LEN))
-		return NULL;
-
 	if (npages == 0)
 		return NULL;
 
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index a3f4542..4d411a2 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -62,6 +62,12 @@ static int recover_dentry(struct page *ipage, struct inode *inode)
 
 	name.len = le32_to_cpu(raw_inode->i_namelen);
 	name.name = raw_inode->i_name;
+
+	if (unlikely(name.len > F2FS_NAME_LEN)) {
+		WARN_ON(1);
+		err = -ENAMETOOLONG;
+		goto out;
+	}
 retry:
 	de = f2fs_find_entry(dir, &name, &page);
 	if (de && inode->i_ino == le32_to_cpu(de->ino))
-- 
1.7.9.5


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk

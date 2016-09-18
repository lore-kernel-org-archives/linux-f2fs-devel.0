From: Chao Yu <chao@kernel.org>
Subject: [PATCH 5/6] f2fs: support IO error injection
Date: Sun, 18 Sep 2016 23:30:07 +0800
Message-ID: <1474212608-6930-5-git-send-email-chao@kernel.org>
References: <1474212608-6930-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1ble5H-00028e-Iz
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 18 Sep 2016 15:32:47 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ble5G-0007JX-PV
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 18 Sep 2016 15:32:47 +0000
In-Reply-To: <1474212608-6930-1-git-send-email-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch adds to support IO error injection for testing IO error
tolerance of f2fs.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c  | 5 +++++
 fs/f2fs/f2fs.h  | 3 +++
 fs/f2fs/super.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 120a995..251cc33 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -34,6 +34,11 @@ static void f2fs_read_end_io(struct bio *bio)
 	struct bio_vec *bvec;
 	int i;
 
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	if (time_to_inject(FAULT_IO))
+		bio->bi_error = -EIO;
+#endif
+
 	if (f2fs_bio_encrypted(bio)) {
 		if (bio->bi_error) {
 			fscrypt_release_ctx(bio->bi_private);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b615f3f..a1a68bf 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -46,6 +46,7 @@ enum {
 	FAULT_BLOCK,
 	FAULT_DIR_DEPTH,
 	FAULT_EVICT_INODE,
+	FAULT_IO,
 	FAULT_MAX,
 };
 
@@ -77,6 +78,8 @@ static inline bool time_to_inject(int type)
 		return false;
 	else if (type == FAULT_EVICT_INODE && !IS_FAULT_SET(type))
 		return false;
+	else if (type == FAULT_IO && !IS_FAULT_SET(type))
+		return false;
 
 	atomic_inc(&f2fs_fault.inject_ops);
 	if (atomic_read(&f2fs_fault.inject_ops) >= f2fs_fault.inject_rate) {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f809729..fafa34e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -50,6 +50,7 @@ char *fault_name[FAULT_MAX] = {
 	[FAULT_BLOCK]		= "no more block",
 	[FAULT_DIR_DEPTH]	= "too big dir depth",
 	[FAULT_EVICT_INODE]	= "evict_inode fail",
+	[FAULT_IO]		= "IO error",
 };
 
 static void f2fs_build_fault_attr(unsigned int rate)
-- 
2.7.2


------------------------------------------------------------------------------

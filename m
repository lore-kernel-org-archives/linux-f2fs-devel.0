From: Jin Qian <jinqian@google.com>
Subject: [PATCH 1/1] f2fs-tools: sanity check cp_payload before
	reading checkpoint
Date: Thu, 27 Apr 2017 12:12:22 -0700
Message-ID: <20170427191222.40402-1-jinqian@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jinqian@google.com>) id 1d3oqj-0008Oc-Tg
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Apr 2017 19:13:09 +0000
Received: from mail-pf0-f180.google.com ([209.85.192.180])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1d3oqj-0005nW-56
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Apr 2017 19:13:09 +0000
Received: by mail-pf0-f180.google.com with SMTP id v14so35431029pfd.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 27 Apr 2017 12:13:09 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org

cp_payload is not sanity checked from input image. A invalid size
can cause buffer overflow when reading checkpoint blks into memory.

Signed-off-by: Jin Qian <jinqian@google.com>
---
 fsck/mount.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 761baa0..ffaa0ed 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -589,9 +589,14 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 	unsigned long blk_size = sbi->blocksize;
 	unsigned long long cp1_version = 0, cp2_version = 0, version;
 	unsigned long long cp_start_blk_no;
-	unsigned int cp_blks = 1 + get_sb(cp_payload);
+	unsigned int cp_payload, cp_blks;
 	int ret;
 
+	cp_payload = get_sb(cp_payload);
+	if (cp_payload > F2FS_BLK_ALIGN(MAX_SIT_BITMAP_SIZE))
+		return -EINVAL;
+
+	cp_blks = 1 + cp_payload;
 	sbi->ckpt = malloc(cp_blks * blk_size);
 	if (!sbi->ckpt)
 		return -ENOMEM;
-- 
2.13.0.rc0.306.g87b477812d-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

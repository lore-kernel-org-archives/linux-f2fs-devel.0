From: Jin Qian <jinqian@google.com>
Subject: [PATCH 1/1] f2fs-tools: sanity check segment count
Date: Tue, 25 Apr 2017 16:25:11 -0700
Message-ID: <20170425232511.22127-1-jinqian@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jinqian@google.com>) id 1d39rC-0001Zc-LE
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Apr 2017 23:26:54 +0000
Received: from mail-pg0-f50.google.com ([74.125.83.50])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1d39r9-00085F-49
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Apr 2017 23:26:54 +0000
Received: by mail-pg0-f50.google.com with SMTP id v1so23334997pgv.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 25 Apr 2017 16:26:51 -0700 (PDT)
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

make sure segment count in super block doesn't exceed F2FS_MAX_SEGMENT.

Signed-off-by: Jin Qian <jinqian@google.com>
---
 fsck/mount.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index 761baa0..0111960 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -406,6 +406,9 @@ int sanity_check_raw_super(struct f2fs_super_block *sb, u64 offset)
 		return -1;
 	}
 
+	if (get_sb(segment_count) > F2FS_MAX_SEGMENT)
+		return -1;
+
 	if (sanity_check_area_boundary(sb, offset))
 		return -1;
 	return 0;
-- 
2.13.0.rc0.306.g87b477812d-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

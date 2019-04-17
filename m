From: Park Ju Hyung <qkrwngud825@gmail.com>
Subject: [PATCH] f2fs: mark is_extension_exist() inline
Date: Wed, 17 Apr 2019 18:57:38 +0900
Message-ID: <20190417095738.7918-1-qkrwngud825@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hGhKs-0005GX-RQ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 09:58:34 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hGhKq-00B0MD-S8
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 09:58:34 +0000
Received: by mail-pf1-f193.google.com with SMTP id c8so11851987pfd.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Apr 2019 02:58:32 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

The caller set_file_temperature() is marked as inline as well.
It doesn't make much sense to leave is_extension_exist() un-inlined.

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
---
 fs/f2fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index f5e34e4670031..2fdcbe923a328 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -143,7 +143,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	return ERR_PTR(err);
 }
 
-static int is_extension_exist(const unsigned char *s, const char *sub)
+static inline int is_extension_exist(const unsigned char *s, const char *sub)
 {
 	size_t slen = strlen(s);
 	size_t sublen = strlen(sub);
-- 
2.21.0

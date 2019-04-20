From: Youngjun Yoo <youngjun.willow@gmail.com>
Subject: [PATCH 1/2] fs: f2fs: Replace spaces with tab.
Date: Sat, 20 Apr 2019 22:50:40 +0900
Message-ID: <20190420135040.GA7404@willow72>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <youngjun.willow@gmail.com>) id 1hHqOJ-0003wh-Cv
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Apr 2019 13:50:51 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hHqOI-001JBl-3K
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Apr 2019 13:50:51 +0000
Received: by mail-pf1-f195.google.com with SMTP id 10so3724919pfo.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 20 Apr 2019 06:50:49 -0700 (PDT)
Content-Disposition: inline
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

Modify coding style
ERROR: code indent should use tabs where possible

Signed-off-by: Youngjun Yoo <youngjun.willow@gmail.com>
---
 fs/f2fs/acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 63e599524085..a10b5abc1eb2 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -326,7 +326,7 @@ static int f2fs_acl_create_masq(struct posix_acl *acl, umode_t *mode_p)
 	}
 
 	*mode_p = (*mode_p & ~S_IRWXUGO) | mode;
-        return not_equiv;
+	return not_equiv;
 }
 
 static int f2fs_acl_create(struct inode *dir, umode_t *mode,
-- 
2.17.1

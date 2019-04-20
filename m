From: Youngjun Yoo <youngjun.willow@gmail.com>
Subject: [PATCH 2/2] fs: f2fs: insert space before the open
 parenthesis '('
Date: Sat, 20 Apr 2019 20:50:27 +0900
Message-ID: <20190420115027.GA5715@willow72>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willow72@willow72>) id 1hHohU-0002wM-IX
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Apr 2019 12:02:32 +0000
Received: from [122.45.59.17] (helo=willow72)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hHohT-001nCN-4c
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Apr 2019 12:02:32 +0000
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
Cc: fanatic.w72@gmail.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Modify coding style
ERROR: space required before the open parenthesis '('

Signed-off-by: Youngjun Yoo <youngjun.willow@gmail.com>
---
 fs/f2fs/acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index a10b5abc1eb2..217b290ae3a5 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -285,7 +285,7 @@ static int f2fs_acl_create_masq(struct posix_acl *acl, umode_t *mode_p)
 	/* assert(atomic_read(acl->a_refcount) == 1); */
 
 	FOREACH_ACL_ENTRY(pa, acl, pe) {
-		switch(pa->e_tag) {
+		switch (pa->e_tag) {
 		case ACL_USER_OBJ:
 			pa->e_perm &= (mode >> 6) | ~S_IRWXO;
 			mode &= (pa->e_perm << 6) | ~S_IRWXU;
-- 
2.17.1

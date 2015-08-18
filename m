From: Junesung Lee <junesoung412@gmail.com>
Subject: [PATCH] f2fs: fix typo
Date: Tue, 18 Aug 2015 22:42:15 +0900
Message-ID: <1439905335-31991-1-git-send-email-junesoung412@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, cm224.lee@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Junesung Lee <junesoung412@gmail.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Fix typo.

Signed-off-by : Junesung Lee <junesoung412@gmail.com>
---
 fs/f2fs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index c629762..b0a9dc9 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -45,7 +45,7 @@ config F2FS_FS_POSIX_ACL
 	default y
 	help
 	  Posix Access Control Lists (ACLs) support permissions for users and
-	  gourps beyond the owner/group/world scheme.
+	  groups beyond the owner/group/world scheme.
 
 	  To learn more about Access Control Lists, visit the POSIX ACLs for
 	  Linux website <http://acl.bestbits.at/>.
-- 
2.1.4

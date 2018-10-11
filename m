From: Sotirios-Efstathios Maneas <smaneas@cs.toronto.edu>
Subject: [PATCH 2/4] lib/libf2fs: Added missing statements
 related to error checking.
Date: Thu, 11 Oct 2018 18:21:06 -0400
Message-ID: <EE028FFF-676D-41CB-9094-F5104F226DB6@cs.toronto.edu>
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <smaneas@cs.toronto.edu>) id 1gAjKT-00026n-Kv
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Oct 2018 22:21:13 +0000
Received: from aviary.cs.toronto.edu ([128.100.3.90])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:DHE-RSA-AES128-SHA:128) (Exim 4.90_1) id 1gAjKS-006MiB-4b
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Oct 2018 22:21:13 +0000
Received: from airport-26.cs.toronto.edu ([128.100.27.26] helo=[172.31.34.138])
 by aviary.cs.toronto.edu (as smtp.cs.toronto.edu) with esmtpsa
 (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.82)
 (envelope-from <smaneas@cs.toronto.edu>) id 1gAjKM-0006Sd-B3
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Oct 2018 18:21:06 -0400
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

The following patch adds a few missing statements related to error checking.

Signed-off-by: Sotirios-Efstathios Maneas <smaneas@cs.toronto.edu>
---
 lib/libf2fs.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index a1f8beb..4ef9d7f 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -541,9 +541,8 @@ const char *get_rootdev()
 #else
 	struct stat sb;
 	int fd, ret;
-	char buf[32];
+	char buf[32] = {0};
 	char *uevent, *ptr;
-
 	static char rootdev[PATH_MAX + 1];
 
 	if (stat("/", &sb) == -1)
@@ -553,7 +552,6 @@ const char *get_rootdev()
 		major(sb.st_dev), minor(sb.st_dev));
 
 	fd = open(buf, O_RDONLY);
-
 	if (fd < 0)
 		return NULL;
 
@@ -565,18 +563,29 @@ const char *get_rootdev()
 		return NULL;
 	}
 
-	uevent = malloc(ret + 1);
+	uevent = calloc(ret + 1, 1);
+	if (!uevent) {
+		close(fd);
+		return NULL;
+	}
- 	uevent[ret] = '\0';
 
 	ret = read(fd, uevent, ret);
 	close(fd);
+	if (ret <= 0) {
+		free(uevent);
+		return NULL;
+	}
 
 	ptr = strstr(uevent, "DEVNAME");
-	if (!ptr)
+	if (!ptr) {
+		free(uevent);
 		return NULL;
+	}
 
-	ret = sscanf(ptr, "DEVNAME=%s\n", buf);
+	sscanf(ptr, "DEVNAME=%s\n", buf);
 	snprintf(rootdev, PATH_MAX + 1, "/dev/%s", buf);
+	free(uevent);
 
 	return rootdev;
 #endif
-- 
2.10.1

Kind regards,
Stathis Maneas

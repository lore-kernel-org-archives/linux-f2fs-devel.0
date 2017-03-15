From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] fsck.f2fs: a separate option for showing
	directory tree
Date: Wed, 15 Mar 2017 21:28:19 +0800
Message-ID: <64cead08-088e-5ed3-eafc-07c1b3f9943f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1co8yh-0006r8-03
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 15 Mar 2017 13:28:35 +0000
Received: from mail-io0-f195.google.com ([209.85.223.195])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1co8yg-0003WX-AT
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 15 Mar 2017 13:28:34 +0000
Received: by mail-io0-f195.google.com with SMTP id n76so2954884ioe.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 15 Mar 2017 06:28:34 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Showing directory tree reuses dbg_lv that if setting "-t", 
fsck.f2fs does not show any others.
Users may want much information include the debug info and directory tree.

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fsck/fsck.c       | 2 +-
 fsck/main.c       | 4 ++--
 include/f2fs_fs.h | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 116eae5..1c23199 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1028,7 +1028,7 @@ static void print_dentry(__u32 depth, __u8 *name,
 	int bit_offset;
 	unsigned char new[F2FS_NAME_LEN + 1];
 
-	if (c.dbg_lv != -1)
+	if (!c.show_dentry)
 		return;
 
 	name_len = le16_to_cpu(dentry[idx].name_len);
diff --git a/fsck/main.c b/fsck/main.c
index 8bf5cd9..cf1e8af 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -29,7 +29,7 @@ void fsck_usage()
 	MSG(0, "  -d debug level [default:0]\n");
 	MSG(0, "  -f check/fix entire partition\n");
 	MSG(0, "  -p preen mode [default:0 the same as -a [0|1]]\n");
-	MSG(0, "  -t show directory tree [-d -1]\n");
+	MSG(0, "  -t show directory tree\n");
 	exit(1);
 }
 
@@ -166,7 +166,7 @@ void f2fs_parse_options(int argc, char *argv[])
 				MSG(0, "Info: Force to fix corruption\n");
 				break;
 			case 't':
-				c.dbg_lv = -1;
+				c.show_dentry = 1;
 				break;
 
 
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 164315b..789bce1 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -285,6 +285,7 @@ struct f2fs_configuration {
 	char *extension_list;
 	const char *rootdev_name;
 	int dbg_lv;
+	int show_dentry;
 	int trim;
 	int func;
 	void *private;
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

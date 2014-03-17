From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: fix incorrect parsing with option string
Date: Mon, 17 Mar 2014 17:40:40 +0800
Message-ID: <000301cf41c5$10f247b0$32d6d710$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WPU36-0006XH-3q
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Mar 2014 09:41:36 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WPU34-00077G-46
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Mar 2014 09:41:36 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N2K003HJQX2HC90@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 17 Mar 2014 18:41:26 +0900 (KST)
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
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Previously 'background_gc={on***,off***}' is being parsed as correct option,
with this patch we cloud fix the trivial bug in mount process.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/super.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 057a3ef..6597290 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -258,9 +258,9 @@ static int parse_options(struct super_block *sb, char *options)
 
 			if (!name)
 				return -ENOMEM;
-			if (!strncmp(name, "on", 2))
+			if (!strncmp(name, "on", strlen(name)))
 				set_opt(sbi, BG_GC);
-			else if (!strncmp(name, "off", 3))
+			else if (!strncmp(name, "off", strlen(name)))
 				clear_opt(sbi, BG_GC);
 			else {
 				kfree(name);
-- 
1.7.9.5



------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech

From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] MAINTAINERS: add missed trace file for f2fs
Date: Mon, 06 Jul 2015 20:29:46 +0800
Message-ID: <004701d0b7e7$89c03d70$9d40b850$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZC5Xr-0001yS-1U
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 06 Jul 2015 12:30:47 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZC5Xp-0004NU-4G
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 06 Jul 2015 12:30:47 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NR202Q4YG2RD250@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 06 Jul 2015 21:30:27 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch adds missed trace file in maintainer-ship of f2fs,
so it completes the description of files maintained in f2fs,
and also it allows people to find correct mailing list by using
get_maintainer.pl when only patching the trace file of f2fs.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1939513..fa22f18 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4231,6 +4231,7 @@ F:	Documentation/filesystems/f2fs.txt
 F:	Documentation/ABI/testing/sysfs-fs-f2fs
 F:	fs/f2fs/
 F:	include/linux/f2fs_fs.h
+F:	include/trace/events/f2fs.h
 
 FUJITSU FR-V (FRV) PORT
 M:	David Howells <dhowells@redhat.com>
-- 
2.4.2



------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/

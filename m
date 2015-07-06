From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2] f2fs: restrict multimedia filename
Date: Mon, 06 Jul 2015 20:30:40 +0800
Message-ID: <004801d0b7e7$aca6df10$05f49d30$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZC5Yc-00020L-QX
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 06 Jul 2015 12:31:34 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZC5Yb-0000xq-3b
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 06 Jul 2015 12:31:34 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NR202SQ7G4DOB40@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 06 Jul 2015 21:31:25 +0900 (KST)
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

When testing with fs_mark, some blocks were written out as cold
data which were mixed with warm data, resulting in splitting more
bios.

This is because fs_mark will create file with random filename as
below:

559551ee~~~~~~~~15Z29OCC05JCKQP60JQ42MKV
559551ee~~~~~~~~NZAZ6X8OA8LHIIP6XD0L58RM
559551ef~~~~~~~~B15YDSWAK789HPSDZKYTW6WM
559551f1~~~~~~~~2DAE5DPS79785BUNTFWBEMP3
559551f1~~~~~~~~1MYDY0BKSQCJPI32Q8C514RM
559551f1~~~~~~~~YQOTMAOMN5CVRFOUNI026MP4
559551f3~~~~~~~~1WF42LPRTQJNPPGR3EINKMPE
559551f3~~~~~~~~8Y2NRK7CEPPAA02LY936PJPG

They are regarded as cold file since their filename are ended with
multimedia files' extension, but this should be wrong as we only
match the extension of filename, not the whole one.

In this patch, we try to fix the format of multimedia filename to:
"filename + '.' + extension", then we set cold file only its
filename matches the format.

So after this change, it will reduce the probability we set the
wrong cold file, also it helps a little for fs_mark's performance
on f2fs.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/namei.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 38f6887..1d790fb 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -91,7 +91,14 @@ static int is_multimedia_file(const unsigned char *s, const char *sub)
 	size_t slen = strlen(s);
 	size_t sublen = strlen(sub);
 
-	if (sublen > slen)
+	/*
+	 * filename format of multimedia file should be defined as:
+	 * "filename + '.' + extension".
+	 */
+	if (slen < sublen + 2)
+		return 0;
+
+	if (s[slen - sublen - 1] != '.')
 		return 0;
 
 	return !strncasecmp(s + slen - sublen, sub, sublen);
-- 
2.4.2



------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/

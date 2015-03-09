From: Yuan Zhong <yuan.mark.zhong@samsung.com>
Subject: [PATCH 1/3 v2] f2fs:remove unnecessary condition judgment
Date: Mon, 09 Mar 2015 02:43:51 +0000 (GMT)
Message-ID: <1261310236.1196121425869030109.JavaMail.weblogic@epmlwas01c>
Reply-To: yuan.mark.zhong@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuan.mark.zhong@samsung.com>) id 1YUnfl-0006lk-Ny
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 09 Mar 2015 02:44:01 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1YUnfj-0004GF-Rt
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 09 Mar 2015 02:44:01 +0000
Received: from epcpsbgx3.samsung.com
	(u163.gpu120.samsung.co.kr [203.254.230.163])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0NKX00A5JBL3K150@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 09 Mar 2015 11:43:51 +0900 (KST)
MIME-version: 1.0
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, =?gb2312?Q?=3F=3F=3F?= <cm224.lee@samsung.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Remove the unnecessary condition judgment, because 
'max_slots' has been initialized to '0' at the beginging 
of the function, as following:
if (max_slots)
       *max_slots = 0;
	
Signed-off-by: Yuan Zhong <yuan.mark.zhong@samsung.com>	
---
 fs/f2fs/dir.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 590aeef..1f1a1bc 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -139,7 +139,7 @@ struct f2fs_dir_entry *find_target_dentry(struct qstr *name, int *max_slots,
 			!memcmp(d->filename[bit_pos], name->name, name->len))
 			goto found;
 
-		if (max_slots && *max_slots >= 0 && max_len > *max_slots) {
+		if (max_slots && max_len > *max_slots) {
 			*max_slots = max_len;
 			max_len = 0;
 		}
-- 
1.7.9.5
------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/

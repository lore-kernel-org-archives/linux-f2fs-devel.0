From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH 2/2] f2fs: check range before defragment
Date: Wed, 8 Mar 2017 10:47:12 +0800
Message-ID: <20170308024712.18167-2-shengyong1@huawei.com>
References: <20170308024712.18167-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1clRq3-0002OX-Rb
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 03:00:31 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1clRq2-0000sl-69
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 08 Mar 2017 03:00:31 +0000
In-Reply-To: <20170308024712.18167-1-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

This patch checks the parameter range passed by ioctl to void that range
exceeds the max_file_blocks limit.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e0b2378..eb675f1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2045,6 +2045,12 @@ static int f2fs_ioc_defragment(struct file *filp, unsigned long arg)
 		goto out;
 	}
 
+	if (unlikely((range.start + range.len) >> PAGE_SHIFT >
+					sbi->max_file_blocks)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	err = f2fs_defragment_range(sbi, filp, &range);
 	f2fs_update_time(sbi, REQ_TIME);
 	if (err < 0)
-- 
2.10.1


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford

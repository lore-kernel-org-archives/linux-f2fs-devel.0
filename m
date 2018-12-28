From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH] parse.f2fs: fix parsing of f2fs_trace_ios
Date: Fri, 28 Dec 2018 13:06:43 +0530
Message-ID: <1545982603-8562-1-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <stummala@codeaurora.org>) id 1gcmi4-0004XV-1n
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 28 Dec 2018 07:37:32 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gcmhz-00361g-3z
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 28 Dec 2018 07:37:31 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net

It is incorrectly taking blkaddr as len because it missed to parse
op_flags in the trace print of f2fs_trace_ios.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 tools/f2fs_io_parse.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/f2fs_io_parse.c b/tools/f2fs_io_parse.c
index 7f97270..d146ead 100644
--- a/tools/f2fs_io_parse.c
+++ b/tools/f2fs_io_parse.c
@@ -191,6 +191,8 @@ static void handle_tp_ios(char *ptr)
 	rw = atoh(ptr);
 
 	ptr = strtok(NULL, " ");
+	/* int op_flags = atoh(ptr) */
+	ptr = strtok(NULL, " ");
 	/* unsigned long long blkaddr = atoh(ptr); */
 
 	ptr = strtok(NULL, " ");
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

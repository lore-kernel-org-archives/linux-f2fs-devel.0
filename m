From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 200871] F2FS experiences data loss (entry is
 completely lost) when an I/O failure occurs.
Date: Sat, 29 Sep 2018 01:58:03 +0000
Message-ID: <bug-200871-202145-eRTgTy4XY3@https.bugzilla.kernel.org/>
References: <bug-200871-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1g64WK-0002W2-3u
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 29 Sep 2018 01:58:12 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g64WH-008n0A-Q3
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 29 Sep 2018 01:58:12 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 71F2A1FFBD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 29 Sep 2018 01:58:03 +0000 (UTC)
In-Reply-To: <bug-200871-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=200871

--- Comment #15 from Chao Yu (chao@kernel.org) ---
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 71f5953..1b5d391 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -114,6 +114,11 @@ static void f2fs_write_end_io(struct bio *bio)
                        mapping_set_error(page->mapping, -EIO);
                        if (type == F2FS_WB_CP_DATA)
                                f2fs_stop_checkpoint(sbi, true);
+                       printk("f2fs_write_end_io, ino:%lu, idx:%lu, eio:%d,
type:%d\n",
+                               page->mapping->host->i_ino,
+                               page->index,
+                               test_bit(AS_EIO, &page->mapping->flags),
+                               type);
                }

                f2fs_bug_on(sbi, page->mapping == NODE_MAPPING(sbi) &&
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 5907775..76ac293 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1912,6 +1912,8 @@ int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info
*sbi,
        }

        ret2 = filemap_check_errors(NODE_MAPPING(sbi));
+       printk("f2fs_wait_on_node_pages_writeback, eio:%d\n",
+                       test_bit(AS_EIO, &NODE_MAPPING(sbi)->flags));
        if (!ret)
                ret = ret2;


Could you help to add above code to reproduce this issue in your environment?

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: print more parameters in trace_f2fs_map_blocks
Date: Tue, 26 Feb 2019 19:01:16 +0800
Message-ID: <20190226110116.36759-2-yuchao0@huawei.com>
References: <20190226110116.36759-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226110116.36759-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

for better map_blocks trace.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 include/trace/events/f2fs.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 4683ee10fe61..d4402484faf6 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -544,6 +544,9 @@ TRACE_EVENT(f2fs_map_blocks,
 		__field(block_t,	m_lblk)
 		__field(block_t,	m_pblk)
 		__field(unsigned int,	m_len)
+		__field(unsigned int,	m_flags)
+		__field(int,	m_seg_type)
+		__field(bool,	m_may_create)
 		__field(int,	ret)
 	),
 
@@ -553,15 +556,22 @@ TRACE_EVENT(f2fs_map_blocks,
 		__entry->m_lblk		= map->m_lblk;
 		__entry->m_pblk		= map->m_pblk;
 		__entry->m_len		= map->m_len;
+		__entry->m_flags	= map->m_flags;
+		__entry->m_seg_type	= map->m_seg_type;
+		__entry->m_may_create	= map->m_may_create;
 		__entry->ret		= ret;
 	),
 
 	TP_printk("dev = (%d,%d), ino = %lu, file offset = %llu, "
-		"start blkaddr = 0x%llx, len = 0x%llx, err = %d",
+		"start blkaddr = 0x%llx, len = 0x%llx, flags = %u,"
+		"seg_type = %d, may_create = %d, err = %d",
 		show_dev_ino(__entry),
 		(unsigned long long)__entry->m_lblk,
 		(unsigned long long)__entry->m_pblk,
 		(unsigned long long)__entry->m_len,
+		__entry->m_flags,
+		__entry->m_seg_type,
+		__entry->m_may_create,
 		__entry->ret)
 );
 
-- 
2.18.0.rc1

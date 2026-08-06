Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4985CC56208
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Aug 2026 13:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:
	References:In-Reply-To:Message-ID:Date:To:From:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xQFouCCnoZHLhF4fa2/YusyIL7XJVRCcfGEOM2Mq6dc=; b=SKBVXQ0IHGyV/tQbc58qas+7+0
	jk7zJLEN9JE85z8435G42UNvYb9jPwfI1/0vJm9NbwMaNDp78apuqOnMA1O6Ymxxq5vtcu4XcKHNj
	Mg2/vGwk5RqVmSOWq+LRdx5Sl/1h6gnFq6UDAVVjU2u1TNhqtdG6x+xgbDdzq/jhAr30=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wry0l-0004aN-H5;
	Thu, 06 Aug 2026 13:19:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyongpeng.storage@gmail.com>) id 1wry0l-0004aG-1T
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 13:19:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oaNXiC6F1NMVFBF0Xg8k2jXMyJHxvZPwe7sx4pKeMzI=; b=fB1EpPBszb9UUIa3Tia5nCCUyQ
 W9MhzZilCqEaGe3FxiM/FYI5QVuq1F3hgSnotNjGhj34di0w2qN/XrDO8cDHImUb0/OJ1NrZ+TKGm
 ECdQAuz1WVbjPxz7euJMm0QWd1+fwwEnFLu8nmxd5ZiS/Z22ljVeTF0EByFi0/nEVmms=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oaNXiC6F1NMVFBF0Xg8k2jXMyJHxvZPwe7sx4pKeMzI=; b=DiuX7oxWpCEpuQgeh02DisYxzv
 jzopKqujwEk1hPk7ElehahS3ov41QrpEqDWneprajTbnmaypiMs5giBgms3gCfn0BI/rQqxhv+zcq
 7/ZduoWErA/hwA7JASiUOQmdRzlwOxXU0TdeO5efPMjS2IgpS9I58N/K8hlPq+edSqCo=;
Received: from mail-pl1-f171.google.com ([209.85.214.171])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wry0m-0005vB-2u for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 13:19:51 +0000
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2cf52d15d88so20767165ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 06:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786022383; x=1786627183; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oaNXiC6F1NMVFBF0Xg8k2jXMyJHxvZPwe7sx4pKeMzI=;
 b=my4zjPEajXAhWMg2mezC3UFXyxCDgTnURKOtyUnj3CHVwPkmlapKats6XWIV6epw4g
 U0su43TaY0kSnOm4mkrc623uRUZPVXCpZTYHr3tm0DI/UxOOOj99ZlM2DIwcPf1olxfC
 ZyETzQgZMj9ASqEx4fpkiHKGRZ2FlERIMcL2Qr1lW4gDAWFdmmfvKv5aSGlsHqQUct/o
 Mh7HLjYTIRgpc8tOtDSUrgKKoHcJ0PSRwcMurdORvKka1oXXcdTV7MySPKE63c0LM0Xx
 ghTW3wxpmZ1tIC7jqhYh2vyfCY1bF6qYvg08U1G4+VOOnFASpWdoJZz8hUGhkd05137N
 0AyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786022383; x=1786627183;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oaNXiC6F1NMVFBF0Xg8k2jXMyJHxvZPwe7sx4pKeMzI=;
 b=YsRtdG2uOaweaepPUAKEzhQ6R5y3oHc01Y588yjsqeFf1S8fEmF2Lcnuhkjmrc+8gm
 W1oU3OpzyqTfbZLnrXYOOPBgHqY5j26EhjMhxLxFHEFdEL1TaZ7R0Fg3zWuatCeKiDle
 HQ/sBhiu1NLgL6nHvVAtcBanUqC4vr30b30W4bzafOdmCq3Kxo8+sK6/u4E/Nums5J6q
 +bweebUAOD8LBq+xCkNqIDlUhzKmMFYTv4CRJY16Q+JtrvPPgZ43goyPG/vt7V2P7iPy
 6bYBDTG8qqD6chIlSztfwjzrr0G5MXJaI4wXVbBHWEWi/TH9RyY6BdIoi3Rzdxo1K8uk
 3f1Q==
X-Gm-Message-State: AOJu0YzvWo5ieaXFT7eGOaGIehuNz/fcL/5tgxKVvb2jYtI4Cl7mPRoP
 RZhLj3CD/8sRzOmbJ1HxjVtJVcXFnjRB7UP3KOGFQMMLR1LvqCW6eG54
X-Gm-Gg: AR+sD117/pnacrGwkCPF8mDdwz+ool2N47KlLJc7bS8q90SyhPX03bywgiER4XSG/6X
 oVuRtOMsBZHodFvb1xsexQM4B9SCeAcZyFYXtvbN8QQgiwDEH9ZTxBCDz3bXYWWApwJ6Bhl/a/Z
 T0GwsHiygzClCb0jCt7KsD0cLEi57N/Ed0r+GaRJ4dBrMrPTLGCMCMfPTLqS0Svncowka1ay33j
 4nHwcm6AMciQEJc1JGBnm5OD96N/7sC3efQgOF8dCrORitismJEL4QY3AhOrzVdz78U+WqZVdOE
 zE5YIXeueEAxOBBjqDsVUdiaFVCsx7HAb94j5ORsTtfQvYWuX1olEa2JgszRe9Lj1HQbRaSojY1
 4ApPKWrqQVIeFKALk1XhEYgv8Tgbmbmj36x1D1nVRPEsUccTK7Y2FkDgkfH23M8Vv4Zsxxe+QW0
 F+TrAJGIf+orwU6ExOdo0FvsrHsPj7JmmsLu3zgEzZXc4yJKoOUMUrp8bJU9E+lDUM/LSCjIbuu
 srLqYU7K3OMF5RAnUNToRW1X5z/j2T7cdE=
X-Received: by 2002:a17:903:298f:b0:2c7:f12d:5d37 with SMTP id
 d9443c01a7336-2d0caa02fd3mr183275725ad.17.1786022382204; 
 Thu, 06 Aug 2026 06:19:42 -0700 (PDT)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0a9ffb2f7sm31736355ad.29.2026.08.06.06.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 06:19:38 -0700 (PDT)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu,  6 Aug 2026 21:19:02 +0800
Message-ID: <20260806131906.2961409-4-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806131906.2961409-2-yangyongpeng.storage@gmail.com>
References: <20260806131906.2961409-2-yangyongpeng.storage@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1wry0m-0005vB-2u
Subject: [f2fs-dev] [RFC PATCH v4 1/3] f2fs: introduce inline extent mapping
 for inode data blocks
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1030517511430281026=="
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

--===============1030517511430281026==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

Introduce an inline extent mapping mechanism that stores extent entries
directly within the inode's extra attribute area. This eliminates
indirect node lookups for frequently accessed file blocks.

Key design points:
- Inline extent area is placed after i_extra_end in the on-disk inode,
  within the i_extra_isize region. Its size is determined by the new
  field i_inline_ext_capacity (number of extent entries).
- Split the existing __le64 i_compr_blocks into __le32 i_compr_blocks +
  __le32 i_inline_ext_capacity to avoid enlarging the inode.
- Inline extent only caches mappings for indirect blocks (fofs >=
  ADDRS_PER_INODE). Direct block mappings continue to use i_addr[].
- Per-inode capacity is determined at file creation time based on
  extension matching rules.
- Supports a mount option inline_extent_size=<N> to set the default
  capacity for new inodes.
- Mutually exclusive with compression (compressed files cannot use
  inline extent).

The implementation includes:
- Binary search based extent lookup and insertion with merge/split
  support in fs/f2fs/iextent.c
- Integration with data block allocation and truncation paths
- Proper recovery handling (inline extent cleared during fsync replay)
- Kconfig option CONFIG_F2FS_INLINE_EXTENT to enable the feature

Test setup (Xiaomi smartphone, UFS 4.0 storage, f2fs):

  echo 1 > /sys/fs/f2fs/<dev>/inline_extent_enable
  echo 'mp4:256' > /sys/fs/f2fs/<dev>/inline_extent_extension_list
  fio --name=test --filename=data.mp4 --rw=write:4k --bs=64M \
      --size=8G --ioengine=libaio --direct=1
  sync
  fio --name=test --filename=data.mp4 --rw=write --bs=64M \
      --size=8G --ioengine=libaio --direct=1
  sync
  echo 3 > /proc/sys/vm/drop_caches
  fio --name=buffer-read --ioengine=libaio --rw=randread --bs=$BS \
      --size=8G --io_size=1G --numjobs=1 --filename=data.mp4

Results (random read bandwidth, MiB/s):
+---------------------------------------------------+
| BS     | baseline | inline ext | improvement      |
|--------+----------+------------+------------------|
| 4K     | 31.6     | 32.4       | +2.5%            |
| 8K     | 55.4     | 58.5       | +5.6%            |
| 32K    | 155.3    | 166.8      | +7.4%            |
| 64K    | 229.8    | 255.3      | +11.1%           |
| 128K   | 337.8    | 388        | +14.9%           |
+---------------------------------------------------+

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
v4:
- Do not cache NEW_ADDR in the inline extent area.
- Simplify the insert path.
- Remove the inline-extent code-coverage statistics.
v3:
- Modify inline extent format.
- Split struct f2fs_inode->i_compr_blocks (was __le64) into __le32 and
__le32 i_inline_ext_capacity.
- Re-ran the performance tests.
v2:
- Bypass inline extent lookup for F2FS_GET_BLOCK_PRECACHE.
- Unify fofs range check to "fofs >= direct_blocks".
- Remove NULL_ADDR caching support; simplify merge/split logic.
- Change f2fs_iext_convert_to_inline_extent return type to bool.
- Rename __is_extent_mergeable to __is_iextent_mergeable.
- Remove inode parameter from f2fs_iext_sanity_check.
- Reduce #ifdef nesting in node.c.
- Add complete benchmark data (4K/8K/32K/64K).
- Code style fixes.
---
 fs/f2fs/Kconfig         |  18 ++
 fs/f2fs/Makefile        |   1 +
 fs/f2fs/data.c          | 146 ++++++++++-
 fs/f2fs/dir.c           |   1 +
 fs/f2fs/f2fs.h          |  44 +++-
 fs/f2fs/file.c          |   1 +
 fs/f2fs/iextent.c       | 528 ++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/iextent.h       | 136 +++++++++++
 fs/f2fs/inline.c        |   1 +
 fs/f2fs/inode.c         |  41 +++-
 fs/f2fs/namei.c         |  67 +++++
 fs/f2fs/node.c          |  38 ++-
 fs/f2fs/node.h          |   4 +
 fs/f2fs/recovery.c      |  15 ++
 fs/f2fs/super.c         |  29 +++
 include/linux/f2fs_fs.h |   3 +-
 16 files changed, 1052 insertions(+), 21 deletions(-)
 create mode 100644 fs/f2fs/iextent.c
 create mode 100644 fs/f2fs/iextent.h

diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index 5916a02fb46d..4a5d900090ee 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -150,3 +150,21 @@ config F2FS_UNFAIR_RWSEM
 	help
 	  Use unfair rw_semaphore, if system configured IO priority by block
 	  cgroup.
+
+config F2FS_INLINE_EXTENT
+	bool "F2FS inline extent"
+	depends on F2FS_FS
+	default y
+	help
+	  Support the inline extent feature: leverage the inode's data block
+	  address area to store extent-format mapping relationships, replacing
+	  individual block addresses with compact extent entries to optimize
+	  large file random reads.
+
+config F2FS_INLINE_EXTENT_DEBUG
+	bool "F2FS inline extent debug"
+	depends on F2FS_INLINE_EXTENT
+	default n
+	help
+	  Support inline extent debug to stat code coverage and extents
+	  consistency check.
diff --git a/fs/f2fs/Makefile b/fs/f2fs/Makefile
index 8a7322d229e4..ed75c0b71a93 100644
--- a/fs/f2fs/Makefile
+++ b/fs/f2fs/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_F2FS_FS) += f2fs.o
 f2fs-y		:= dir.o file.o inode.o namei.o hash.o super.o inline.o
 f2fs-y		+= checkpoint.o gc.o data.o node.o segment.o recovery.o
 f2fs-y		+= shrinker.o extent_cache.o sysfs.o
+f2fs-$(CONFIG_F2FS_INLINE_EXTENT) += iextent.o
 f2fs-$(CONFIG_F2FS_STAT_FS) += debug.o
 f2fs-$(CONFIG_F2FS_FS_XATTR) += xattr.o
 f2fs-$(CONFIG_F2FS_FS_POSIX_ACL) += acl.o
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 042ed8ad9cc3..5be05792ee24 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -26,6 +26,7 @@
 #include "node.h"
 #include "segment.h"
 #include "iostat.h"
+#include "iextent.h"
 #include <trace/events/f2fs.h>
 
 #define NUM_PREALLOC_POST_READ_CTXS	128
@@ -1212,11 +1213,55 @@ static void f2fs_submit_page_read(struct inode *inode, struct fsverity_info *vi,
 	f2fs_submit_read_bio(sbi, bio, DATA);
 }
 
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+static void __set_iext_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr)
+{
+	block_t fofs = f2fs_start_bidx_of_node(ofs_of_node(dn->node_folio),
+						dn->inode) + dn->ofs_in_node;
+	int ret;
+
+	/*
+	 * Don't cache extent during recovery, be consistent with largest
+	 * extent.
+	 */
+	if (unlikely(is_sbi_flag_set(F2FS_I_SB(dn->inode), SBI_POR_DOING))) {
+		f2fs_bug_on(F2FS_I_SB(dn->inode),
+			EXT_ENTRY_COUNT(iext_get_header(dn->inode_folio)));
+		return;
+	}
+
+	f2fs_folio_wait_writeback(dn->inode_folio, NODE, true, true);
+	ret = f2fs_iext_update_data_blkaddr(dn->inode, dn->inode_folio, fofs,
+						blkaddr);
+	switch (ret) {
+	case F2FS_IEXT_INSERT_REMOVED:
+	case F2FS_IEXT_INSERT_NORMAL:
+		if (folio_mark_dirty(dn->inode_folio))
+			dn->node_changed = true;
+		break;
+	case F2FS_IEXT_INSERT_DROP:
+		break;
+	default:
+		f2fs_bug_on(F2FS_I_SB(dn->inode), 1);
+	}
+}
+#endif
+
 static void __set_data_blkaddr(struct dnode_of_data *dn, block_t blkaddr)
 {
 	__le32 *addr = get_dnode_addr(dn->inode, dn->node_folio);
 
 	dn->data_blkaddr = blkaddr;
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+	if (f2fs_iext_support_inline_extent(dn->inode, dn->inode_folio)
+			&& dn->inode_folio != dn->node_folio) {
+		f2fs_bug_on(F2FS_I_SB(dn->inode),
+				!dn->inode_folio_locked);
+		f2fs_bug_on(F2FS_I_SB(dn->inode),
+				!folio_test_locked(dn->inode_folio));
+		__set_iext_data_blkaddr(dn, blkaddr);
+	}
+#endif
 	addr[dn->ofs_in_node] = cpu_to_le32(dn->data_blkaddr);
 }
 
@@ -1655,6 +1700,60 @@ static bool map_is_mergeable(struct f2fs_sb_info *sbi,
 	return false;
 }
 
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+static bool f2fs_iext_map_blocks(struct inode *inode,
+		struct f2fs_map_blocks *map, int flag)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	unsigned int maxblocks = map->m_len;
+	pgoff_t pgoff = (pgoff_t)map->m_lblk;
+	block_t blkaddr;
+	struct folio *ifolio;
+	unsigned int len;
+	int ret;
+
+	if (f2fs_compressed_file(inode))
+		return false;
+
+	ifolio = f2fs_get_inode_folio(sbi, inode->i_ino);
+	if (IS_ERR(ifolio))
+		return false;
+	if (!f2fs_iext_support_inline_extent(inode, ifolio) ||
+			pgoff < ADDRS_PER_INODE(inode)) {
+		f2fs_folio_put(ifolio, true);
+		return false;
+	}
+	ret = f2fs_iext_lookup_blkaddr(inode, ifolio, pgoff, &blkaddr, &len);
+	f2fs_folio_put(ifolio, true);
+	if (ret)
+		return false;
+
+	map->m_pblk = blkaddr;
+	map->m_len = min_t(unsigned int, maxblocks, len);
+	map->m_flags = F2FS_MAP_MAPPED;
+	if (map->m_next_extent)
+		*map->m_next_extent = pgoff + map->m_len;
+
+	/* for hardware encryption, but to avoid potential issue in future */
+	if (flag == F2FS_GET_BLOCK_DIO)
+		f2fs_wait_on_block_writeback_range(inode,
+					map->m_pblk, map->m_len);
+
+	map->m_multidev_dio = f2fs_allow_multi_device_dio(sbi, flag);
+	if (map->m_multidev_dio) {
+		int bidx = f2fs_target_device_index(sbi, map->m_pblk);
+		struct f2fs_dev_info *dev = &sbi->devs[bidx];
+
+		map->m_bdev = dev->bdev;
+		map->m_len = min(map->m_len, dev->end_blk + 1 - map->m_pblk);
+		map->m_pblk -= dev->start_blk;
+	} else {
+		map->m_bdev = inode->i_sb->s_bdev;
+	}
+	return true;
+}
+#endif
+
 /*
  * f2fs_map_blocks() tries to find or build mapping relationship which
  * maps continuous logical blocks to physical blocks, and return such
@@ -1704,6 +1803,23 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 		goto map_more;
 	}
 
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+	/*
+	 * Precache need to load all mapping to read extent cache, so we need
+	 * to bypass inline extent.
+	 */
+	if (!map->m_may_create && flag != F2FS_GET_BLOCK_PRECACHE &&
+			f2fs_iext_map_blocks(inode, map, flag)) {
+		if (map->m_len == maxblocks ||
+			map->m_multidev_dio ||
+			flag != F2FS_GET_BLOCK_FIEMAP)
+			goto out;
+		pgofs =	(pgoff_t)map->m_lblk + map->m_len;
+		ofs = map->m_len;
+		goto map_more;
+	}
+#endif
+
 	map->m_bdev = inode->i_sb->s_bdev;
 	map->m_multidev_dio =
 		f2fs_allow_multi_device_dio(F2FS_I_SB(inode), flag);
@@ -3716,6 +3832,32 @@ void f2fs_write_failed(struct inode *inode, loff_t to)
 	}
 }
 
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+static bool f2fs_iext_get_data_blkaddr(struct inode *inode,
+			struct folio *ifolio, pgoff_t index, block_t *blkaddr)
+{
+	int ret;
+
+	if (f2fs_compressed_file(inode))
+		return false;
+	if (!f2fs_iext_support_inline_extent(inode, ifolio) ||
+			index < ADDRS_PER_INODE(inode))
+		return false;
+
+	ret = f2fs_iext_lookup_blkaddr(inode, ifolio, index, blkaddr, NULL);
+	if (ret)
+		return false;
+
+	return true;
+}
+#else
+static bool f2fs_iext_get_data_blkaddr(struct inode *inode,
+			struct folio *ifolio, pgoff_t index, block_t *blkaddr)
+{
+	return false;
+}
+#endif
+
 static int prepare_write_begin(struct f2fs_sb_info *sbi,
 			struct folio *folio, loff_t pos, unsigned int len,
 			block_t *blk_addr, bool *node_changed)
@@ -3776,7 +3918,9 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 	}
 
 	if (!f2fs_lookup_read_extent_cache_block(inode, index,
-						 &dn.data_blkaddr)) {
+				&dn.data_blkaddr) &&
+			!f2fs_iext_get_data_blkaddr(inode, ifolio, index,
+				&dn.data_blkaddr)) {
 		if (IS_DEVICE_ALIASING(inode)) {
 			err = -ENODATA;
 			goto out;
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index a9563f7fcd88..d7dd3c8c8684 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -16,6 +16,7 @@
 #include "node.h"
 #include "acl.h"
 #include "xattr.h"
+#include "iextent.h"
 #include <trace/events/f2fs.h>
 
 static inline bool f2fs_should_fallback_to_linear(struct inode *dir)
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8011bbdf2c68..d5326681fc64 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -144,6 +144,7 @@ enum f2fs_mount_opt {
 	 * string rather than using the MS_LAZYTIME flag, so this must remain.
 	 */
 	F2FS_MOUNT_LAZYTIME,
+	F2FS_MOUNT_INLINE_EXTENT_SIZE,
 	F2FS_MOUNT_RESERVE_NODE,
 };
 
@@ -229,6 +230,7 @@ struct f2fs_mount_info {
 	kgid_t s_resgid;		/* reserved blocks for gid */
 	int active_logs;		/* # of active logs */
 	int inline_xattr_size;		/* inline xattr size */
+	int inline_extent_size;		/* default inline extent capacity */
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	struct f2fs_fault_info fault_info;	/* For fault injection */
 #endif
@@ -939,6 +941,7 @@ enum {
 	FI_ATOMIC_REPLACE,	/* indicate atomic replace */
 	FI_OPENED_FILE,		/* indicate file has been opened */
 	FI_DONATE_FINISHED,	/* indicate page donation of file has been finished */
+	FI_INLINE_EXTENT,	/* indicate file uses inline extent mapping */
 	FI_MAX,			/* max flag, never be used */
 };
 
@@ -998,6 +1001,7 @@ struct f2fs_inode_info {
 	int i_extra_isize;		/* size of extra space located in i_addr */
 	kprojid_t i_projid;		/* id for project quota */
 	int i_inline_xattr_size;	/* inline xattr size */
+	int i_inline_ext_capacity;	/* # of inline extent entries */
 	struct timespec64 i_crtime;	/* inode creation time */
 	struct timespec64 i_disk_time[3];/* inode disk times */
 
@@ -1136,6 +1140,8 @@ static inline void set_new_dnode(struct dnode_of_data *dn, struct inode *inode,
 	dn->inode_folio = ifolio;
 	dn->node_folio = nfolio;
 	dn->nid = nid;
+	if (ifolio != NULL)
+		dn->inode_folio_locked = folio_test_locked(ifolio);
 }
 
 /*
@@ -1796,6 +1802,10 @@ struct f2fs_sb_info {
 	struct f2fs_nm_info *nm_info;		/* node manager */
 	struct inode *node_inode;		/* cache node blocks */
 
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+	struct f2fs_iext_info *iext_info;
+#endif
+
 	/* for segment-related operations */
 	struct f2fs_sm_info *sm_info;		/* segment manager */
 
@@ -3133,12 +3143,15 @@ static inline void f2fs_put_page(struct page *page, bool unlock)
 	f2fs_folio_put(page_folio(page), unlock);
 }
 
+static inline __le32 *get_dnode_addr(struct inode *inode,
+					struct folio *node_folio);
 static inline void f2fs_put_dnode(struct dnode_of_data *dn)
 {
 	if (dn->node_folio)
 		f2fs_folio_put(dn->node_folio, true);
 	if (dn->inode_folio && dn->node_folio != dn->inode_folio)
-		f2fs_folio_put(dn->inode_folio, false);
+		f2fs_folio_put(dn->inode_folio,
+				dn->inode_folio_locked);
 	dn->node_folio = NULL;
 	dn->inode_folio = NULL;
 }
@@ -3636,6 +3649,27 @@ static inline bool f2fs_is_cow_file(struct inode *inode)
 	return is_inode_flag_set(inode, FI_COW_FILE);
 }
 
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+static inline bool f2fs_iext_support_inline_extent(struct inode *inode,
+			struct folio *ifolio)
+{
+	if (!inode) {
+		struct f2fs_inode *ri = (struct f2fs_inode *)ifolio;
+
+		if (!(ri->i_inline & F2FS_EXTRA_ATTR))
+			return false;
+		return le32_to_cpu(ri->i_inline_ext_capacity) > 0;
+	}
+	return is_inode_flag_set(inode, FI_INLINE_EXTENT);
+}
+#else
+static inline bool f2fs_iext_support_inline_extent(struct inode *inode,
+			struct folio *ifolio)
+{
+	return false;
+}
+#endif
+
 static inline void *inline_data_addr(struct inode *inode, struct folio *folio)
 {
 	__le32 *addr = get_dnode_addr(inode, folio);
@@ -3782,6 +3816,11 @@ static inline int get_inline_xattr_addrs(struct inode *inode)
 	return F2FS_I(inode)->i_inline_xattr_size;
 }
 
+static inline int get_inline_ext_capacity(struct inode *inode)
+{
+	return F2FS_I(inode)->i_inline_ext_capacity;
+}
+
 #define f2fs_get_inode_mode(i) \
 	((is_inode_flag_set(i, FI_ACL_MODE)) ? \
 	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
@@ -5003,7 +5042,8 @@ static inline bool f2fs_may_compress(struct inode *inode)
 {
 	if (IS_SWAPFILE(inode) || f2fs_is_pinned_file(inode) ||
 		f2fs_is_atomic_file(inode) || f2fs_has_inline_data(inode) ||
-		f2fs_is_mmap_file(inode))
+		f2fs_is_mmap_file(inode) ||
+		f2fs_iext_support_inline_extent(inode, NULL))
 		return false;
 	return S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode);
 }
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c54897a25981..4bb6729a7f56 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -33,6 +33,7 @@
 #include "acl.h"
 #include "gc.h"
 #include "iostat.h"
+#include "iextent.h"
 #include <trace/events/f2fs.h>
 #include <uapi/linux/f2fs.h>
 
diff --git a/fs/f2fs/iextent.c b/fs/f2fs/iextent.c
new file mode 100644
index 000000000000..e2eed9e79960
--- /dev/null
+++ b/fs/f2fs/iextent.c
@@ -0,0 +1,528 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fs/f2fs/iextent.c
+ *
+ * Copyright (c) 2026 Xiaomi Technology Co., Ltd.
+ *             http://www.mi.com/
+ */
+#include <linux/f2fs_fs.h>
+
+#include "f2fs.h"
+#include "iextent.h"
+
+/*
+ * ASSERT - debug assertion for inline extent code.
+ * Uses f2fs_bug_on when sbi is available, falls back to WARN_ON_ONCE otherwise.
+ */
+#define ASSERT(sbi, condition) do {			\
+	if (!(sbi))					\
+		WARN_ON_ONCE(!(condition));		\
+	else						\
+		f2fs_bug_on((sbi), !(condition));	\
+} while (0)
+
+/*
+ * Borrowed from ext4_ext_binsearch_idx.
+ *
+ * __iext_binsearch_idx:
+ * binary search for the closest index of the given block
+ * the header must be checked before calling this
+ */
+static int __iext_binsearch_idx(struct inode *inode, struct folio *ifolio,
+			block_t block)
+{
+	struct f2fs_iext_header *eh = iext_get_header(ifolio);
+	struct f2fs_extent *r, *l, *m;
+
+	if (EXT_ENTRY_COUNT(eh) == 0)
+		return -1;
+
+	l = EXT_FIRST_INDEX(eh) + 1;
+	r = EXT_LAST_INDEX(eh);
+	while (l <= r) {
+		m = l + (r - l) / 2;
+		if (block < le32_to_cpu(m->fofs))
+			r = m - 1;
+		else
+			l = m + 1;
+	}
+
+#ifdef CONFIG_F2FS_INLINE_EXTENT_DEBUG
+	{
+		struct f2fs_sb_info *sbi = inode ? F2FS_I_SB(inode) : NULL;
+		struct f2fs_extent *chix, *ix;
+		int k;
+
+		chix = ix = EXT_FIRST_INDEX(eh);
+		for (k = 0; k < EXT_ENTRY_COUNT(eh); k++, ix++) {
+			if (k != 0 && le32_to_cpu(ix->fofs) <=
+					le32_to_cpu(ix[-1].fofs)) {
+				f2fs_debug(sbi, "k=%d, ix=0x%p, first=0x%p",
+						k, ix, EXT_FIRST_INDEX(eh));
+				f2fs_debug(sbi, "%u <= %u",
+						le32_to_cpu(ix->fofs),
+						le32_to_cpu(ix[-1].fofs));
+			}
+			ASSERT(sbi, !(k && le32_to_cpu(ix->fofs)
+						<= le32_to_cpu(ix[-1].fofs)));
+			if (block < le32_to_cpu(ix->fofs))
+				break;
+			chix = ix;
+		}
+		ASSERT(sbi, chix == l - 1);
+	}
+#endif
+
+	return l - EXT_FIRST_INDEX(eh) - 1;
+}
+
+static void __ext_add_one_entry(struct f2fs_iext_header *eh, int index,
+			struct f2fs_extent *ext)
+{
+	int inline_extents = EXT_ENTRY_COUNT(eh);
+
+	if (WARN_ON_ONCE(index < 0 || index > inline_extents))
+		return;
+
+	memmove(&eh->exts[index + 1], &eh->exts[index],
+			(inline_extents - index) * sizeof(struct f2fs_extent));
+	memcpy(&eh->exts[index], ext, sizeof(struct f2fs_extent));
+
+	eh->cnt = cpu_to_le32(inline_extents + 1);
+}
+
+static void __ext_del_one_entry(struct f2fs_iext_header *eh, int index)
+{
+	int inline_extents = EXT_ENTRY_COUNT(eh);
+
+	memmove(&eh->exts[index], &eh->exts[index + 1],
+			(inline_extents - index - 1) *
+			sizeof(struct f2fs_extent));
+
+	eh->cnt = cpu_to_le32(inline_extents - 1);
+}
+
+enum {
+	F2FS_EXT_HIT_LEFT = -1,
+	F2FS_EXT_HIT_MID = 0,
+	F2FS_EXT_HIT_RIGHT = 1,
+};
+
+static int __is_iextent_hit(struct f2fs_extent *ext, block_t fofs)
+{
+	block_t start = F2FS_EXT_LOGICAL_START(ext);
+	block_t end = F2FS_EXT_LOGICAL_END(ext);
+
+	if (fofs < start)
+		return F2FS_EXT_HIT_LEFT;
+	if (fofs > end)
+		return F2FS_EXT_HIT_RIGHT;
+	return F2FS_EXT_HIT_MID;
+}
+
+static bool __is_iextent_mergeable(struct f2fs_extent *left,
+			struct f2fs_extent *right)
+{
+	if (F2FS_EXT_LOGICAL_END(left) + 1 != F2FS_EXT_LOGICAL_START(right))
+		return false;
+	return F2FS_EXT_PHYSICAL_END(left) + 1
+				== F2FS_EXT_PHYSICAL_START(right);
+}
+
+static bool __iext_try_merge(struct f2fs_iext_header *eh, int i)
+{
+	struct f2fs_extent *a, *b;
+
+	if (i < 0 || i + 1 >= EXT_ENTRY_COUNT(eh))
+		return false;
+
+	a = &eh->exts[i];
+	b = &eh->exts[i + 1];
+	if (!__is_iextent_mergeable(a, b))
+		return false;
+
+	a->len = cpu_to_le32(F2FS_EXT_LEN(a) + F2FS_EXT_LEN(b));
+	__ext_del_one_entry(eh, i + 1);
+	return true;
+}
+
+/*
+ * Returns the array index at which a replacement {fofs, ...} extent should be
+ * inserted. For F2FS_EXT_HIT_LEFT/RIGHT (@fofs falls in a gap) nothing is
+ * modified.
+ */
+static int __iext_punch(struct f2fs_iext_header *eh, int index, int hit,
+			block_t fofs)
+{
+	struct f2fs_extent *ext = &eh->exts[index];
+	block_t start = F2FS_EXT_LOGICAL_START(ext);
+	block_t end = F2FS_EXT_LOGICAL_END(ext);
+	block_t blk = F2FS_EXT_PHYSICAL_START(ext);
+	unsigned int len = F2FS_EXT_LEN(ext);
+	struct f2fs_extent right;
+
+	switch (hit) {
+	case F2FS_EXT_HIT_LEFT:
+		return 0;
+	case F2FS_EXT_HIT_RIGHT:
+		return index + 1;
+	case F2FS_EXT_HIT_MID:
+		if (len == 1) {
+			__ext_del_one_entry(eh, index);
+			return index;
+		}
+		if (fofs == start) {
+			ext->fofs = cpu_to_le32(start + 1);
+			ext->blk = cpu_to_le32(blk + 1);
+			ext->len = cpu_to_le32(len - 1);
+			return index;
+		}
+		if (fofs == end) {
+			ext->len = cpu_to_le32(len - 1);
+			return index + 1;
+		}
+		/* split: keep [start, fofs-1], add [fofs+1, end] after it */
+		right.fofs = cpu_to_le32(fofs + 1);
+		right.len = cpu_to_le32(end - fofs);
+		right.blk = cpu_to_le32(blk + (fofs + 1 - start));
+		ext->len = cpu_to_le32(fofs - start);
+		__ext_add_one_entry(eh, index + 1, &right);
+		return index + 1;
+	}
+	return index;
+}
+
+/*
+ * -1 for a delete. 0 for a overwrite/head-or-tail delete.
+ * +1 for a head/tail overwrite or a middle delete, +2 for split.
+ */
+static int __iext_slot_delta(int hit, unsigned int len, block_t start,
+			block_t end, block_t fofs, block_t blkaddr)
+{
+	bool insert = (blkaddr != NULL_ADDR);
+
+	if (hit != F2FS_EXT_HIT_MID)
+		return insert ? 1 : 0;
+	if (len == 1)
+		return insert ? 0 : -1;
+	if (fofs == start || fofs == end)
+		return insert ? 1 : 0;
+	return insert ? 2 : 1;
+}
+
+/* Precondition: the covering extent has len > 1. */
+static void __iext_invalidate_one(struct f2fs_iext_header *eh, int index,
+			block_t fofs)
+{
+	struct f2fs_extent *ext = &eh->exts[index];
+	block_t start = F2FS_EXT_LOGICAL_START(ext);
+	block_t blk = F2FS_EXT_PHYSICAL_START(ext);
+	unsigned int len = F2FS_EXT_LEN(ext);
+
+	if (fofs == start) {
+		/* trim the head, dropping only @fofs */
+		ext->fofs = cpu_to_le32(start + 1);
+		ext->blk = cpu_to_le32(blk + 1);
+		ext->len = cpu_to_le32(len - 1);
+	} else {
+		/* drop [fofs, end] from the cache (also covers fofs == end) */
+		ext->len = cpu_to_le32(fofs - start);
+	}
+}
+
+/*
+ * Overwrite the mapping of a single logical block @fofs with @blkaddr
+ * (NULL_ADDR mean "invalidate the mapping").  Keeps the array sorted, merged
+ * and non-overlapping.
+ *
+ * Soundness rule: the inline area is a cache, so on the full/no-room paths we
+ * may fail to store the new mapping, but we must never leave a *stale* mapping
+ * for @fofs behind.  Hence whenever @fofs is covered we always remove its old
+ * mapping, even if the replacement cannot be inserted.
+ *
+ * The return value tells the caller whether the ifolio must be marked dirty:
+ *   F2FS_IEXT_INSERT_NORMAL/REMOVED - the area changed, mark dirty
+ *   F2FS_IEXT_INSERT_DROP           - nothing changed, no need to dirty
+ */
+int f2fs_iext_update_data_blkaddr(struct inode *inode, struct folio *ifolio,
+					block_t fofs, block_t blkaddr)
+{
+	struct f2fs_iext_header *eh = iext_get_header(ifolio);
+	int max_inline_extents = f2fs_iext_max_extents(inode);
+	struct f2fs_extent ext;
+	struct f2fs_extent *cur;
+	int index, hit, delta;
+	bool modified = false;
+	block_t start, end;
+	unsigned int len;
+
+	/* NEW_ADDR blocks are never cached. Treat it as a delete. */
+	if (blkaddr == NEW_ADDR)
+		blkaddr = NULL_ADDR;
+
+	ext.fofs = cpu_to_le32(fofs);
+	ext.blk = cpu_to_le32(blkaddr);
+	ext.len = cpu_to_le32(1);
+
+	if (EXT_ENTRY_COUNT(eh) == 0) {
+		if (blkaddr == NULL_ADDR || max_inline_extents < 1)
+			return F2FS_IEXT_INSERT_DROP;
+		__ext_add_one_entry(eh, 0, &ext);
+		return F2FS_IEXT_INSERT_NORMAL;
+	}
+
+	/* Fast path: contiguous append/merge with the last extent. */
+	if (blkaddr != NULL_ADDR) {
+		cur = EXT_LAST_INDEX(eh);
+		if (__is_iextent_mergeable(cur, &ext)) {
+			cur->len = cpu_to_le32(F2FS_EXT_LEN(cur) + 1);
+			return F2FS_IEXT_INSERT_NORMAL;
+		}
+	}
+
+	index = __iext_binsearch_idx(inode, ifolio, fofs);
+	cur = &eh->exts[index];
+	hit = __is_iextent_hit(cur, fofs);
+	start = F2FS_EXT_LOGICAL_START(cur);
+	end = F2FS_EXT_LOGICAL_END(cur);
+	len = F2FS_EXT_LEN(cur);
+
+	if (hit == F2FS_EXT_HIT_MID &&
+			F2FS_EXT_PHYSICAL_START(cur) + fofs - start == blkaddr)
+		return F2FS_IEXT_INSERT_DROP;
+
+	if (hit != F2FS_EXT_HIT_MID && blkaddr == NULL_ADDR)
+		return F2FS_IEXT_INSERT_DROP;
+
+	/*
+	 * Reserve room for the peak occupancy.  When the area is full, evict
+	 * from the tail.
+	 */
+	delta = __iext_slot_delta(hit, len, start, end, fofs, blkaddr);
+	while (EXT_ENTRY_COUNT(eh) + delta > max_inline_extents) {
+		struct f2fs_extent *last = EXT_LAST_INDEX(eh);
+
+		if (fofs >= F2FS_EXT_LOGICAL_START(last))
+			break;
+		__ext_del_one_entry(eh, EXT_ENTRY_COUNT(eh) - 1);
+		modified = true;
+	}
+
+	/*
+	 * Still no room: drop its stale mapping without splitting; otherwise
+	 * there is nothing to store.
+	 */
+	if (EXT_ENTRY_COUNT(eh) + delta > max_inline_extents) {
+		if (hit == F2FS_EXT_HIT_MID) {
+			__iext_invalidate_one(eh, index, fofs);
+			return F2FS_IEXT_INSERT_REMOVED;
+		}
+		return modified ? F2FS_IEXT_INSERT_REMOVED :
+				F2FS_IEXT_INSERT_DROP;
+	}
+
+	index = __iext_punch(eh, index, hit, fofs);
+	if (blkaddr == NULL_ADDR)
+		return F2FS_IEXT_INSERT_NORMAL;
+
+	__ext_add_one_entry(eh, index, &ext);
+
+	/* Coalesce the freshly inserted extent with its neighbours. */
+	if (index > 0 && __iext_try_merge(eh, index - 1))
+		index--;
+	__iext_try_merge(eh, index);
+
+	return F2FS_IEXT_INSERT_NORMAL;
+}
+
+int f2fs_iext_lookup_blkaddr(struct inode *inode, struct folio *ifolio,
+					block_t fofs, block_t *blkaddr,
+					unsigned int *len)
+{
+	struct f2fs_iext_header *eh = iext_get_header(ifolio);
+	struct f2fs_extent *last_ext = EXT_LAST_INDEX(eh);
+	struct f2fs_extent *ext;
+	int index, hit;
+	block_t blk_start, fofs_start;
+
+	if (EXT_ENTRY_COUNT(eh) == 0 || F2FS_EXT_LOGICAL_END(last_ext) < fofs)
+		return -ENOENT;
+
+	index = __iext_binsearch_idx(inode, ifolio, fofs);
+	if (index < 0)
+		return -ENOENT;
+	ext = &eh->exts[index];
+	hit = __is_iextent_hit(ext, fofs);
+	if (hit != F2FS_EXT_HIT_MID)
+		return -ENOENT;
+	blk_start = F2FS_EXT_PHYSICAL_START(ext);
+	fofs_start = F2FS_EXT_LOGICAL_START(ext);
+	*blkaddr = blk_start + fofs - fofs_start;
+	if (len)
+		*len = F2FS_EXT_LEN(ext) - (fofs - fofs_start);
+
+	return 0;
+}
+
+/* truncate extent starting from @fofs. */
+void f2fs_iext_truncate_from_blkaddr(struct inode *inode,
+					struct folio *ifolio, block_t fofs)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	int index, hit;
+	unsigned int len;
+	struct f2fs_iext_header *eh = iext_get_header(ifolio);
+	int inline_extents = EXT_ENTRY_COUNT(eh);
+	struct f2fs_extent *ext;
+	block_t fofs_start;
+
+	if (inline_extents == 0)
+		return;
+	index = __iext_binsearch_idx(inode, ifolio, fofs);
+	ext = &eh->exts[index];
+	hit = __is_iextent_hit(ext, fofs);
+	switch (hit) {
+	case F2FS_EXT_HIT_LEFT:
+		ASSERT(sbi, index == 0);
+		eh->cnt = cpu_to_le32(0);
+		break;
+	case F2FS_EXT_HIT_RIGHT:
+		eh->cnt = cpu_to_le32(index + 1);
+		break;
+	case F2FS_EXT_HIT_MID:
+		fofs_start = F2FS_EXT_LOGICAL_START(ext);
+		len = F2FS_EXT_LEN(ext);
+
+		if (len == 1 || fofs == fofs_start) {
+			eh->cnt = cpu_to_le32(index);
+			break;
+		}
+		ext->len = cpu_to_le32(fofs - fofs_start);
+		eh->cnt = cpu_to_le32(index + 1);
+		break;
+	default:
+		ASSERT(sbi, 0);
+	}
+}
+
+int f2fs_iext_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
+					bool set, unsigned int capacity)
+{
+	struct f2fs_iext_info *iext_info = sbi->iext_info;
+	__u8 (*extlist)[F2FS_EXTENSION_LEN] = iext_info->extensions;
+	int count;
+	int i, ret = 0;
+	unsigned long flag;
+
+	if (strlen(name) >= F2FS_EXTENSION_LEN)
+		return -EINVAL;
+
+	spin_lock_irqsave(&iext_info->iext_ext_lock, flag);
+	count = iext_info->iext_ext_cnt;
+	if (set && count == IEXT_EXT_NUM) {
+		ret = -EINVAL;
+		goto out;
+	}
+	for (i = 0; i < count; i++) {
+		if (strcmp(name, extlist[i]))
+			continue;
+
+		if (set) {
+			/* Extension already exists — update its capacity. */
+			iext_info->ext_capacity[i] = capacity;
+			goto out;
+		}
+
+		/* Remove: shift both extensions and ext_capacity arrays. */
+		memcpy(extlist[i], extlist[i + 1],
+				F2FS_EXTENSION_LEN * (count - i - 1));
+		memset(extlist[count - 1], 0, F2FS_EXTENSION_LEN);
+		memmove(&iext_info->ext_capacity[i],
+				&iext_info->ext_capacity[i + 1],
+				sizeof(unsigned int) * (count - i - 1));
+		iext_info->ext_capacity[count - 1] = 0;
+		iext_info->iext_ext_cnt--;
+		goto out;
+	}
+
+	if (!set) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	memcpy(extlist[count], name, strlen(name));
+	iext_info->ext_capacity[count] = capacity;
+	iext_info->iext_ext_cnt++;
+out:
+	spin_unlock_irqrestore(&iext_info->iext_ext_lock, flag);
+	return ret;
+}
+
+bool f2fs_iext_sanity_check(struct folio *ifolio)
+{
+	struct f2fs_iext_header *eh = iext_get_header(ifolio);
+	struct f2fs_extent *ix;
+	int inline_extents = EXT_ENTRY_COUNT(eh);
+	int max_inline_extents =
+		le32_to_cpu(F2FS_NODE(ifolio)->i.i_inline_ext_capacity);
+	int extra_isize =
+		le16_to_cpu(F2FS_NODE(ifolio)->i.i_extra_isize);
+	int k;
+
+	if (!S_ISREG(le16_to_cpu(F2FS_NODE(ifolio)->i.i_mode)))
+		return false;
+	if (inline_extents > max_inline_extents)
+		return false;
+	if (extra_isize != F2FS_TOTAL_EXTRA_ATTR_SIZE +
+			max_inline_extents * sizeof (struct f2fs_extent) +
+			sizeof(struct f2fs_iext_header))
+		return false;
+
+	ix = EXT_FIRST_INDEX(eh);
+	for (k = 0; k < inline_extents; k++, ix++) {
+		if (F2FS_EXT_LEN(ix) == 0)
+			return false;
+		/* only real block addresses are cached */
+		if (F2FS_EXT_PHYSICAL_START(ix) == NULL_ADDR ||
+				F2FS_EXT_PHYSICAL_START(ix) == NEW_ADDR)
+			return false;
+		if (F2FS_EXT_LOGICAL_START(ix) > UINT_MAX - F2FS_EXT_LEN(ix))
+			return false;
+		if (F2FS_EXT_PHYSICAL_START(ix) > UINT_MAX - F2FS_EXT_LEN(ix))
+			return false;
+		if (k == 0)
+			continue;
+		if (F2FS_EXT_LOGICAL_START(ix) <=
+				F2FS_EXT_LOGICAL_END(&ix[-1]))
+			return false;
+	}
+	return true;
+}
+
+int f2fs_iext_info_init(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_iext_info *iext_info;
+
+	iext_info = f2fs_kvzalloc(sbi, sizeof(struct f2fs_iext_info),
+				GFP_KERNEL);
+	if (!iext_info)
+		return -ENOMEM;
+
+	spin_lock_init(&iext_info->iext_ext_lock);
+	if (F2FS_OPTION(sbi).inline_extent_size)
+		iext_info->default_capacity =
+				F2FS_OPTION(sbi).inline_extent_size;
+	else
+		iext_info->default_capacity = F2FS_IEXT_DEF_CAPACITY;
+	iext_info->iext_enable = 1;
+	sbi->iext_info = iext_info;
+	f2fs_iext_update_extension_list(sbi, "*", true, 256);
+	return 0;
+}
+
+void f2fs_iext_info_destroy(struct f2fs_sb_info *sbi)
+{
+	if (sbi->iext_info == NULL)
+		return;
+	kvfree(sbi->iext_info);
+}
diff --git a/fs/f2fs/iextent.h b/fs/f2fs/iextent.h
new file mode 100644
index 000000000000..40b5aeaa8d52
--- /dev/null
+++ b/fs/f2fs/iextent.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * fs/f2fs/iextent.h
+ *
+ * Copyright (c) 2026 Xiaomi Technology Co., Ltd.
+ *             http://www.mi.com/
+ *
+ */
+
+/*
+ * Inline extent mapping for f2fs inodes.
+ *
+ * The inline extent area is placed immediately after i_extra_end in the
+ * on-disk inode, within the i_extra_isize region.  Its size is determined
+ * by f2fs_inode->i_inline_ext_capacity (number of extent entries).
+ *
+ * On-disk layout:
+ *   [i_extra_isize .. i_extra_end] [f2fs_iext_header | f2fs_extent[cap]]
+ *   |<------------------- i_extra_isize (in bytes) ------------------->|
+ *
+ * Old kernels treat i_extra_isize as opaque and skip the whole region,
+ * so the inline extent area is invisible to them.
+ */
+#ifndef __F2FS_INLINE_EXTENT_H_
+#define __F2FS_INLINE_EXTENT_H_
+
+#include <linux/types.h>
+
+/*
+ * f2fs_iext_header: header for inline extent area in i_extra_attr region.
+ * Placed right after i_extra_end[0], before the extent array.
+ */
+struct f2fs_iext_header {
+	__le32 cnt;		/* current # of valid extents */
+	struct f2fs_extent exts[];
+} __packed;
+
+#define EXT_FIRST_INDEX(__hdr__) ((__hdr__)->exts)
+#define EXT_ENTRY_COUNT(__hdr__) (le32_to_cpu((__hdr__)->cnt))
+#define EXT_LAST_INDEX(__hdr__) \
+			(EXT_ENTRY_COUNT(__hdr__) ? \
+			&(__hdr__)->exts[EXT_ENTRY_COUNT(__hdr__) - 1] : \
+			NULL)
+
+#define F2FS_EXT_LEN(ext) (le32_to_cpu((ext)->len))
+#define F2FS_EXT_LOGICAL_START(ext) (le32_to_cpu((ext)->fofs))
+#define F2FS_EXT_LOGICAL_END(ext) \
+			((F2FS_EXT_LOGICAL_START(ext) + F2FS_EXT_LEN(ext)) - 1)
+#define F2FS_EXT_PHYSICAL_START(ext) (le32_to_cpu((ext)->blk))
+#define F2FS_EXT_PHYSICAL_END(ext) \
+			((F2FS_EXT_PHYSICAL_START(ext) + F2FS_EXT_LEN(ext)) - 1)
+
+#define IEXT_EXT_NUM 16
+#define F2FS_IEXT_DEF_CAPACITY	8	/* default inline extent capacity */
+struct f2fs_iext_info {
+	spinlock_t iext_ext_lock;
+	unsigned char iext_ext_cnt;	/* extension count */
+	unsigned char extensions[IEXT_EXT_NUM][F2FS_EXTENSION_LEN];
+	unsigned int ext_capacity[IEXT_EXT_NUM]; /* per-extension capacity */
+	unsigned int default_capacity;	/* default capacity from mount opt */
+	bool iext_enable;
+};
+
+enum {
+	/* insert extent correctly */
+	F2FS_IEXT_INSERT_NORMAL = 0,
+	/* didn't modify inode folio, because no space and fofs is too big */
+	F2FS_IEXT_INSERT_DROP,
+	/* modify inode folio, but didn't insert due to no space */
+	F2FS_IEXT_INSERT_REMOVED,
+};
+
+/*
+ * Get the inline extent header from an inode page.
+ * The header is located at i_extra_end (after the base extra attributes).
+ */
+static inline struct f2fs_iext_header *iext_get_header(struct folio *ifolio)
+{
+	struct f2fs_inode *ri = F2FS_INODE(ifolio);
+
+	return (struct f2fs_iext_header *)ri->i_extra_end;
+}
+
+static inline int f2fs_iext_max_extents(struct inode *inode)
+{
+	return get_inline_ext_capacity(inode);
+}
+
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+static inline void f2fs_iext_init_inline_extent(struct inode *inode,
+			struct folio *ifolio)
+{
+	struct f2fs_iext_header *eh = iext_get_header(ifolio);
+
+	eh->cnt = 0;
+}
+
+static inline bool f2fs_iext_is_enable(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_iext_info *iext_info = sbi->iext_info;
+
+	return READ_ONCE(iext_info->iext_enable);
+}
+
+static inline void f2fs_iext_set_enable(struct f2fs_sb_info *sbi, bool enable)
+{
+	struct f2fs_iext_info *iext_info = sbi->iext_info;
+
+	WRITE_ONCE(iext_info->iext_enable, enable);
+}
+
+static inline unsigned int f2fs_iext_total_size(struct f2fs_inode_info *fi)
+{
+	return fi->i_inline_ext_capacity * sizeof(struct f2fs_extent) +
+			sizeof(struct f2fs_iext_header);
+}
+#else
+static inline unsigned int f2fs_iext_total_size(struct f2fs_inode_info *fi)
+{
+	return 0;
+}
+#endif
+
+int f2fs_iext_update_data_blkaddr(struct inode *inode, struct folio *ifolio,
+					block_t fofs, block_t blkaddr);
+int f2fs_iext_lookup_blkaddr(struct inode *inode, struct folio *ifolio,
+					block_t fofs, block_t *blkaddr,
+					unsigned int *len);
+void f2fs_iext_truncate_from_blkaddr(struct inode *inode,
+					struct folio *ifolio, block_t fofs);
+int f2fs_iext_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
+					bool set, unsigned int capacity);
+bool f2fs_iext_sanity_check(struct folio *ifolio);
+int f2fs_iext_info_init(struct f2fs_sb_info *sbi);
+void f2fs_iext_info_destroy(struct f2fs_sb_info *sbi);
+#endif
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index e2f7bedf1552..8d62d25c8694 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -13,6 +13,7 @@
 
 #include "f2fs.h"
 #include "node.h"
+#include "iextent.h"
 #include <trace/events/f2fs.h>
 
 static bool support_inline_data(struct inode *inode)
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index c95e0b126da4..0b1d839289fd 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -17,6 +17,7 @@
 #include "node.h"
 #include "segment.h"
 #include "xattr.h"
+#include "iextent.h"
 
 #include <trace/events/f2fs.h>
 
@@ -208,11 +209,11 @@ static bool sanity_check_compress_inode(struct inode *inode,
 			__func__, inode->i_ino, ri->i_compress_algorithm);
 		return false;
 	}
-	if (le64_to_cpu(ri->i_compr_blocks) >
+	if (le32_to_cpu(ri->i_compr_blocks) >
 			SECTOR_TO_BLOCK(inode->i_blocks)) {
 		f2fs_warn(sbi,
-			"%s: inode (ino=%llx) has inconsistent i_compr_blocks:%llu, i_blocks:%llu, run fsck to fix",
-			__func__, inode->i_ino, le64_to_cpu(ri->i_compr_blocks),
+			"%s: inode (ino=%llx) has inconsistent i_compr_blocks:%u, i_blocks:%llu, run fsck to fix",
+			__func__, inode->i_ino, le32_to_cpu(ri->i_compr_blocks),
 			SECTOR_TO_BLOCK(inode->i_blocks));
 		return false;
 	}
@@ -307,12 +308,12 @@ static bool sanity_check_inode(struct inode *inode, struct folio *node_folio)
 				  __func__, inode->i_ino);
 			return false;
 		}
-		if (fi->i_extra_isize > F2FS_TOTAL_EXTRA_ATTR_SIZE ||
+		if (fi->i_extra_isize > F2FS_TOTAL_EXTRA_ATTR_SIZE +
+			f2fs_iext_total_size(fi) ||
 			fi->i_extra_isize < F2FS_MIN_EXTRA_ATTR_SIZE ||
 			fi->i_extra_isize % sizeof(__le32)) {
-			f2fs_warn(sbi, "%s: inode (ino=%llx) has corrupted i_extra_isize: %d, max: %zu",
-				  __func__, inode->i_ino, fi->i_extra_isize,
-				  F2FS_TOTAL_EXTRA_ATTR_SIZE);
+			f2fs_warn(sbi, "%s: inode (ino=%llx) has corrupted i_extra_isize: %d",
+				  __func__, inode->i_ino, fi->i_extra_isize);
 			return false;
 		}
 		if (f2fs_sb_has_compression(sbi) &&
@@ -477,6 +478,23 @@ static int do_read_inode(struct inode *inode)
 		fi->i_inline_xattr_size = 0;
 	}
 
+	if (f2fs_has_extra_attr(inode) &&
+			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
+					i_inline_ext_capacity)) {
+		fi->i_inline_ext_capacity =
+				le32_to_cpu(ri->i_inline_ext_capacity);
+		/* Compressed files must not use inline extents. */
+		if (f2fs_compressed_file(inode) && fi->i_inline_ext_capacity) {
+			f2fs_warn(F2FS_I_SB(inode),
+				"%s: compressed inode (ino=%llx) has i_inline_ext_capacity=%u, clearing",
+				__func__, inode->i_ino,
+				fi->i_inline_ext_capacity);
+			return -EFSCORRUPTED;
+		}
+		if (fi->i_inline_ext_capacity)
+			set_inode_flag(inode, FI_INLINE_EXTENT);
+	}
+
 	if (!sanity_check_inode(inode, node_folio)) {
 		f2fs_folio_put(node_folio, true);
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
@@ -525,7 +543,7 @@ static int do_read_inode(struct inode *inode)
 			unsigned short compress_flag;
 
 			atomic_set(&fi->i_compr_blocks,
-					le64_to_cpu(ri->i_compr_blocks));
+					le32_to_cpu(ri->i_compr_blocks));
 			fi->i_compress_algorithm = ri->i_compress_algorithm;
 			fi->i_log_cluster_size = ri->i_log_cluster_size;
 			compress_flag = le16_to_cpu(ri->i_compress_flag);
@@ -753,7 +771,7 @@ void f2fs_update_inode(struct inode *inode, struct folio *node_folio)
 							i_compress_flag)) {
 			unsigned short compress_flag;
 
-			ri->i_compr_blocks = cpu_to_le64(
+			ri->i_compr_blocks = cpu_to_le32(
 					atomic_read(&fi->i_compr_blocks));
 			ri->i_compress_algorithm = fi->i_compress_algorithm;
 			compress_flag = fi->i_compress_flag |
@@ -762,6 +780,11 @@ void f2fs_update_inode(struct inode *inode, struct folio *node_folio)
 			ri->i_compress_flag = cpu_to_le16(compress_flag);
 			ri->i_log_cluster_size = fi->i_log_cluster_size;
 		}
+
+		if (F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
+						i_inline_ext_capacity))
+			ri->i_inline_ext_capacity =
+				cpu_to_le32(fi->i_inline_ext_capacity);
 	}
 
 	__set_inode_rdev(inode, node_folio);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index cac03b8e91a1..2b285afe2dbc 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -20,6 +20,7 @@
 #include "segment.h"
 #include "xattr.h"
 #include "acl.h"
+#include "iextent.h"
 #include <trace/events/f2fs.h>
 
 static inline bool is_extension_exist(const unsigned char *s, const char *sub,
@@ -70,6 +71,13 @@ static inline bool is_compress_extension(const unsigned char *s, const char *sub
 	return is_extension_exist(s, sub, true, true);
 }
 
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+static inline bool is_iext_extension(const unsigned char *s, const char *sub)
+{
+	return is_extension_exist(s, sub, true, true);
+}
+#endif
+
 int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
 							bool hot, bool set)
 {
@@ -231,6 +239,60 @@ static void set_file_temperature(struct f2fs_sb_info *sbi, struct inode *inode,
 		file_set_hot(inode);
 }
 
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+static void set_iext_new_inode(struct f2fs_sb_info *sbi, struct inode *inode,
+				const unsigned char *name)
+{
+	struct f2fs_iext_info *iext_info = sbi->iext_info;
+	unsigned char (*ext)[F2FS_EXTENSION_LEN] = iext_info->extensions;
+	unsigned long flag;
+	unsigned int capacity = 0;
+	int i;
+
+	if (f2fs_compressed_file(inode))
+		return;
+
+	if (!S_ISREG(inode->i_mode))
+		return;
+
+	if (!f2fs_iext_is_enable(sbi))
+		return;
+
+	/* This name comes only from normal files. */
+	if (!name)
+		return;
+
+	spin_lock_irqsave(&iext_info->iext_ext_lock, flag);
+	/* Check extension list for matching capacity. */
+	for (i = 0; i < iext_info->iext_ext_cnt; i++) {
+		if (is_iext_extension(name, ext[i])) {
+			unsigned int addrs_of_iext;
+
+			if (iext_info->ext_capacity[i])
+				capacity = iext_info->ext_capacity[i];
+			else
+				capacity = iext_info->default_capacity;
+			addrs_of_iext = (capacity * sizeof(struct f2fs_extent) +
+				sizeof(struct f2fs_iext_header)) /
+				sizeof(__le32);
+			if (addrs_per_page(inode, true) <= addrs_of_iext)
+				capacity = 0;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&iext_info->iext_ext_lock, flag);
+
+	if (capacity) {
+		struct f2fs_inode_info *fi = F2FS_I(inode);
+
+		fi->i_inline_ext_capacity = capacity;
+		fi->i_extra_isize += sizeof(struct f2fs_iext_header) +
+				capacity * sizeof(struct f2fs_extent);
+		set_inode_flag(inode, FI_INLINE_EXTENT);
+	}
+}
+#endif
+
 static struct inode *f2fs_new_inode(struct mnt_idmap *idmap,
 						struct inode *dir, umode_t mode,
 						const char *name)
@@ -327,6 +389,11 @@ static struct inode *f2fs_new_inode(struct mnt_idmap *idmap,
 	/* Check compression first. */
 	set_compress_new_inode(sbi, dir, inode, name);
 
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+	/* must be set after compress flag set. */
+	if (is_inode_flag_set(inode, FI_EXTRA_ATTR))
+		set_iext_new_inode(sbi, inode, name);
+#endif
 	/* Should enable inline_data after compression set */
 	if (test_opt(sbi, INLINE_DATA) && f2fs_may_inline_data(inode))
 		set_inode_flag(inode, FI_INLINE_DATA);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 38917e4a7319..c72b343e351b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -19,6 +19,7 @@
 #include "segment.h"
 #include "xattr.h"
 #include "iostat.h"
+#include "iextent.h"
 #include <trace/events/f2fs.h>
 
 #define on_f2fs_build_free_nids(nm_i) mutex_is_locked(&(nm_i)->build_lock)
@@ -819,6 +820,7 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 	nid_t nids[4];
 	int level, i = 0;
 	int err = 0;
+	bool lock_ifolio = false;
 
 	level = get_node_path(dn->inode, index, offset, noffset);
 	if (level < 0)
@@ -846,6 +848,8 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 		nids[1] = get_nid(parent, offset[0], true);
 	dn->inode_folio = nfolio[0];
 	dn->inode_folio_locked = true;
+	if (f2fs_iext_support_inline_extent(dn->inode, NULL))
+		lock_ifolio = true;
 
 	/* get indirect or direct nodes */
 	for (i = 1; i <= level; i++) {
@@ -888,8 +892,10 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 			done = true;
 		}
 		if (i == 1) {
-			dn->inode_folio_locked = false;
-			folio_unlock(parent);
+			if (!lock_ifolio) {
+				dn->inode_folio_locked = false;
+				folio_unlock(parent);
+			}
 		} else {
 			f2fs_folio_put(parent, true);
 		}
@@ -899,7 +905,8 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 						NODE_TYPE_NON_INODE);
 			if (IS_ERR(nfolio[i])) {
 				err = PTR_ERR(nfolio[i]);
-				f2fs_folio_put(nfolio[0], false);
+				f2fs_folio_put(nfolio[0],
+						dn->inode_folio_locked);
 				goto release_out;
 			}
 		}
@@ -945,7 +952,7 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 release_pages:
 	f2fs_folio_put(parent, true);
 	if (i > 1)
-		f2fs_folio_put(nfolio[0], false);
+		f2fs_folio_put(nfolio[0], dn->inode_folio_locked);
 release_out:
 	dn->inode_folio = NULL;
 	dn->node_folio = NULL;
@@ -1194,6 +1201,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 	unsigned int nofs = 0;
 	struct dnode_of_data dn;
 	struct folio *folio;
+	bool lock_ifolio = false;
 
 	trace_f2fs_truncate_inode_blocks_enter(inode, from);
 
@@ -1217,7 +1225,11 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 	}
 
 	set_new_dnode(&dn, inode, folio, NULL, 0);
-	folio_unlock(folio);
+	if (f2fs_iext_support_inline_extent(inode, NULL)) {
+		lock_ifolio = true;
+		f2fs_iext_truncate_from_blkaddr(inode, folio, from);
+	} else
+		folio_unlock(folio);
 
 	switch (level) {
 	case 0:
@@ -1282,17 +1294,19 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 		if (err < 0)
 			goto fail;
 		if (offset[1] == 0 && get_nid(folio, offset[0], true)) {
-			folio_lock(folio);
+			if (!lock_ifolio)
+				folio_lock(folio);
 			BUG_ON(!is_node_folio(folio));
 			set_nid(folio, offset[0], 0, true);
-			folio_unlock(folio);
+			if (!lock_ifolio)
+				folio_unlock(folio);
 		}
 		offset[1] = 0;
 		offset[0]++;
 		nofs += err;
 	}
 fail:
-	f2fs_folio_put(folio, false);
+	f2fs_folio_put(folio, lock_ifolio);
 	trace_f2fs_truncate_inode_blocks_exit(inode, err);
 	return err > 0 ? 0 : err;
 }
@@ -1612,6 +1626,14 @@ static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
 		err = -EFSBADCRC;
 		goto out_err;
 	}
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+	if (IS_INODE(folio) &&
+			f2fs_iext_support_inline_extent(NULL, folio) &&
+			!f2fs_iext_sanity_check(folio)) {
+		err = -EINVAL;
+		goto out_err;
+	}
+#endif
 page_hit:
 	err = f2fs_sanity_check_node_footer(sbi, folio, nid, ntype, false);
 	if (!err)
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 5e114f352099..28c10787e5bb 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -259,6 +259,10 @@ static inline unsigned int ofs_of_node(const struct folio *node_folio)
 	return flag >> OFFSET_BIT_SHIFT;
 }
 
+int f2fs_iext_data_blkaddr(struct inode *inode,
+			struct folio *node_folio, unsigned int offset,
+			block_t *blkaddr);
+
 static inline __u64 cpver_of_node(const struct folio *node_folio)
 {
 	struct f2fs_node *rn = F2FS_NODE(node_folio);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 89af8407b667..8ab5c8ea2077 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -13,6 +13,7 @@
 #include "f2fs.h"
 #include "node.h"
 #include "segment.h"
+#include "iextent.h"
 
 /*
  * Roll forward recovery scenarios.
@@ -665,6 +666,20 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		}
 		goto out;
 	}
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+	if (f2fs_iext_support_inline_extent(inode,
+			dn.inode_folio)) {
+		f2fs_bug_on(F2FS_I_SB(inode),
+				!dn.inode_folio_locked);
+		f2fs_bug_on(F2FS_I_SB(inode),
+				!folio_test_locked(dn.inode_folio));
+		f2fs_folio_wait_writeback(dn.inode_folio, NODE, true, true);
+		if (EXT_ENTRY_COUNT(iext_get_header(dn.inode_folio)) > 0) {
+			f2fs_iext_init_inline_extent(inode, dn.inode_folio);
+			folio_mark_dirty(dn.inode_folio);
+		}
+	}
+#endif
 
 	f2fs_folio_wait_writeback(dn.node_folio, NODE, true, true);
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index afca2dad4da8..3696b5d8bb80 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -37,6 +37,7 @@
 #include "xattr.h"
 #include "gc.h"
 #include "iostat.h"
+#include "iextent.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/f2fs.h>
@@ -235,6 +236,7 @@ enum {
 	Opt_jqfmt,
 	Opt_checkpoint,
 	Opt_lookup_mode,
+	Opt_inline_extent_size,
 	Opt_err,
 };
 
@@ -320,6 +322,7 @@ static const struct fs_parameter_spec f2fs_param_specs[] = {
 	fsparam_s32("inline_xattr_size", Opt_inline_xattr_size),
 	fsparam_flag_no("inline_data", Opt_inline_data),
 	fsparam_flag_no("inline_dentry", Opt_inline_dentry),
+	fsparam_u32("inline_extent_size", Opt_inline_extent_size),
 	fsparam_flag_no("flush_merge", Opt_flush_merge),
 	fsparam_flag_no("barrier", Opt_barrier),
 	fsparam_flag("fastboot", Opt_fastboot),
@@ -404,6 +407,7 @@ static match_table_t f2fs_checkpoint_tokens = {
 #define F2FS_SPEC_errors			(1 << 23)
 #define F2FS_SPEC_lookup_mode			(1 << 24)
 #define F2FS_SPEC_reserve_node			(1 << 25)
+#define F2FS_SPEC_inline_extent_size		(1 << 26)
 
 struct f2fs_fs_context {
 	struct f2fs_mount_info info;
@@ -850,6 +854,13 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		F2FS_CTX_INFO(ctx).inline_xattr_size = result.int_32;
 		ctx->spec_mask |= F2FS_SPEC_inline_xattr_size;
 		break;
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+	case Opt_inline_extent_size:
+		ctx_set_opt(ctx, F2FS_MOUNT_INLINE_EXTENT_SIZE);
+		F2FS_CTX_INFO(ctx).inline_extent_size = result.uint_32;
+		ctx->spec_mask |= F2FS_SPEC_inline_extent_size;
+		break;
+#endif
 #else
 	case Opt_user_xattr:
 	case Opt_inline_xattr:
@@ -1763,6 +1774,8 @@ static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
 		F2FS_OPTION(sbi).errors = F2FS_CTX_INFO(ctx).errors;
 	if (ctx->spec_mask & F2FS_SPEC_lookup_mode)
 		F2FS_OPTION(sbi).lookup_mode = F2FS_CTX_INFO(ctx).lookup_mode;
+	if (ctx->spec_mask & F2FS_SPEC_inline_extent_size)
+		F2FS_OPTION(sbi).inline_extent_size = F2FS_CTX_INFO(ctx).inline_extent_size;
 
 	f2fs_apply_compression(fc, sb);
 	f2fs_apply_test_dummy_encryption(fc, sb);
@@ -2432,6 +2445,11 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",inline_dentry");
 	else
 		seq_puts(seq, ",noinline_dentry");
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+	if (test_opt(sbi, INLINE_EXTENT_SIZE))
+		seq_printf(seq, ",inline_extent_size=%u",
+				F2FS_OPTION(sbi).inline_extent_size);
+#endif
 	if (test_opt(sbi, FLUSH_MERGE))
 		seq_puts(seq, ",flush_merge");
 	else
@@ -5139,6 +5157,11 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	/* disallow all the data/node/meta page writes */
 	set_sbi_flag(sbi, SBI_POR_DOING);
 
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+	err = f2fs_iext_info_init(sbi);
+	if (err)
+		goto free_bio_info;
+#endif
 	err = f2fs_init_write_merge_io(sbi);
 	if (err)
 		goto free_bio_info;
@@ -5499,6 +5522,9 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	utf8_unload(sb->s_encoding);
 	sb->s_encoding = NULL;
 #endif
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+	f2fs_iext_info_destroy(sbi);
+#endif
 free_options:
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < MAXQUOTAS; i++)
@@ -5595,6 +5621,9 @@ static void kill_f2fs_super(struct super_block *sb)
 		destroy_device_list(sbi);
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 		lockdep_unregister_key(&sbi->cp_global_sem_key);
+#endif
+#ifdef CONFIG_F2FS_INLINE_EXTENT
+		f2fs_iext_info_destroy(sbi);
 #endif
 		kfree(sbi);
 		sb->s_fs_info = NULL;
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index bb2b6cd5d507..e8d224fa926f 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -330,7 +330,8 @@ struct f2fs_inode {
 			__le32 i_inode_checksum;/* inode meta checksum */
 			__le64 i_crtime;	/* creation time */
 			__le32 i_crtime_nsec;	/* creation time in nano scale */
-			__le64 i_compr_blocks;	/* # of compressed blocks */
+			__le32 i_compr_blocks;	/* # of compressed blocks */
+			__le32 i_inline_ext_capacity;	/* # of inline extent entries */
 			__u8 i_compress_algorithm;	/* compress algorithm */
 			__u8 i_log_cluster_size;	/* log of cluster size */
 			__le16 i_compress_flag;		/* compress flag */
-- 
2.43.0



--===============1030517511430281026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1030517511430281026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

--===============1030517511430281026==--

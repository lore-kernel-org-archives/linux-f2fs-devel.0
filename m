Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C3E606A31F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 04:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=nCkJLBJE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NY0Z5Td4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=A5gUnDK6;
	dkim=neutral header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=g7LoO8CD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:
	List-Id:Subject:References:Date:Message-ID:To:From:Mime-Version:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Unsubscribe-Post:
	List-Owner; bh=jHlQWYsTjZ+EkHx1J/fjUJuuzcyY75UdAKTxd6Rklys=; b=nCkJLBJE0TuSUw
	9UaUP83+WoVvJ6McOvJfeJhHh8bd/uYn8cx1nQpb0i2yWBSSMUY/lM/pCDgTqlDyEGojuR6WN2WkI
	28gdhkBGrfCaNtm2JJWX7O7vmB+ulroKWKfe+p9luwvkN1OeGV68FCnKnDiJTJo0jbS5xp2xnIcL6
	Nqk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLCR0-000000001gu-3uag;
	Mon, 26 Oct 2026 04:35:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <keosung.park@samsung.com>) id 1xLCQz-000000001gl-0YQW
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 04:35:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 Date:Message-ID:CC:To:From:Sender:Reply-To:Subject:Mime-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wciXDY2CuZyeYwB6TARdL3Pugw7udMIoxXsDqRW7dYE=; b=NY0Z5Td4G48ESIyHTyi5s0fbi5
 6PrEPWQyLv5xnt5M0MQ8hXjpHczmqqkWaSondE1GA6kq80J59sXh1gSdR9hRpkhoq5PiEoEm6rQl0
 zaQymedPp5dRWHQpyIgqMqmOo7wK2B179ESCP50qfC4Chx/lSQSfb9egU67gmBD67uZQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:Date:Message-ID:CC:To:
 From:Sender:Reply-To:Subject:Mime-Version:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wciXDY2CuZyeYwB6TARdL3Pugw7udMIoxXsDqRW7dYE=; b=A5gUnDK6Og9mpRC/Cv41H4oyKa
 RUHUyusz0kYpo4x9gHxgD2j25GlrdDeoIgeyl9X91/OamGJzCMiyMxXiEHPPzGNjLm7WSLULAgoMm
 QcLDyEvhgGllLrxhYCckRLZk4oxQCD2B8Gew4wp0QYiG5xyAvq4ZJWwJgREDKWhVyQ60=;
Received: from mailout3.samsung.com ([203.254.224.33])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLCQx-000000001lu-254g
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 04:35:45 +0000
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20261026043536epoutp038f035d2d2a04ad85a7ff6233aa29ea92~h_k1KN1px3141631416epoutp03l
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 04:35:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20261026043536epoutp038f035d2d2a04ad85a7ff6233aa29ea92~h_k1KN1px3141631416epoutp03l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1792989336;
 bh=wciXDY2CuZyeYwB6TARdL3Pugw7udMIoxXsDqRW7dYE=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=g7LoO8CDLFTpM4nRRN+J//wrV5OLR4uuVkhqyLbF2ft5N3QyOarWsldEtG7DAHOiJ
 L1f4wpxILLOTQPG3w+XZeEccEKH+l1YxD2FyNzfNqa/jf6K1MI+QPMLJQ2J7da0lPp
 phN018xx9lwR1IuZfmwd48lhN/HK6jE0xmby4LJI=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
 20261026043536epcas2p2a6babd8b853d46104f6fa2ea18bc5b59~h_k0vSpcl0992609926epcas2p28;
 Mon, 26 Oct 2026 04:35:36 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.200]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4jCgm7675Lz2SSKb; Mon, 26 Oct
 2026 04:35:35 +0000 (GMT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: Keoseong Park <keosung.park@samsung.com>
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org"
 <chao@kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261026043535epcms2p875f882afc533a2d9a450cdd567f197c6@epcms2p8>
Date: Mon, 26 Oct 2026 13:35:35 +0900
X-CMS-MailID: 20261026043535epcms2p875f882afc533a2d9a450cdd567f197c6
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261026043535epcms2p875f882afc533a2d9a450cdd567f197c6
References: <CGME20261026043535epcms2p875f882afc533a2d9a450cdd567f197c6@epcms2p8>
X-Spam-Score: -0.5 (/)
X-Headers-End: 1xLCQx-000000001lu-254g
Subject: [f2fs-dev] [PATCH] f2fs: fix to keep m_last_pblk across direct
 write mappings
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Reply-To: keosung.park@samsung.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit f0a7adfedcc8 ("f2fs: don't break allocation when crossing
contiguous sections"), a direct write in LFS mode that allocates a
block which is not contiguous with the current mapping ends the mapping
and remembers the block in m_last_pblk, so that the next mapping starts
with it instead of allocating again.

The value is carried over in iomap->private, but iomap clears the iomap
between two mappings, so the next call never sees it. It allocates a
second block and the first one is left unwritten in the log.

Keep the value in the private data of the iterator instead, which
lives as long as the write.

alloc_mode=reuse below is only used to get a non-contiguous section
with a single writer on a fresh filesystem. Concurrent direct writers
lose blocks the same way with any alloc_mode.

Testcase:
- mkfs.f2fs -f /dev/vda
- mount -o mode=lfs,alloc_mode=reuse /dev/vda /mnt/f2fs
- for i in 0 1 2 3 4 5 6 7 8 9; do
      dd if=/dev/zero of=/mnt/f2fs/k$i bs=2M count=1 conv=fsync; done
- rm /mnt/f2fs/k1 /mnt/f2fs/k3 /mnt/f2fs/k5 /mnt/f2fs/k7; sync
- echo 1 > /sys/kernel/tracing/events/f2fs/f2fs_map_blocks/enable
- dd if=/dev/zero of=/mnt/f2fs/dio bs=8M count=1 oflag=direct; sync
- cat /sys/kernel/tracing/trace
- cat /sys/fs/f2fs/vda/dirty_segments

Before, the f2fs_map_blocks trace events of the direct write show that
the first block of each section it moves on to is lost, and
dirty_segments reads 3:
  file offset = 512,  start blkaddr = 0x1c01, len = 0x1ff
  file offset = 1023, start blkaddr = 0x2001, len = 0x1ff
  file offset = 1534, start blkaddr = 0x2401, len = 0x1ff

After, no block is lost and dirty_segments reads 0:
  file offset = 512,  start blkaddr = 0x1c00, len = 0x200
  file offset = 1024, start blkaddr = 0x2000, len = 0x200
  file offset = 1536, start blkaddr = 0x2400, len = 0x200

Fixes: f0a7adfedcc8 ("f2fs: don't break allocation when crossing contiguous sections")
Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
 fs/f2fs/data.c | 14 +++++++++-----
 fs/f2fs/f2fs.h |  5 +++++
 fs/f2fs/file.c |  6 ++++--
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6d4ba5e7790..5c32a77f2d0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4756,18 +4756,22 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_map_blocks map = { NULL, };
+	struct f2fs_dio_write *dio_write = NULL;
 	pgoff_t next_pgofs = 0;
 	int err;
 
+	if (flags & IOMAP_WRITE)
+		dio_write = container_of(iomap, struct iomap_iter, iomap)->private;
+
 	map.m_lblk = F2FS_BYTES_TO_BLK(sbi, offset);
 	map.m_len = F2FS_BYTES_TO_BLK(sbi, offset + length - 1) -
 							map.m_lblk + 1;
 	map.m_next_pgofs = &next_pgofs;
 	map.m_seg_type = f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
 						inode->i_write_hint);
-	if (flags & IOMAP_WRITE && iomap->private) {
-		map.m_last_pblk = (unsigned long)iomap->private;
-		iomap->private = NULL;
+	if (dio_write) {
+		map.m_last_pblk = dio_write->last_pblk;
+		dio_write->last_pblk = NULL_ADDR;
 	}
 
 	/*
@@ -4808,8 +4812,8 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		iomap->bdev = map.m_bdev;
 		iomap->addr = F2FS_BLK_TO_BYTES(sbi, map.m_pblk);
 
-		if (flags & IOMAP_WRITE && map.m_last_pblk)
-			iomap->private = (void *)map.m_last_pblk;
+		if (dio_write)
+			dio_write->last_pblk = map.m_last_pblk;
 	} else {
 		if (flags & IOMAP_WRITE)
 			return -ENOTBLK;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 089a62c054e..2a11b14f473 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -829,6 +829,11 @@ struct extent_tree_info {
 #define F2FS_MAP_FLAGS		(F2FS_MAP_NEW | F2FS_MAP_MAPPED |\
 				F2FS_MAP_DELALLOC)
 
+struct f2fs_dio_write {
+	struct kiocb *iocb;
+	block_t last_pblk;	/* block allocated ahead for the next mapping */
+};
+
 struct f2fs_map_blocks {
 	struct block_device *m_bdev;	/* for multi-device dio */
 	block_t m_pblk;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ef4d218e694..86bd1692011 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5488,7 +5488,8 @@ static void f2fs_dio_write_submit_io(const struct iomap_iter *iter,
 {
 	struct inode *inode = iter->inode;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct kiocb *iocb = iter->private;
+	struct f2fs_dio_write *dio_write = iter->private;
+	struct kiocb *iocb = dio_write->iocb;
 	enum log_type type = f2fs_rw_hint_to_seg_type(sbi, inode->i_write_hint);
 	enum temp_type temp = f2fs_get_segment_temp(sbi, type);
 
@@ -5526,6 +5527,7 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	const bool do_opu = f2fs_lfs_mode(sbi);
+	struct f2fs_dio_write dio_write = { .iocb = iocb };
 	const loff_t pos = iocb->ki_pos;
 	const ssize_t count = iov_iter_count(from);
 	unsigned int dio_flags;
@@ -5576,7 +5578,7 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	if (pos + count > inode->i_size)
 		dio_flags |= IOMAP_DIO_FORCE_WAIT;
 	dio = __iomap_dio_rw(iocb, from, &f2fs_iomap_ops,
-			     &f2fs_iomap_dio_write_ops, dio_flags, iocb, 0);
+			     &f2fs_iomap_dio_write_ops, dio_flags, &dio_write, 0);
 	if (IS_ERR_OR_NULL(dio)) {
 		ret = PTR_ERR_OR_ZERO(dio);
 		if (ret == -ENOTBLK)
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

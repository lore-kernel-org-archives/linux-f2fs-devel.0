Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9E9CA601E
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 16:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B0I+bom/5Rz/gFaJBjI42bxdzwIU1cksvA2XlLcbiEo=; b=cyT9vm8CAcVFveDNICbTPycaqX
	V9Fy64ht+Lu/O3/uFgj/aYMIW0H+RAkf8xJTZ5Th0zIIIfz8OqtBYbXDrs2ANosdaGAydBljWmRaM
	K83paWYg9wCM6xmVQyjhVLZyVQf3F9Vffw0TDQHcApRU8SU+kGWarE5H6cOgMBLn/V7Q=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFDTg-0004BL-Gi;
	Fri, 09 Oct 2026 16:29:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1xFDTe-0004AK-Sx
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 16:29:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DqEfDtwULeTwmEEM/18Z0zFqRPeSh+XQpu4y22xd14A=; b=EDiVMX9EER4Vrx/5Ag2sOviBJg
 XW4QzcOBJ4nfLO6JMrz0CGs8TOXF1w/CELmDnI6TCEHGe9yUnHwwGfmqx4TJD4jFFf0PwN53K01Px
 uttor69iwFZrQ1qr4pgj2WQX5BLJGhNRu4HEq2H9ui5Zzw+JjgwvnQNwag5+tnPY+T74=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DqEfDtwULeTwmEEM/18Z0zFqRPeSh+XQpu4y22xd14A=; b=EMV/U9q4jno7aN1IPDwn82XumT
 hiFMFDq98FA/xETUrC9bsXNG6imdVaJw24YiSWnIlzRvX6U0h904II71BTSCspiodlP6phJrow2mw
 M7AlgWKoVgdI+kt2nmCv6mYe520F4ngkur7CVUHPypPvpyLuDOdTlrkVY/C6dV/KTkRc=;
Received: from m16.mail.126.com ([220.197.31.6])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFDTG-0005SK-8X for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 16:29:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Dq
 EfDtwULeTwmEEM/18Z0zFqRPeSh+XQpu4y22xd14A=; b=eNScyOfnnuhHO1bFMJ
 mUS5YPjvlDuUpL3rEHOGO2Bj0I/9VxpDglTziwapHMjLnx462ac1AlmKgoStZiIv
 JjGuSX+Z3gHvgcmEGaltG5FdvG8v6KnP8Fr69vOsN3Fzs3s9jmIYYEahRB6aihLP
 LIvcJngVdVbbhvnV94vxrw5I0=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PikvCgDH3_w0FslqWTz5BA--.13078S8;
 Sat, 10 Oct 2026 00:28:48 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Sat, 10 Oct 2026 00:28:28 +0800
Message-ID: <20261009162828.4188050-7-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
References: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: PikvCgDH3_w0FslqWTz5BA--.13078S8
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw45XFWUJFyrJw1fGr48Zwb_yoWrJr4fpr
 W5GryrKrWvqryUuwn7Aa1Ygr1ftry8GayUAFWxGw18A3W5XrnY9FWxt3Z8WFWUJry5Za1v
 va1jkryUX3W5taUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jj0PhUUUUU=
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBowCicmrJFkAIIgAA3s
X-Headers-End: 1xFDTG-0005SK-8X
Subject: [f2fs-dev] [PATCH v3 17/17] f2fs: make compressed files compatible
 with large folio
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: Barry Song <baohua@kernel.org>, Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 Juan Yescas <jyescas@google.com>, Daeho Jeong <daehojeong@google.com>,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-kernel@vger.kernel.org, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The compression flag is the hint indicates that the inode can be
compressed, when the inode is using large folio, we expected it keeps
using the large folio read/write paths and its data stays uncompressed
on disk until the inode is evicted and re-read

Let f2fs_write_begin() skip the compression overwrite preparation for
such inodes and remove the compressed-file gate in
f2fs_read_data_large_folio() so the data is simply read/written as
regular blocks.

For the same reason, reject F2FS_IOC_COMPRESS_FILE with -EOPNOTSUPP
once the inode mapping is switched to large folios.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 Documentation/filesystems/f2fs.rst | 10 ++++++++++
 fs/f2fs/compress.c                 |  2 ++
 fs/f2fs/data.c                     |  9 ++-------
 fs/f2fs/file.c                     |  7 +++++++
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 771216f45207..b4f436ffd9ac 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -941,6 +941,16 @@ Compression implementation
   reserved via ioctl(F2FS_IOC_RESERVE_COMPRESS_BLOCKS) or the file size is
   truncated to zero.
 
+- Compression and large folios are not effective at the same time on a file:
+  a compressed inode does not use large folios, while an inode which is
+  using large folios keeps its data uncompressed on disk.  If the compression
+  flag is set on an inode that is already using large folios, the flag works
+  as a hint until the inode is evicted: the inode keeps using the large folio
+  read/write paths, f2fs_write_begin() skips the compression overwrite
+  preparation, and ioctl(F2FS_IOC_COMPRESS_FILE) fails with -EOPNOTSUPP.
+  Once the inode is evicted and read back, it uses order-0 folios again and
+  compression is applied as usual.
+
 Compress metadata layout::
 
 				[Dnode Structure]
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index c0e39f580993..4f006a32a1b2 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -78,6 +78,8 @@ bool f2fs_is_compressed_page(struct folio *folio)
 		return false;
 	if (folio_test_f2fs_nonpointer(folio))
 		return false;
+	if (f2fs_folio_has_ffs(folio))
+		return false;
 
 	f2fs_bug_on(F2FS_F_SB(folio),
 		*((u32 *)folio->private) != F2FS_COMPRESSED_PAGE_MAGIC);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 18f568f55b4c..680659f60509 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3194,12 +3194,6 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	int ret = 0;
 	bool folio_in_bio = false;
 
-	if (f2fs_compressed_file(inode)) {
-		if (folio)
-			folio_unlock(folio);
-		return -EOPNOTSUPP;
-	}
-
 	map.m_seg_type = NO_CHECK_TYPE;
 
 	if (rac)
@@ -5124,7 +5118,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-	if (f2fs_compressed_file(inode)) {
+	if (f2fs_compressed_file(inode) &&
+	    !mapping_large_folio_support(inode->i_mapping)) {
 		int ret;
 		struct page *page;
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6160734f6700..56450d154e05 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4999,6 +4999,13 @@ static int f2fs_ioc_compress_file(struct file *filp)
 	if (!(filp->f_mode & FMODE_WRITE))
 		return -EBADF;
 
+	/*
+	 * The mapping is already using large folios, where the data is kept
+	 * uncompressed, so refuse to start compressing the file.
+	 */
+	if (mapping_large_folio_support(inode->i_mapping))
+		return -EOPNOTSUPP;
+
 	f2fs_balance_fs(sbi, true);
 
 	ret = mnt_want_write_file(filp);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

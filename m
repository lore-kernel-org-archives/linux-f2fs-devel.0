Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A7F606A32A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FB2wc2dX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=d/CmEYIT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cxJFZRbJ;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KzZXIZje
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=svHE4eCtDabhEUehxVhJDqtpkiNHMi/bKtintvrnH1E=; b=FB2wc2dXHk7XJu9+upDayXctmY
	nE6xU+vPOJYPLgcwabfT6dRwplFO8R5glj+adL9wGX2DFQRiGXPoOYeHZgTgNWtNtJ8jRaCa+ZjJ0
	JMiPqajBmTj21dIvXuOx5nBZt4+uwQXa5QBYfQm7g3GcuhtQWpr2k69JQsxGcwRQxaIQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xM5qY-0000000021H-0Ewj;
	Wed, 28 Oct 2026 15:45:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xM5qW-00000000215-3p1c
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:45:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ng3YrPEQ5YUZCvhHT4uyTZrIVJh9v7VyK/y80on7mmI=; b=d/CmEYITC+paG1wGfmSs31nDai
 vsqLjPijozbDTdIlxavW7mVdhXYTRYJv+z67mbTbDHfgh+E4P/OWA2nlZV3SvENMrz1GAqkVS0BFs
 trn/fqE1m7OO7Q7DkDXjZ855wXC9yZRvyLjiecTdAeW0FIcGghAS6l6ryh8nfH0wX7tg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ng3YrPEQ5YUZCvhHT4uyTZrIVJh9v7VyK/y80on7mmI=; b=cxJFZRbJa/8xaRhV6hYs6Zfzd2
 Jc+PbRPeRLyrQYMbRpPBs4LiVpR5sYvI29hCrFYRiu8usOfcfZPevPq5Vb+nCxJLAW7sRFrS0i7uZ
 UApGNzFEXDRTxtTILqOOPrznPBOXPvE7qzw4uij7wmHQjqGwidai8FqreZxOHVvgxhxo=;
Received: from mail-pj2-f4.google.com ([74.125.227.132])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM5qN-000000002PI-0A7x
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:45:48 +0000
Received: by mail-pj2-f4.google.com with SMTP id
 d9443c01a7336-2e96b8bfb43so3797025ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 08:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793202333; x=1793807133; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ng3YrPEQ5YUZCvhHT4uyTZrIVJh9v7VyK/y80on7mmI=;
 b=KzZXIZjesp8+Lx3KiB3rWS18aDY8d9gevXveaaaVoWq0TZqnwf0QMTur9JPYq+puyP
 dW+2piWmLF4exz2xVC2uD7nnuXwpbHEjRcBL5uXk1hqajaD95tSN+HIDzdrWdIvSi+aj
 73duedKmkhKKeZpdSuMWzh7P1wu2OINa6tn+Dl1YRhBXCrp0o69VWgIVy5FhjD9WIN8o
 cUXOHJSFse7lDpMF1z3r1q4bYk1GKCm6xDY58dkWrShOVCcMBao7hP/MWMUBOopAXj4G
 1sBb3kMm4yf4g3dNiqCalkqTjYAa1Uj3dQA39byQ5/uc51OIQ7aShzFgG1kUktjRoPQ2
 iIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793202333; x=1793807133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ng3YrPEQ5YUZCvhHT4uyTZrIVJh9v7VyK/y80on7mmI=;
 b=eZ0k1H3Bcg3SLhoxrXa5dxXBnta9mtvo3v9RkH2TUzJrLlHy07qZh1S7WyTAgfbf10
 RScnXiv9+782PLcn5caVaFTN5M4h++KKfFpDi2eLbOzXR7phC2AG+hWzi+qgOUSrLK9g
 5IPa60zS9x+CKAORCnM0wnjoX/1VdN9WZ0zi3r4YT6q+/p+t/4yr1Lv6kcFTxz2l6bcp
 5Ef/easQzeyj8wPKpA4cRxD2jvWEhQQyb3reubGpgvv75KoUxJ0xqFMVbuMmO59q1iV5
 lVveBGfcXjS/BcC6l1gzlTjfEGwF+cfie8lykU2FlwRBWloINNjV7+9na2HokJQ/kZiI
 YuaA==
X-Gm-Message-State: AFq9FYIP8Xs7q0NIZiCereDJKEPEzsh/UNPj1cQuDBQ7XDlej6xIo9i+
 P/gyJLtRT5a0ckxp9ZVhAB6rEvQpoZ3Zis4CS+yPA2J2RdDBf+BEMmgfDXE0pb9fYT4=
X-Gm-Gg: AYBFou2NVV9ruijoXG+RWW8fke66p3F7/fB/BDd4wTjfI7Sdmg7x/XcrvY0Y7f8b2SZ
 Fy/pb8u7qB5C1Ja8vdtzibE/l44Brg0nm+yxiNh4WSJijtOXqYVWT+fo9j1oofZr4LhnqIeerpo
 /VqZIZQ08Ag8JaepOS3lZiHmYP++R2THuTOicGs2cc9hTNiC5f2KioHL9DVUQgsbnZq6CDpn8BD
 v78M8PuRVt+HV/MbgoBbsw+H0hRiseOXDvOHyT5z8WyORyodUSAVB+n/ir6dphDdskmo0G3WQgL
 WBSu/u/KGkPeyojcWUC/u+RI/dAbA5wGYAX8NzfKsq113s86QFuoMPsZcS9cduqByOYOB6nvA8t
 78u+qOmHaYUUKkMRRwMlgqLTT7K0F29QPJZ+H3xX6tQxjtRjkPEqQ1GtEdi2Ej4+fsNzGM075Tx
 miqogA6ljlANSVW7a1qApsWJxAcPdY/SXeOn/iIOdJtcZJPVQY7Iik6kJRZ+nJNlkEoeTeV+U24
 r0BgDWa4TruJufbUGoiStp2l+Ni5ExdNjCLDr/5/6aC0468mymxaTVL+C9M8yzWdNrcKKX0YcUY
 SjuKTL/54GaYp0Rd0fWMPUiDRFLCqgXswnS6hkCbYYNaaYj6Wha2QfnF2qycZzxN9g0=
X-Received: by 2002:a17:903:41d1:b0:2e9:3dd2:a8fe with SMTP id
 d9443c01a7336-2eb00338c6cmr25488805ad.21.1793202333166; 
 Wed, 28 Oct 2026 08:45:33 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6be5105sm24111655ad.37.2026.10.28.08.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 08:45:32 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 28 Oct 2026 23:44:06 +0800
Message-ID: <20261028154407.1601430-16-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM5qN-000000002PI-0A7x
Subject: [f2fs-dev] [PATCH v8 15/15] f2fs: make compressed files compatible
 with large folio
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

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
 Documentation/filesystems/f2fs.rst | 10 ++++++++
 fs/f2fs/compress.c                 |  2 ++
 fs/f2fs/data.c                     |  9 ++-----
 fs/f2fs/file.c                     | 38 ++++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 55798421f2c4..b79bb67ee78e 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -942,6 +942,16 @@ Compression implementation
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
index 162bd8ef822a..721b01dd0d24 100644
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
index cc3c9e51db9c..ab8f5b44d63a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3288,12 +3288,6 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
@@ -5331,7 +5325,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-	if (f2fs_compressed_file(inode)) {
+	if (f2fs_compressed_file(inode) &&
+	    !mapping_large_folio_support(inode->i_mapping)) {
 		int ret;
 		struct page *page;
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 15bea642e986..cb7a9d4227f4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4907,6 +4907,7 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 	struct address_space *mapping = inode->i_mapping;
 	struct folio *folio;
 	pgoff_t redirty_idx = page_idx;
+	pgoff_t end_idx = page_idx + len;
 	int page_len = 0, ret = 0;
 
 	filemap_invalidate_lock_shared(mapping);
@@ -4924,6 +4925,9 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 	} while (page_len < len);
 
 	while (redirty_idx < page_idx) {
+		pgoff_t next_idx;
+		size_t off, dlen;
+
 		folio = filemap_lock_folio(mapping, redirty_idx);
 
 		/* It will never fail, when folio has pinned above */
@@ -4931,6 +4935,33 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 
 		f2fs_folio_wait_writeback(folio, true, true);
 
+		/*
+		 * Only this cluster is rewritten, while a large folio can
+		 * cover more than one cluster, so mark the intersection of
+		 * the folio and [redirty_idx, end_idx).
+		 */
+		next_idx = min_t(pgoff_t, folio_next_index(folio), end_idx);
+		off = offset_in_folio(folio, (loff_t)redirty_idx << PAGE_SHIFT);
+		dlen = (size_t)(next_idx - redirty_idx) << PAGE_SHIFT;
+
+		if (folio_test_large(folio)) {
+			/*
+			 * A compressed inode can keep using large folios, in
+			 * which case the compression flag only works as a hint
+			 * until the inode is evicted.  Update the subpage dirty
+			 * bitmap as well, otherwise f2fs_write_cache_folios()
+			 * finds no dirty range and skips the whole folio.
+			 */
+			if (!f2fs_ffs_find_or_alloc(folio)) {
+				ret = -ENOMEM;
+				folio_unlock(folio);
+				folio_put_refs(folio, 2);
+				redirty_idx = folio_next_index(folio);
+				continue;
+			}
+			f2fs_ffs_mark_subrange_dirty(folio, off, dlen);
+		}
+
 		folio_mark_dirty(folio);
 		folio_set_f2fs_gcing(folio);
 		redirty_idx = folio_next_index(folio);
@@ -5037,6 +5068,13 @@ static int f2fs_ioc_compress_file(struct file *filp)
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

Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B24A606A339
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 03:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=f5xdhhwH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=daxJEiLm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=T9C8Yz6g;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fAc5nouv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=+ISS+dDvfqvCWDpjB9wlmwv7fCg+Y18f6WsDsSd31LY=; b=f5xdhhwHi53urbPOW3j8CRuTkI
	e12YH+7aAHSWK0oBoWSC9Fv9SSt/YZy6na3SNuxnwIiA0j8tQWdn8YtgyBB3/giAsSw/quuMUSWCt
	kGITBADVlrG0xr0LHhcftdICxKc6wjVp1lVZmpvL+DnFK9PoBWQwbVyypp96XAGu50wg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLBXP-000000004ks-3oG7;
	Mon, 26 Oct 2026 03:38:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xLBXN-000000004kP-1EMP
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:38:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jgsLRy03IEgL4aMJC+EcAk/qE7gSd5NIpNv79raGAYk=; b=daxJEiLmVZg680peJPrTmpSTX+
 RkNPQcgoDvagWIV/NQpar9QgIF309m1T99jLXNI+iHMT9MxQkIrm7fqvMTvE4nRJcvkdfCEB95Jh1
 nxE6zd5suGuiL01UBpdxA8iRq8BmsjC8yGni+J10OS8v3MJEobhvoLOsvf/f15vJJ3X0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jgsLRy03IEgL4aMJC+EcAk/qE7gSd5NIpNv79raGAYk=; b=T9C8Yz6gP8X05pu48o749I+F71
 +oiQmOd+pg7RzOXepLxbPULG5rFudb2+/kH0gM1h91GPwSu6m0qYKKemDluvQL0uAY0FIFLr989rn
 W2WUI8+egV3QL4yq2aWeo6bxaIyJWtavKkgOnR/GPKwnv0Nc20qTuM7BgT79jR1PT44w=;
Received: from mail-pj2-f7.google.com ([74.125.227.135])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLBXM-000000000eq-35Wk
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:38:17 +0000
Received: by mail-pj2-f7.google.com with SMTP id
 98e67ed59e1d1-3ac63aee1ecso424859a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 20:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792985891; x=1793590691; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jgsLRy03IEgL4aMJC+EcAk/qE7gSd5NIpNv79raGAYk=;
 b=fAc5nouvIVqzoKsIf6uvdLiADOz2ZvXofDCF8HDcTbtjDJ14qTrMOsL/KABDUBTCBe
 i7cezFva14ZYjsu7lTY5tz16sYCksWuQ+hwoUSB4jPjfImq27qWqiqijGsih3qFFHCxf
 GlRd/WczlQHe74rjrb3mrxUGao4zBn6VYHtTDPpYyTy1l1SqsdsIPljMXJ3ZZfeEtpjF
 ZyjUuqOT/2JxRMDWNPtHnlCw0CfnpKjNjqk8e77oeOM96+oC0Z+nDXdSzMDW3GCjf+JS
 flbV/XF4RUvxWu0hgIeBSFt6Rdo077saTA8NY4ua4NhIDu4pXEIjk/Rigrh1m3AUS7pq
 npXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792985891; x=1793590691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jgsLRy03IEgL4aMJC+EcAk/qE7gSd5NIpNv79raGAYk=;
 b=r5bKT1VJJ34z+gHUAZDG3ks364mzVrmoDZE6rEO0kwxbyesG4+HOhJTsCnLizMPtYX
 E6ZalSQjiF+gSqUeHr5FIBfh8RdR2GIvXmmcEaDpLiFRPqutJ594RtPebv29NCJQxrgS
 Wtz+Yg9T/rVwgK298Xq3cl6sDocxqYPaCUBwE6E++bznQqo9niwXIkK06GsGgvrcSvB0
 ikZs+0X2VGqQ2cFni9M6v0zkkGCBwnb2Dde+4yQEe2dLSFleO7BY/7T3OplQY8Xn4jAV
 d9XWIMVlU4Wh5LvDQnagysFhZUez55c+4qppa8RDxHHbHmlXBEelWwgB8yp6+phnKZFn
 JuJA==
X-Gm-Message-State: AFq9FYLr01l440XReF6vzApWYwmFHBHbSd8xM9nAg0Yk2oupgWGN/+eL
 3JaEPZwEpmWIccnGSSzyNjxa3SBtiB+21fm83jGFlXOXGfoAOVkWhpE15/UDr6hu87opLw==
X-Gm-Gg: AYBFou1qX2sU32nTvMotxzPxOSU7S9TXl6JoA2M2//v8Hm9A1xEeVnYJf9MBjKG50KX
 YUvWhbl4fjVS6LMICXenGYpovfmRdnTlOD0jbMrYM8MY5kGv3aBrqwsDigBiUlYBZSD8x015Kgg
 7cpEOem3DVfBqO8qOlz0E3kTl0mpmVIGHlx20IfHDJGfj/UFnrvaIdDkuF0uzAr1QYthVh14uLY
 rTGTmC3a6Rq5oVHL+Bzch8Sc3qfT1BjlxWBV2HwBxAA3+nE4jRUqoR1nr8y91F3nCAackuuThti
 5GZfs+QzmuLqf5iwqWopB+KtyiOvhtoZN4JsEQm+vYN6QOO9CbFiAD4bD3+C7IBl5mhEqx8zfuk
 ywcYgAzKgheDShTqAgAWJ9jTOJWODUq+zZq7haUzRolxC+0C+4BLGBrO9Hi+k3Ioxk4E3jF+v2v
 pqO+ceBmJlSPFdxzgzGgGu7TmM+WdUXG0NYXFD7DARkXNVo0ubOqa82t4VAXr4jnXjkPqdEfAhS
 bomd1YAESi7j8eCXwH+7RHShUXB4m6/dirXLWP4OP6VdmAJu0X9LTfzwVuxZvGYbw+u8PKWDLOJ
 eIcJVgY7zR9j7B6QyA==
X-Received: by 2002:a17:90b:1b0e:b0:3ab:9c73:12f with SMTP id
 98e67ed59e1d1-3adeaae626amr4994238a91.24.1792985890961; 
 Sun, 25 Oct 2026 20:38:10 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebe8f0b2sm6409823a91.8.2026.10.25.20.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 20:38:10 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Mon, 26 Oct 2026 11:37:34 +0800
Message-ID: <20261026033745.784107-5-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026033745.784107-1-nzzhao.sigma@gmail.com>
References: <20261026033745.784107-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLBXM-000000000eq-35Wk
Subject: [f2fs-dev] [PATCH v7 04/15] f2fs: support atomic file large folios
 buffered write
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

ioctl can convert an inode with large folio support into an atomic
file. Support large folio buffered writes for atomic files as well.

Add a large folio atomic write_begin helper that reserves COW mappings
for the write range. For partial head and tail subpages, read the
existing data from either the COW inode or the original inode before
marking the subpage uptodate.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 86 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 76 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f01bf06a77b0..126cad81227f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4305,18 +4305,22 @@ static int __reserve_data_block(struct inode *inode, pgoff_t index,
 }
 
 static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
-			struct folio *folio, loff_t pos, unsigned int len,
-			block_t *blk_addr, bool *node_changed)
+			struct inode *inode, pgoff_t index,
+			block_t *blk_addr, bool *node_changed,
+			bool check_reserved)
 {
-	struct inode *inode = folio->mapping->host;
 	struct inode *cow_inode = F2FS_I(inode)->cow_inode;
-	pgoff_t index = folio->index;
 	int err = 0;
 	block_t ori_blk_addr = NULL_ADDR;
 	bool cow_has_reserved_block = false;
+	bool append = ((loff_t)index << PAGE_SHIFT) >= i_size_read(inode);
 
-	/* If pos is beyond the end of file, reserve a new block in COW inode */
-	if ((pos & PAGE_MASK) >= i_size_read(inode))
+	/*
+	 * On the first attempt, an append write can skip the COW lookup and
+	 * reserve directly.  On retry, check the COW block first so the same
+	 * block is not reserved and accounted twice.
+	 */
+	if (append && !check_reserved)
 		goto reserve_block;
 
 	/* Look for the block in COW inode first */
@@ -4330,7 +4334,7 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 	if (*blk_addr == NEW_ADDR)
 		cow_has_reserved_block = true;
 
-	if (is_inode_flag_set(inode, FI_ATOMIC_REPLACE))
+	if (append || is_inode_flag_set(inode, FI_ATOMIC_REPLACE))
 		goto reserve_block;
 
 	/* Look for the block in the original inode */
@@ -4498,6 +4502,62 @@ static int prepare_large_folio_write_begin(struct inode *inode,
 	return 0;
 }
 
+static int prepare_large_folio_atomic_write_begin(struct inode *inode,
+		struct address_space *mapping, struct folio *folio, loff_t pos,
+		unsigned int len, bool retried)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	size_t ori_off = offset_in_folio(folio, pos);
+	pgoff_t start, end, index;
+	int err = 0;
+
+	len = min_t(unsigned int, len, folio_size(folio) - ori_off);
+
+	if (!f2fs_ffs_find_or_alloc(folio))
+		return -ENOMEM;
+
+	/* Inline data must have been converted before reaching here. */
+	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
+
+	start = folio->index + (ori_off >> PAGE_SHIFT);
+	end = folio->index + ((ori_off + len - 1) >> PAGE_SHIFT);
+
+	for (index = start; index <= end; index++) {
+		block_t blkaddr = NULL_ADDR;
+		bool node_changed = false;
+		size_t off = (index - folio->index) << PAGE_SHIFT;
+
+		err = prepare_atomic_write_begin(sbi, inode, index,
+						&blkaddr, &node_changed,
+						retried);
+		if (err)
+			return err;
+
+		if (f2fs_ffs_test_blk_uptodate(folio, index))
+			goto balance;
+
+		if (blkaddr == NEW_ADDR) {
+			folio_zero_segment(folio, off, off + PAGE_SIZE);
+			f2fs_ffs_mark_subrange_uptodate(folio, off, PAGE_SIZE);
+			goto balance;
+		}
+
+		if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
+					   DATA_GENERIC_ENHANCE_READ))
+			return -EFSCORRUPTED;
+
+		err = f2fs_submit_page_read_sync(inode, folio, index,
+						blkaddr);
+		if (err)
+			return err;
+balance:
+		if (f2fs_balance_fs_folio_locked(folio, mapping, node_changed))
+			return -EAGAIN;
+	}
+
+	return 0;
+}
+
 static int f2fs_write_begin(const struct kiocb *iocb,
 			    struct address_space *mapping,
 			    loff_t pos, unsigned len, struct folio **foliop,
@@ -4508,6 +4568,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	struct folio *folio;
 	pgoff_t index = pos >> PAGE_SHIFT;
 	bool need_balance = false;
+	bool retried = false;
 	block_t blkaddr = NULL_ADDR;
 	fgf_t fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT;
 	unsigned int blen;
@@ -4587,16 +4648,20 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	 */
 	f2fs_folio_wait_writeback(folio, false, true);
 
-	if (f2fs_is_atomic_file(inode))
-		err = prepare_atomic_write_begin(sbi, folio, pos, len,
-					&blkaddr, &need_balance);
+	if (f2fs_is_atomic_file(inode) && !folio_test_large(folio))
+		err = prepare_atomic_write_begin(sbi, inode, folio->index,
+					&blkaddr, &need_balance, retried);
 	else if (!folio_test_large(folio))
 		err = prepare_write_begin(sbi, folio, pos, blen,
 					&blkaddr, &need_balance);
+	else if (f2fs_is_atomic_file(inode))
+		err = prepare_large_folio_atomic_write_begin(inode,
+					mapping, folio, pos, len, retried);
 	else
 		err = prepare_large_folio_write_begin(inode, folio, pos, blen);
 	if (err) {
 		if (err == -EAGAIN) {
+			retried = true;
 			f2fs_folio_put(folio, true);
 			goto repeat;
 		}
@@ -4604,6 +4669,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	}
 
 	if (f2fs_balance_fs_folio_locked(folio, mapping, need_balance)) {
+		retried = true;
 		f2fs_folio_put(folio, true);
 		goto repeat;
 	}
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DF1606C045
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YjK1emzA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jjlzzmPn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KEDZS8C8;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e0Q3kwiw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=OZR1JoVRe/kf6RTMVugjcVuFZWx2LSSGNw2x7NUO93s=; b=YjK1emzA0keugL4dDZt/JyTKp8
	TTuGL/HaBfcaLO1CQNGpbfdXvyC+lW8t5oPYcuhO1l47IkCoMHpGU3CKUwIsYgUCGfT4YnJWc2IPV
	wlKCwTuymijRoLcR+eqiNAzbf3gEIOyq99FdA8aGSgWaUf55FDADFwZBJ1HUL5sklDDs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xM5pV-000000001ou-1tyy;
	Wed, 28 Oct 2026 15:44:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xM5pU-000000001oj-2kxB
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:44:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OYuHZZGI+jjpXj2nBM4OnsPACZYpWz4vAyql0O4VDks=; b=jjlzzmPnO9nn68nb3rRsgx1Ux/
 O1i/Z9Rmu7sUWrk8js5kwgHrV+MNnCrHtl2KPcLet5+D6stWopLtDWyg4B+pD5hTGbOdCyNPcp38i
 5wM8jKU5kFLTZUOAIXe18y7PJncBNtGFcD0fpdEtgDeBphid36sq+jsdfRONQQii9HcY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OYuHZZGI+jjpXj2nBM4OnsPACZYpWz4vAyql0O4VDks=; b=KEDZS8C8NmVkUbMwVJ4rCjC++y
 d+a/seKhSNnyuSpCJ4JeCwLpdKy/b4lrFCHOKPQYY1J/piruDMVbGoggg6GYUM2ZI+eaRNPc/5lDE
 GErRIIuwR444EHnrAUvkHC3RkCY7ce2Sf3E/gIj4quqYZ5rGOnSlMOiWb26wGvcsCpEM=;
Received: from mail-pj2-f3.google.com ([74.125.227.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM5pT-000000003ZE-188h
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:44:44 +0000
Received: by mail-pj2-f3.google.com with SMTP id
 d9443c01a7336-2e831901331so8735615ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 08:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793202277; x=1793807077; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OYuHZZGI+jjpXj2nBM4OnsPACZYpWz4vAyql0O4VDks=;
 b=e0Q3kwiwuoR2XYzAFZnp7oXGxZpXWopLUETRobwJZsvv7lTcNuBcY18xk4lRN5GtHd
 5Kh+Arh/8o+rcxA+rcBwxvL8onPEu693XszlR55gyKhm8rCZOasdREpx82MFuwGNIS3Y
 w0zIU0iMuhXRFTphu7W2hCNNGeK+7Er/mWp5N29JPgcOxjQBMT4rGbkxYUpC9k1qd22A
 tZVXh9NFqIdCpSWXz7AFzhA261eXMFCFf97WHVi9ElcSxS5gGC0ZrUCp6Y+O5Do3TGPk
 GbGhEx2P1Pc6NKebyhyhRyFNzBiYIUYZCl28rH3p01JVu9JL9CJtgYSmc0tt6EfQlujr
 MypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793202277; x=1793807077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OYuHZZGI+jjpXj2nBM4OnsPACZYpWz4vAyql0O4VDks=;
 b=dBTKmqMCKT5HUrkZUrj98x6C3r7VLS3RczMB7fhAm9MYv9kvA8nKN8iKPajwUt/rOa
 sRgkicLQD/JrRkyFWPcdvXIfbcZo1bNEelGdIqLkMANiFJcjAHeijh3rzzbEJJYxIG5R
 gKc03KRUw3AP40uC1sNNQ47GBqa/ufKXgCIfxnYnAipgQivQ0bk36EBj1V9Eq7eiD038
 yJOwt6AoiMYlO/nPVIvrZxTG3UXhDZfWVQU+jLLlGlvm99kqJ2Xsvs6arauucmBH9HQU
 Ljw5dNlhOzYrneuDnOeLYtx/LYG0PWVx94cMD9EBDvqCdKvzZ19mx6XyxgBq49L4otfJ
 vqOw==
X-Gm-Message-State: AFq9FYI//67BUfA2zk+A58hDSlmr735Qfv06FwxQt6VRs/jP/ELTW0OD
 pnoWQElAiYL+bjLRmITDtNZ1OlK4sLvFQ8lKTKF8KQUU9ng+qfSLbOwrCdOs6+dk+fs=
X-Gm-Gg: AYBFou1zrTVo/bbWcOuRzB5XGPo4KM76onKJTjq2pQAIwFCi6rpAY7zmc5nmzdpzTl1
 BFHUlO3orOWbIknMAadSBIKZEG6a+2DB9AJtees/KsTzEGDBfCpp7jlEBrTaXg6dBoz4S1xL77N
 TXcI2qU95Y2Q37qM1MBuQS5/Wb2+7kOiSLz3+8aAN1AtCM4luivVcoTr3Ui6zKKNkm0GHbYxKma
 ImtHuKNBkK+l2KIA45xojMdQtP5vjh1cIp/yARERW7KtUJ3mv8oiNl5OVjiDJtqBlf06oTu9fHJ
 B/xFbhuxk88Fu2wffNsdW27nYLM9QxjFLsv7jzJfvqMf3jiTs5l8+1OXkwbp7PtciJrdPGG9H2r
 kmsbh009pHI1QNruBUxTTarVmCFqyDm0M6vBSjvrdmRkbnX1v6hTdhZmzDGD0U/3zXmJyTHE5y2
 KqcohHVoO0OxQ1mDQ1oK7ACA6rCbPUV8R6ntgBtJCkS9QYQK1xUJYDG8LmAAfmIp5mDtkX/YpK5
 U2ChfEdcmxPBZeI5zGu+xTfmJE5VlfRTrMoWhIGhz9rk6lfYRFnyr2SydNwX6LpCDG76q/dPIJE
 951qiXf8aPnLAEBF8Rdn1Py9ugF8rDWcDt+4vNUnqqHmCsnm7W+BOABpFRWXCYqq2pY=
X-Received: by 2002:a17:903:120f:b0:2ea:1b9b:b946 with SMTP id
 d9443c01a7336-2eb004888b6mr26028085ad.14.1793202277470; 
 Wed, 28 Oct 2026 08:44:37 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6be5105sm24111655ad.37.2026.10.28.08.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 08:44:36 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 28 Oct 2026 23:43:55 +0800
Message-ID: <20261028154407.1601430-5-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM5pT-000000003ZE-188h
Subject: [f2fs-dev] [PATCH v8 04/15] f2fs: support atomic file large folios
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
index e991adcff6be..fbffe4c56090 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4311,18 +4311,22 @@ static int __reserve_data_block(struct inode *inode, pgoff_t index,
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
@@ -4336,7 +4340,7 @@ static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 	if (*blk_addr == NEW_ADDR)
 		cow_has_reserved_block = true;
 
-	if (is_inode_flag_set(inode, FI_ATOMIC_REPLACE))
+	if (append || is_inode_flag_set(inode, FI_ATOMIC_REPLACE))
 		goto reserve_block;
 
 	/* Look for the block in the original inode */
@@ -4504,6 +4508,62 @@ static int prepare_large_folio_write_begin(struct inode *inode,
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
@@ -4514,6 +4574,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	struct folio *folio;
 	pgoff_t index = pos >> PAGE_SHIFT;
 	bool need_balance = false;
+	bool retried = false;
 	block_t blkaddr = NULL_ADDR;
 	fgf_t fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT;
 	unsigned int blen;
@@ -4593,16 +4654,20 @@ static int f2fs_write_begin(const struct kiocb *iocb,
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
@@ -4610,6 +4675,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
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

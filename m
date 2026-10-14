Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA8ACC6B24
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I6lZ5p1XC/brsxODlpehKJJuRjFYmyANvfxn5AUuTW0=; b=ZhVeoXJRmrMN1SRT3k3eU8+P9G
	7M8Xg2p5J/QR1V0OVqU5EHN4BmnWC7rMoFrgurlqUYMQ/iDcekRPdSS+WrNK2puM7ejmA1fU2Ss57
	6QRMQLoQaAtySeLfWxuVGx3tc88hTPa/bKn/hFSDHLoi8TVXd9+Ouay4Ytlowkcly/N0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGskL-00028w-De;
	Wed, 14 Oct 2026 06:45:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGsk8-00028B-V5
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:45:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+1JKUVEv+OR98/CM1h1gzna07C5BqVxZPLGeBP62juI=; b=QayYHsTGd+u7xHTLuGbkWv0u5l
 AMh6AmSrFE2PlPa/ZAHS2ALjsJ6Bo8McdavZD0tskjGnw9s6m07d4otnSbgjmH3iBYi7ylR7rewBy
 x4AIcbk87t2ZX/HVbwCGucQ8VPILphqpoWVAj68HjVkhbp/uOQB/RNTe8+ekPQcrzY7s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+1JKUVEv+OR98/CM1h1gzna07C5BqVxZPLGeBP62juI=; b=Gl9zbzX/SMkvOh6Km4NbAUqSiv
 cjUIcLypu1dNwkp+w61UVLAeUrxgs4FmP+XKj92fGPk6FReuAvFLxngRtM/bEcHWhr/9rJ9Z398ZY
 ADvXe3zPyV1zgVeA6piWvbBGdn8bd0ZMvaPHPtGSTb6T3SS0O9UmsmVaM44BQ6lqK+Po=;
Received: from mail-pj2-f0.google.com ([74.125.227.128])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGsk5-0004Jr-G2 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:45:41 +0000
Received: by mail-pj2-f0.google.com with SMTP id
 98e67ed59e1d1-3a476ee8669so12429a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 23:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791960332; x=1792565132; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+1JKUVEv+OR98/CM1h1gzna07C5BqVxZPLGeBP62juI=;
 b=rIPNrRNzCnM5HvGMpSip3dw94qV9y4Guk/9g25Gg/J0uJiv27kslB1RTo+0dX33JmB
 vNUEAKnWzrdgivebpG6/itGuFE/5EzXhYM2aLC0aVmq0U0nqG1DDmbHHXk6BEoVP8QHk
 9iHP350YeOhRQzCOck31lZvyyX8AFOw8vrUKWWgcJvS0siysfJG2jMzohCRwxhQpJNP5
 V0WgHZkVbDzWBhC5Aev+SRcH/gJm6SOAl+/fJse7Y7lpwr0It9HpPOhGBFCfQr4gMKsa
 1i/L6AJ/vpeD9fJyFt+ZfjnwRR39v/KSRlGoxj5I2b/NoDu/vrldPfRP2ANZ6H0QHm7z
 iWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791960332; x=1792565132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+1JKUVEv+OR98/CM1h1gzna07C5BqVxZPLGeBP62juI=;
 b=XQJFfpUjTmvPrBiq4UYgGBK6KkzxuPQJzJ111iV+at3hjLmld7M1r5ehevtErHyy+y
 9gZC8+x3KL8+xZhGhKvhMhXinnLxutUZKmgafAVcBfRTNk+Wwt/ZYvz4BXwSAcUHiMr4
 1vz8IVFOL05pocKYR4fRQBzBKt2oO/fAq7dYWTEQ5utRie6FJYkLjdR5jXXLIiphO7PZ
 UR8n+dmrMJvPbY/IqLD6FJ4UbtqZJuT/3O+itb4kAc2C4naERM/ZBL98W4Nl+GQIpheg
 gB5+0f/OHYdYGT+ydTJyj6dH8QUhRWRRAkBtIi9DwNxC6vMtUmjoDAEHfFaTA2CMl6UU
 j1Xg==
X-Gm-Message-State: AFq9FYI9iLfhN5m/LlYWdDVBj6uLbEqgb2w4Oa1S3v7ILyxuPwYrauvK
 iV8+HHF9LjaoX9QfSz0Qvp5qS8FPTjEhumiheEtHNXZeHh1KGuZOO67G12JZaUz/9Lc=
X-Gm-Gg: AYBFou0C3TZzY43CrKtbtmkoWhkuobbadDCnFmrJCXag72nr8iOmwikDKHgzRH60TO7
 XYkZR6Mq5EmVGa+DmGitjjaxg7NWMp/ZXvaZSyjKNaS+k2yTyUqPXhx5Uwagco3tzh3LQmzIAyF
 2kg2zuLsr9I/N4D3oQfu2tAeHR4CUlfnkxbMjNi4RzZkMFf/JJiMejS3S2jtehezSp8qsUDNK49
 L+Warji70u2A/6adsWdg7/JAGrnlcb6d02X0ca1z4WVD88hi0FC/Z0eZWcIUOrBlQXh2MuiYxVE
 oBLJDauJiUBzSsxz89sHEc9qD/hU+EYllkR0BSjiBidVp5biIrnghMiAr0Go+EYY05KgCNhp1gD
 P1zcP94fdWCSXfh+07UYqhAjvaCXFLC01uxKbDIW87FmfUh0uPSdKYx/CkrcVTkA0HAgQoSJRHr
 HO7tB7nqGRJ6wlKitjYFf2uwyPAeq3wMmg2PN/4je59SRkoaHvfze86Wn9FupI2Cza8hfD1yrRQ
 LfAOt1Tz5QZAZacQeGww0b/J2XeQ5LLBobvQA==
X-Received: by 2002:a17:90a:d2c7:b0:3ab:2d17:51c5 with SMTP id
 98e67ed59e1d1-3ab3a32d9b3mr12080371a91.6.1791960331656; 
 Tue, 13 Oct 2026 23:45:31 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f04e324sm3236371a91.2.2026.10.13.23.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 23:45:31 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 14 Oct 2026 14:44:33 +0800
Message-ID: <20261014064445.2835813-5-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xGsk5-0004Jr-G2
Subject: [f2fs-dev] [PATCH v5 04/16] f2fs: support atomic file large folios
 buffered write
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, Pengfei Li <lipengfei28@xiaomi.com>,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-kernel@vger.kernel.org, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

ioctl can convert an inode with large folio support into an atomic
file. Support large folio buffered writes for atomic files as well.

Add a large folio atomic write_begin helper that reserves COW mappings
for the write range. For partial head and tail subpages, read the
existing data from either the COW inode or the original inode before
marking the subpage uptodate.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 111 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 81 insertions(+), 30 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a1d2f3b7d9df..c9a213a5e6a2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4273,18 +4273,16 @@ static int __reserve_data_block(struct inode *inode, pgoff_t index,
 }
 
 static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
-			struct folio *folio, loff_t pos, unsigned int len,
+			struct inode *inode, pgoff_t index,
 			block_t *blk_addr, bool *node_changed)
 {
-	struct inode *inode = folio->mapping->host;
 	struct inode *cow_inode = F2FS_I(inode)->cow_inode;
-	pgoff_t index = folio->index;
 	int err = 0;
 	block_t ori_blk_addr = NULL_ADDR;
 	bool cow_has_reserved_block = false;
 
-	/* If pos is beyond the end of file, reserve a new block in COW inode */
-	if ((pos & PAGE_MASK) >= i_size_read(inode))
+	/* If index is beyond the end of file, reserve a new block in COW inode */
+	if (((loff_t)index << PAGE_SHIFT) >= i_size_read(inode))
 		goto reserve_block;
 
 	/* Look for the block in COW inode first */
@@ -4462,6 +4460,61 @@ static int prepare_large_folio_write_begin(struct inode *inode,
 	return 0;
 }
 
+static int prepare_large_folio_atomic_write_begin(struct inode *inode,
+		struct address_space *mapping, struct folio *folio, loff_t pos,
+		unsigned int len)
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
+						&blkaddr, &node_changed);
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
@@ -4544,35 +4597,25 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	blen = min_t(unsigned int, len,
 		     folio_size(folio) - offset_in_folio(folio, pos));
 
-	if (f2fs_is_atomic_file(inode))
-		err = prepare_atomic_write_begin(sbi, folio, pos, len,
+	/*
+	 * Flush the cached IO of this folio and make sure it is stable
+	 * before touching it, especially for the large folio prepare
+	 * below which reads and updates subpage states.
+	 */
+	f2fs_folio_wait_writeback(folio, false, true);
+
+	if (f2fs_is_atomic_file(inode) && !folio_test_large(folio))
+		err = prepare_atomic_write_begin(sbi, inode, folio->index,
 					&blkaddr, &need_balance);
 	else if (!folio_test_large(folio))
 		err = prepare_write_begin(sbi, folio, pos, blen,
 					&blkaddr, &need_balance);
-	if (err)
-		goto put_folio;
-
-	if (need_balance && !IS_NOQUOTA(inode) &&
-			has_not_enough_free_secs(sbi, 0, 0)) {
-		folio_unlock(folio);
-		f2fs_balance_fs(sbi, true);
-		folio_lock(folio);
-		if (folio->mapping != mapping) {
-			/* The folio got truncated from under us */
-			folio_unlock(folio);
-			folio_put(folio);
-			goto repeat;
-		}
-	}
-
-	f2fs_folio_wait_writeback(folio, false, true);
-
-	if (folio_test_large(folio)) {
-		err = prepare_large_folio_write_begin(inode,
-					folio, pos, blen);
-		if (!err)
-			return 0;
+	else if (f2fs_is_atomic_file(inode))
+		err = prepare_large_folio_atomic_write_begin(inode,
+					mapping, folio, pos, len);
+	else
+		err = prepare_large_folio_write_begin(inode, folio, pos, blen);
+	if (err) {
 		if (err == -EAGAIN) {
 			f2fs_folio_put(folio, true);
 			goto repeat;
@@ -4580,6 +4623,14 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 		goto put_folio;
 	}
 
+	if (f2fs_balance_fs_folio_locked(folio, mapping, need_balance)) {
+		f2fs_folio_put(folio, true);
+		goto repeat;
+	}
+
+	if (folio_test_large(folio))
+		return 0;
+
 	if (blen == folio_size(folio) || folio_test_uptodate(folio))
 		return 0;
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C402CC6B19
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zmf7KZsxSwcW9eggA0X7SlF112QHPYuhLQnsm/sEVeI=; b=V7ZNoJcCQpvecy9lNAFlXLXj4Y
	zcOksgP+hxwrOD9oVhaOeUdM3TB1G8BVDInv9drgJrkC1zcngd/QkOi8ecCV1DBKhuUendUoiYvH4
	dbhiC0elyG/ItptoR+2eIc8svqNaqU7n5UE+qP40mhBCPfeqqdlXu8IaImIq7T+2lT6Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGskl-0006pN-VZ;
	Wed, 14 Oct 2026 06:46:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGskl-0006pE-KH
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:46:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i33AKcFZr9OedDK5gfswdb7j4DkkZIUm6sbOML1I+Aw=; b=ZDmOvbwB61TbyRsuT51aVh2G6y
 H8CsO34uT980+hMNVC7KZWxg0lVgN6bTAzXphrPvYBLXd3RT9oswqHUyktkUeEoiUb0cneDVnlsXJ
 xWqA/uuuFZ7cSFtZg29SSZWiGILyjYcKt0lSX1mVZLfa894rKll7l7BxV8OO0UuFiR6o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=i33AKcFZr9OedDK5gfswdb7j4DkkZIUm6sbOML1I+Aw=; b=BfBlumBaAiwLLIe2TsDUsSePLd
 F1YwC63UN8Lg5DUuSFyUufbBL6B42Aei0tynkmkJvXK5iFYvK3JXWJM+4GPIvi7AimDyiBqQt0D08
 oOxRpt3dZTETEjZAKIWD0QhfnSNfZB4S7yWdESqv3PJytfAFUj6y6ZbGK/qpE15VZjH0=;
Received: from mail-pj2-f1.google.com ([74.125.227.129])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGskj-0004OQ-Rf for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:46:20 +0000
Received: by mail-pj2-f1.google.com with SMTP id
 d9443c01a7336-2cb3f5bb19aso598635ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 23:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791960372; x=1792565172; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i33AKcFZr9OedDK5gfswdb7j4DkkZIUm6sbOML1I+Aw=;
 b=JWaPgS3ps1WbfuvIPGEwD1IJuHi5ZeGjjF3iaEg4lxY3Yl36roB+jn/pvnQokWa/i6
 MFdHN8PasbXKYgAUggyO5MtmLC7wt0mqA7MQjT46mK2/6yz2M0gaT3R0EfisJhvhqEpL
 MQfDsYmzznevvNix7tClJR/rRVddTmDeoE/EF637FZrDuAIUv/y+8OyzGS7NXHivsOYB
 yocwGUpTo+VmWJ23D0t3XClD2cRL3L6ORR7t4AyW3jneER7rj8D5Wr5bTN9cH88y+JkQ
 XfL9XrJXWjbC0PHtHhEC65pvL8W6jHH8M5/fICEnnuLTu7AwllxWR2tbVGzYUVCG1S5J
 QEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791960372; x=1792565172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i33AKcFZr9OedDK5gfswdb7j4DkkZIUm6sbOML1I+Aw=;
 b=gfBXbDFJupqq9mI6HkwQzC+2rFWZXFDfYP6ccq9Flp7RNiEfSVnW8hVWE2bb3/PnMk
 GfVYvQKve1gwAUSOwBohEvasiebhX04MiI0aEy9y3ALA3FzTceomjFk8QR0uAW7a2Io+
 yhaTRGTtYxRb4BWgZLQNqDaZUu+lxnpKerXyN4eP5glSgMNuvWkMuWKDXQrujRawjFmR
 fawupz6x+nfVD1fZ6zEK9gmPVoo55Adi+R4qoXLjvT7Le7K6rZKfkKeXFJ37H4TKXWIB
 KuLv4Fz5IqZGukRgNNHtaIW6EJKrRRI22uXSPudWGQ5uS0Gy/O+7mOGZPQHn+oCCnYPL
 OvmA==
X-Gm-Message-State: AFq9FYIY5uC5LnOP3n8L+3CCvk11DT3FFjnqxoLoKqMvkfmlnK4UuGS+
 hct0kr4paXXJ5fx8Ou52cDaqhcuEyH+rOrdrnH14wuopkNBKccwAzvLHJjMDXh41Lig=
X-Gm-Gg: AYBFou3dd2CDz+k12oBlNYzqkz6aX/r+u4UG0fg+qPcw+IQtTDyu8Op6ojPJXJ3Obf6
 D9n0vZJPeogbZJ40bGmSXb7tVWoKAqOShRNeVnoIOr79ACZWFXryAIVm0d3hlCRTqz87qq2Mqso
 O7Q3x5zY7MMqz63gst/SabXyZYjoVXzRPpIWE2Mshp7btCNxPamQ51cVk9weDPUg+2VH8062lJG
 FUdEo3f3nApQSMDm1mIL3RBOWzsyxP3M0SoEhXIPLMPLFFGsm+ji+P9pksPKIz6YmajtwKcHP5v
 idbI5JnL7p6jEESMOkV7P189a2lSU+PIZYTx3lQS476TMt5krEgAJ61B9Sf1D7CPjGJQz2newHI
 DCM1jf3jnuifdX2Cq5Y7K0nhH2x7AX5B3myncYCA4CiP1R5LEmgTkU9lTxek4VLXHAVqTfUdnwq
 lqA/f6EckgjgmcYGdCYm0HSmE8k3tqSPtB7sNl+7sM7lBc0cMphkgS3kErvMQMKqiWBryVbWAru
 VxLDgnjQxg5VHhGkPfVj0pl1Yuy4FXLPrdkKKpYPkk8ZJ7r
X-Received: by 2002:a17:90b:4a45:b0:3ab:2caf:c098 with SMTP id
 98e67ed59e1d1-3ab3a32f5a5mr12010994a91.7.1791960372059; 
 Tue, 13 Oct 2026 23:46:12 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f04e324sm3236371a91.2.2026.10.13.23.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 23:46:11 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 14 Oct 2026 14:44:42 +0800
Message-ID: <20261014064445.2835813-14-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xGskj-0004OQ-Rf
Subject: [f2fs-dev] [PATCH v5 13/16] f2fs: fix zeroing paths for large folios
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

Several f2fs zeroing paths still use PAGE_SIZE based offsets after
a file mapping can contain large folios.  This is fine for order-0
folios, but it zeros the wrong range once the target block is not at
offset 0 in a large folio.

Use offset_in_folio() to translate the file block index to the folio
offset before zeroing data in truncate_partial_data_page(), fill_zero(),
and f2fs_get_new_data_folio().

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 18 +++++++++++++-----
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/file.c | 29 ++++++++++++++++++++++++-----
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9cd1c34fe6c8..45861c31fe76 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1816,6 +1816,12 @@ struct folio *f2fs_get_new_data_folio(struct inode *inode,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	if (folio_test_large(folio) && !f2fs_ffs_find_or_alloc(folio)) {
+		f2fs_folio_put(folio, true);
+		f2fs_put_cache(ientry, true);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	set_new_dnode(&dn, inode, ientry, NULL, 0);
 	err = f2fs_reserve_block(&dn, index);
 	if (err) {
@@ -1825,13 +1831,15 @@ struct folio *f2fs_get_new_data_folio(struct inode *inode,
 	if (!ientry)
 		f2fs_put_dnode(&dn);
 
-	if (folio_test_uptodate(folio))
+	if (f2fs_ffs_test_blk_uptodate(folio, index))
 		goto got_it;
 
 	if (dn.data_blkaddr == NEW_ADDR) {
-		folio_zero_segment(folio, 0, folio_size(folio));
-		if (!folio_test_uptodate(folio))
-			folio_mark_uptodate(folio);
+		size_t off = offset_in_folio(folio,
+					(loff_t)index << PAGE_SHIFT);
+
+		folio_zero_segment(folio, off, off + PAGE_SIZE);
+		f2fs_ffs_mark_subrange_uptodate(folio, off, PAGE_SIZE);
 	} else {
 		f2fs_folio_put(folio, true);
 
@@ -2908,7 +2916,7 @@ bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index)
 	return test_bit(idx, ffs->state);
 }
 
-static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
+void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
 				       size_t len)
 {
 	struct f2fs_folio_state *ffs;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 36ec8266af69..ddff43bcb800 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4480,6 +4480,7 @@ struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
 			bool for_write);
 struct folio *f2fs_get_new_data_folio(struct inode *inode,
 			struct f2fs_cached_block *ientry, pgoff_t index, bool new_i_size);
+void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset, size_t len);
 int f2fs_do_write_data_page(struct f2fs_io_info *fio);
 int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 30f1484d2f48..5a8dbe228fb1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -837,12 +837,13 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 static int truncate_partial_data_page(struct inode *inode, u64 from,
 								bool cache_only)
 {
-	loff_t offset = from & (PAGE_SIZE - 1);
 	pgoff_t index = from >> PAGE_SHIFT;
 	struct address_space *mapping = inode->i_mapping;
 	struct folio *folio;
+	size_t folio_off;
+	size_t blk_end;
 
-	if (!offset && !cache_only)
+	if (!(from & (PAGE_SIZE - 1)) && !cache_only)
 		return 0;
 
 	if (cache_only) {
@@ -860,12 +861,22 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
 		return PTR_ERR(folio) == -ENOENT ? 0 : PTR_ERR(folio);
 truncate_out:
 	f2fs_folio_wait_writeback(folio, true, true);
-	folio_zero_segment(folio, offset, folio_size(folio));
+	folio_off = offset_in_folio(folio, from);
+	blk_end = min_t(size_t, round_up(folio_off, PAGE_SIZE),
+					folio_size(folio));
+	folio_zero_segment(folio, folio_off, blk_end);
 
 	/* An encrypted inode should have a key and truncate the last page. */
 	f2fs_bug_on(F2FS_I_SB(inode), cache_only && IS_ENCRYPTED(inode));
-	if (!cache_only)
+	if (!cache_only) {
+		/*
+		 * The folio was read back above, so the subpage is
+		 * already uptodate and dirty data stays valid.
+		 */
+		f2fs_ffs_mark_subrange_dirty(folio, folio_off,
+				blk_end - folio_off);
 		folio_mark_dirty(folio);
+	}
 	f2fs_folio_put(folio, true);
 	return 0;
 }
@@ -1329,6 +1340,7 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct folio *folio;
 	struct f2fs_lock_context lc;
+	size_t folio_off;
 
 	if (!len)
 		return 0;
@@ -1343,7 +1355,14 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 		return PTR_ERR(folio);
 
 	f2fs_folio_wait_writeback(folio, true, true);
-	folio_zero_range(folio, start, len);
+	folio_off = offset_in_folio(folio,
+				   (loff_t)index << PAGE_SHIFT) + start;
+	folio_zero_range(folio, folio_off, len);
+	/*
+	 * This subpage must be uptodate here, which is guaranteed by
+	 * f2fs_get_new_data_folio() above.
+	 */
+	f2fs_ffs_mark_subrange_dirty(folio, folio_off, len);
 	folio_mark_dirty(folio);
 	f2fs_folio_put(folio, true);
 	return 0;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

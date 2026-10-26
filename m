Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2237C606A31B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 03:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Jz5ygOM0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iog5c77m;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Tpm2Yh2x;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gIz72j8/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=JoYwxfTXxa+yVfEbWrdrjLsQ7bDhp3tIVKI0gkUXVlw=; b=Jz5ygOM0Xr2lSRsi/j4Fez76tw
	8UC/h93PwnrWWmwsqrQMETMSiEzwpRpZyu+xnz0jUjggF5WBOIbQOKNA7VaWgFQyqcACAaUGvzbUl
	uQi/7VcnwNgGiV2F4BqCtci16yI/P+mHB/PQDeUW4JGYZSkyCzbRxrsG/KxEvJ1F4kAA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLBYB-000000000Qh-3Y4E;
	Mon, 26 Oct 2026 03:39:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xLBY9-000000000QX-3BND
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:39:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sPD0TlvRSW9AoDUlEQvQhAQDfXBM+OsJ3GRNelFftIM=; b=iog5c77mi+Hjt/TZ+0xIeXuWM4
 Q+jVOvBkPmxW2Cu2p35BR6aY6+tojYZh2EdQGmOS5sbO7fPpqrqKqbVORLxti7hQK9XWk5HsWprSk
 +KiR4WDuQsiqp037eP4v3L9h1ly4DbRAb12fqSTX04U3hzfeqFWbhx35SSOtlNKOXwqk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sPD0TlvRSW9AoDUlEQvQhAQDfXBM+OsJ3GRNelFftIM=; b=Tpm2Yh2xEVPqMwC2Fdgbla+Np7
 1W2sLRXcRpi8SqE8vZhUmeDxRAfenvjvm6YMUihp7eG21APWEgPvZtNQcnoF1s0K3CRIVhd1W2FT/
 R4VyuwV4NiwWySsXU8IgS7y2W6QvwUI1/ZlVcPvEzbNEqZsUCuyNIHi27+80r3tAfSRA=;
Received: from mail-pj2-f11.google.com ([74.125.227.139])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLBXy-000000000gX-0909
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:39:05 +0000
Received: by mail-pj2-f11.google.com with SMTP id
 98e67ed59e1d1-3ae08d3dd4fso788832a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 20:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792985928; x=1793590728; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sPD0TlvRSW9AoDUlEQvQhAQDfXBM+OsJ3GRNelFftIM=;
 b=gIz72j8/m6qNnXG+PGgIhfLUzzRxwupKwY45kFHddkO/uUzhkSB3PNm6dOQllogUNO
 I6uylj5L9Z69xjFDd1ljRLnO0ILk3QlHLA/6ZtcSgt0XIyGsEJtQkRY8bk51DL+DznQ3
 +ei3BI/2oKggzekJzab9datdLMUapVshx3lcplJy9F0nBpCDe2X3RXc5sJvEY6qJlBgA
 H6ywAjm56F+J2ye/3cQzyd87+yE3aWSYV9KRqo6SbJ+npbs3RGMmTio+H/eD8RzABTTf
 WDOgBO68qV7laYesW5nGahEGTLKWmPNeJvhfoFUO1lsyR51iBxtqQ/pET9td+SjOlvCC
 0Qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792985928; x=1793590728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sPD0TlvRSW9AoDUlEQvQhAQDfXBM+OsJ3GRNelFftIM=;
 b=EjM4Rjfs+GVAL3W9QgUIDkii9H3NJxrl/6y41zNttYo9Nt1yZ7OjalWMcIT+3Hziqj
 4+D2ZQ46+gRa18M9UtBcKGATpJLIn54EunKF7NL1kqiq0bAIvDERKlILrCZnGucUF7K9
 fBrVieVqjHUQdzaUccJxR5p0YGuJntAljBm7Vb9W64SID7IH1BWAQHO9/9fcdXtwEEp9
 1XK4iqwRjzCqXe2bD2YbVplT3rPNuAqaNjKCyea1ukCyaPoAAJxso8CrOMzUyuUo4Ya8
 OQjgj8BNDP6fZQuNfuSRpaX2oe7nqArw30XdQa0elL3ZJftOOacni710k9ZRHFt6CBgZ
 pXCQ==
X-Gm-Message-State: AFq9FYLBGn9lsI6By/xALPzroeteo07wAsuf1ErJP3zIRUU8ThJr+JMD
 84ZK8pEgD5SvA2kuI/4MYM1noL/RiK/KaXoNtKbc6Lg+3bO5r+DJQz4yPAjcYf3dq2ibVA==
X-Gm-Gg: AYBFou3h9Rkqjzd3cMZG/VQ8VtL6279ZGj5t+L3ADUKlpCoazZhpFygicMHTBfBP3hY
 fNPdoMC9jka9INMkNhWcJ4KA9Mj+ZJQdZTi6/ulaNV0efO7c7M3j10Gu5/oM59Hb/eQbhDQ70As
 eqEv/FJPrtd/G5/xyGcmOk8NzF6elfFlgG0eeKEEsFDj/PUeqdqDRSAQVBkuaOHatdLrFCDEgWy
 A3h7XYqG/A5OmPj8+/PetufA+Hwf2ywde1nBywVU6aMpnz4qOLOO7Z30kjaQ032S43lG4a7/+NO
 Fq4jEfMzj2AVVlE3k/uTYYcHRA6S+sBwCBwELCbvYUhaBZ+LEI+H60PCohg8TDCk5FbrNnG0xgi
 X73BDjP/k2vgz3aAaK9/a4dHA1HQ8beUdWtU+YN4F7M9g19IT+bOl9+O0XWUxg6MteqKFxKSpoo
 mtiRJlNuTsPwXt020q6+jnO7GwFa8wXJ+L7TBl1jrczXJ8adQs63mWg9o2UiSLjmYbnVicXepxL
 7cMlbhB4zzey+7eolCPcYUGVqyj4YjrnRFZrbwblXXMKKVvsat6pksPx2omCJaW7DJdpCYDxdyf
 vNVHUZ7JuUEvNErVgWWXkcjQrNCsU9faFs+1WF6QPxM2Im5yHtjepq+czudnrXHAJZ8=
X-Received: by 2002:a17:90b:2782:b0:3ad:8769:8741 with SMTP id
 98e67ed59e1d1-3adea1aec3amr4617770a91.4.1792985928296; 
 Sun, 25 Oct 2026 20:38:48 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebe8f0b2sm6409823a91.8.2026.10.25.20.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 20:38:47 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Mon, 26 Oct 2026 11:37:42 +0800
Message-ID: <20261026033745.784107-13-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026033745.784107-1-nzzhao.sigma@gmail.com>
References: <20261026033745.784107-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLBXy-000000000gX-0909
Subject: [f2fs-dev] [PATCH v7 12/15] f2fs: fix zeroing paths for large folios
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
index 33750ebf31cb..29d39737232d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1855,6 +1855,12 @@ struct folio *f2fs_get_new_data_folio(struct inode *inode,
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
@@ -1864,13 +1870,15 @@ struct folio *f2fs_get_new_data_folio(struct inode *inode,
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
 
@@ -2947,7 +2955,7 @@ bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index)
 	return test_bit(idx, ffs->state);
 }
 
-static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
+void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
 				       size_t len)
 {
 	struct f2fs_folio_state *ffs;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1b63dd961f15..2c9343eb6b5e 100644
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
index 808b72d3d78a..439e84a4aec3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -833,12 +833,13 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
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
@@ -856,12 +857,22 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
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
@@ -1325,6 +1336,7 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct folio *folio;
 	struct f2fs_lock_context lc;
+	size_t folio_off;
 
 	if (!len)
 		return 0;
@@ -1339,7 +1351,14 @@ static int fill_zero(struct inode *inode, pgoff_t index,
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

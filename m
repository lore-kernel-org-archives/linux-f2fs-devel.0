Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E530D606A321
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OzYz82Ak;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gOoQFQmX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hhVHlpY7;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VuJ5AZc3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=M5av6nRkwhVTWlwOSwG49+VwhPwbp4JwPGFk5D44hUk=; b=OzYz82AkH5JfH8MuVrY/sC8C0E
	TbdY37B2MuWjUccLqa7Zou6IVGydehjKFSs6yqFkIIXCKC95iRSQzdvyB5j1LaV6Dt4ImOBXUAFJM
	JBPXsXRHbNaeakfdnwm7dkz/GC5Uc/nCXideWKRmahquM7sfhSr9g5iwdkwQ3clrgybw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJndM-0000000088J-2nBI;
	Thu, 22 Oct 2026 07:54:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xJndL-00000000889-059j
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:54:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pTX8QrcyUUm2Sd+x+BosIb8jc8T/wMYsQo2KtUzjNxo=; b=gOoQFQmXlHVD4k192yX/7MRKb3
 fKiKGukErwgKm45IQj7+Sl2Xs0jXzeS5VLIpzNC7IPT9pbJuEPX98vjKG1xuXMl4fK1KMWUCycUtt
 dET/plekPoDfHI2pL/bs1JxCz3CncmohLs+bHj4uQ4UIVg9kpfr7N2SO2ZYwZGNIdHK8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pTX8QrcyUUm2Sd+x+BosIb8jc8T/wMYsQo2KtUzjNxo=; b=hhVHlpY7DGI5R3DwLOl/qcGiBt
 tE8Tly/tJN0akhFdzBaW7IhPquK5kCuLZQHOLdTYXBfic2/qE+Vru3hQUET+JQl+6rMMPXqCQ8oFO
 aFzfgogASEz4JVyNjzt5VoB9plLe8IJ9ZJNu5xg56cP7fxzD7Qc19WycFM4zbvt06UP8=;
Received: from mail-pj2-f6.google.com ([74.125.227.134])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJndK-0000000050x-1tMY
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:54:42 +0000
Received: by mail-pj2-f6.google.com with SMTP id
 d9443c01a7336-2e987949882so9450255ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 00:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792655677; x=1793260477; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pTX8QrcyUUm2Sd+x+BosIb8jc8T/wMYsQo2KtUzjNxo=;
 b=VuJ5AZc3gb5WHCjDU0otzvw3J8JbyIEiSjqftC5WnQgKl3V5zTEc0Uz2PWWT92dr0M
 bNgHqa46w5WX9ZICkn3xKA4v6l1X4H+vtZdOSHHW0X0s++B1Rw7DXkea3oEDnGr99PA1
 UEupjygDCKG2aUfPM8ezEzzOF/dK8JsrkEvStXqTtHXT8pColKQMg/bzfch4ysvdZ/zS
 EZYiiFv/dSNnW+DVjqtBkaEndVYs85lyCw6I7xmXE5XCmrzUFJUkjAScgILKVMiYgMQ/
 wXMaKOdv1w5yjxtf9gPsUcluhIScYHqPf8D/tn8tzpo/TQNPpk5Gx5VBig6A0zpMP98e
 Fq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655677; x=1793260477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pTX8QrcyUUm2Sd+x+BosIb8jc8T/wMYsQo2KtUzjNxo=;
 b=KtxeS7W0mHeRzTvIMu4p9eoukN7hZc5Yf9Jh4pigpa0RLuL/PyEFnM36YMVattgC8r
 wGioNktpvMSVHuKr3CniXKBGVm0pRrVPE6P6DnkF+V/v8JSomsPPkqQxvc07IatHVsUu
 gBh3aSr7FBONbFP0bdpY6xX89Cm7m1lYbKwmBKdgX7KGHSy3icp10Swb+geNBfM3YfJT
 1ch9RV1HlnsV94M/1J5cupDMiWgcji3sd4r2GbtmvE6iMokdT+Eq+Zt8E/j3jT6DUSVQ
 OlWd0aleJ3o1d4Q5g5C2SViGH+aARarmaddl0nJtfZotompq1mPztR0WlDEX4jHg1epp
 U+zw==
X-Gm-Message-State: AFq9FYK11eKP9SwG3F7/6+DcOm4Lz9Yq9ZPRZc2xLxRogUJ6eoYZa2wn
 1qLlZVRwpfgdQ8c61ls54iPY5zk5YOH8IIZZLd0jUj83+0wXbCt7DYL4sgK2PdZR
X-Gm-Gg: AYBFou1k9EnrIh4UILGAM5eQE/QktY/uEQjnHuGgkb+yPo0VyMpWIGLHnrc7gW3k7S4
 7EuWvcR5x8GgKH471N+c4p7ou0didgJC6dTTR8lwYMtQ188DMW0I5982BXvKIc8qCXE/VDokwhn
 ghyyrw2MKhB5AqCOJ7C7GRZrvsWI7i5WGxCh7l6N6tajqmI3uD2hJ849dpOeZjxWq5RPsERLG7w
 kYdIORa+9CdN+a4i5uKAZx3PsgN+CSmyPi4dji0fwe9yAXpBzw/inrOOEY/P4wMpmWkGCl0KH2r
 CIh5JqctQZIMGCY88EopZ6jo3IMyuYXlLm6kZJqCfg9eDuM58V4Y9l6sr0SKNWFzw3bELnWSYKY
 HiNCXLE/A//1UJI8cyWDQWmiDB0/PeOlQiENis1uR6A+HqPvMwPVL1/wlvp04iPM1pqHrgF1Wnw
 paem07bbzhGdEkEu0C7pYCnWEYqh7PnCSkx9cy0bWWyeD7FxD7A/Wj7E/M2JromOSVbvGkR3Ssm
 3ftXoR2tptTSdyaDdKxdKDq/f2qNC6EnoK0lQo9EWorDghk8wGKBepLLVpx0Hv+HtN6DdO2cvqN
 Kl02nS+5CzoFPD9IecW8c+yj9ObU5/PsGuPonmJu
X-Received: by 2002:a17:90b:180d:b0:3a0:ca1d:b40d with SMTP id
 98e67ed59e1d1-3ad8709e501mr3878379a91.55.1792655676655; 
 Thu, 22 Oct 2026 00:54:36 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada4896c71sm3202562a91.6.2026.10.22.00.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:54:36 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Thu, 22 Oct 2026 15:53:38 +0800
Message-ID: <20261022075343.3043003-12-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022075343.3043003-1-nzzhao.sigma@gmail.com>
References: <20261022075343.3043003-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJndK-0000000050x-1tMY
Subject: [f2fs-dev] [PATCH v6 11/15] f2fs: handle partial truncate of large
 folio dirty subpages
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

A large folio can be partial truncated and stays in folio mapping, we
need to clear the subrange dirty bits and uptodate bits that the partial
truncate covers. If this partial truncate happens to clear the last
subrange dirty bits, then cancel the whole folio dirty state.

Also add a guard in f2fs_write_folio_dirty_range() so a large folio
subpage whose disk block was already truncated (NULL_ADDR) is skipped

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 89 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e718ed01fe7c..24613b00f843 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -404,7 +404,6 @@ static void f2fs_ffs_put_write_pending(struct folio *folio, unsigned int nr)
 	if (folio_test_writeback(folio))
 		folio_end_writeback(folio);
 }
-
 static void f2fs_write_end_bio(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi = bio->bi_private;
@@ -2955,6 +2954,41 @@ static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
 		folio_mark_uptodate(folio);
 }
 
+static void ffs_clear_subrange_uptodate(struct folio *folio,
+					size_t offset, size_t len)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned int nr_subpages, start, end;
+	unsigned long flags;
+
+	f2fs_bug_on(F2FS_F_SB(folio), offset + len > folio_size(folio));
+
+	if (!f2fs_folio_has_ffs(folio))
+		return;
+
+	ffs = (struct f2fs_folio_state *)folio->private;
+	nr_subpages = folio_nr_pages(folio);
+	start = offset >> PAGE_SHIFT;
+	end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	end = min(end, nr_subpages);
+
+	spin_lock_irqsave(&ffs->state_lock, flags);
+	bitmap_clear(ffs->state, start, end - start);
+	spin_unlock_irqrestore(&ffs->state_lock, flags);
+}
+
+static void f2fs_clear_truncated_page_state(struct folio *folio, pgoff_t i)
+{
+	if (f2fs_folio_has_ffs(folio)) {
+		ffs_clear_subrange_uptodate(folio,
+				(loff_t)i << PAGE_SHIFT, PAGE_SIZE);
+		folio_clear_uptodate(folio);
+	} else {
+		folio_clear_uptodate(folio);
+		folio_clear_f2fs_gcing(folio);
+	}
+}
+
 bool f2fs_ffs_test_blk_dirty(const struct folio *folio, pgoff_t index)
 {
 	struct f2fs_folio_state *ffs;
@@ -3732,7 +3766,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 
 	/* This page is already truncated */
 	if (fio->old_blkaddr == NULL_ADDR) {
-		folio_clear_uptodate(folio);
+		f2fs_clear_truncated_page_state(folio, fio->folio_offset);
 		goto out_writepage;
 	}
 got_it:
@@ -3882,12 +3916,31 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
 		}
 
 		err = f2fs_get_dnode_of_data(&dn, data_idx, LOOKUP_NODE);
-		if (err)
+		/*
+		 * If a subpage of folio for a cow file is dirtied but not
+		 * reserve a cow block, fallback to original inode to lookup
+		 * block address
+		 */
+		if (atomic_commit && (err == -ENOENT ||
+		    (!err && dn.data_blkaddr == NULL_ADDR))) {
+			f2fs_put_dnode(&dn);
+			set_new_dnode(&dn, inode, NULL, NULL, 0);
+			err = f2fs_get_dnode_of_data(&dn, data_idx,
+						     LOOKUP_NODE);
+		}
+		if (err && err != -ENOENT)
 			goto block_done;
 		dn_held = true;
 
 		fio.old_blkaddr = dn.data_blkaddr;
 
+		/* This page is already truncated */
+		if (err == -ENOENT || fio.old_blkaddr == NULL_ADDR) {
+			f2fs_clear_truncated_page_state(folio, i);
+			err = 0;
+			goto block_done;
+		}
+
 got_it:
 		if (__is_valid_data_blkaddr(fio.old_blkaddr) &&
 		    !f2fs_is_valid_blkaddr(sbi, fio.old_blkaddr,
@@ -5426,10 +5479,41 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
 	if (inode->i_ino >= F2FS_ROOT_INO(sbi) &&
-				(offset || length != folio_size(folio)))
+				(offset || length != folio_size(folio))) {
+		size_t clear_start = round_up(offset, PAGE_SIZE);
+		size_t clear_end = round_down(offset + length, PAGE_SIZE);
+		size_t clear_length;
+		bool dirty;
+
+		/*
+		 * If the truncated range falls within a single subpage, no
+		 * subpage state needs to be cleared.
+		 */
+		if (clear_start >= clear_end || !f2fs_folio_has_ffs(folio))
+			return;
+
+		clear_length = clear_end - clear_start;
+		dirty = f2fs_ffs_clear_subrange_dirty_and_test(folio,
+						clear_start, clear_length);
+		ffs_clear_subrange_uptodate(folio, clear_start, clear_length);
+		folio_clear_uptodate(folio);
+
+		/*
+		 * If the truncated subrange happens to clear the remaining
+		 * dirty bitmap of the whole folio, cancel the folio-level
+		 * dirty state.
+		 */
+		if (!dirty && folio_test_dirty(folio))
+			folio_cancel_dirty(folio);
+		if (!dirty && !folio_test_writeback(folio))
+			folio_clear_f2fs_gcing(folio);
 		return;
+	}
 
-	if (folio_test_dirty(folio)) {
+	if (f2fs_folio_has_ffs(folio)) {
+		f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
+							folio_size(folio));
+	} else if (folio_test_dirty(folio)) {
 		inode_dec_dirty_block(inode);
 		f2fs_remove_dirty_inode(inode);
 	}
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

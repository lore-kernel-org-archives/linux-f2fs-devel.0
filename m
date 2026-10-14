Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F97CC6B19
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bvUfhLEz3oTDgHUyWDORA2MefpnCH/tjH3uZHGJBd2c=; b=g+vTNCfuI4EyfH4Rz79ZjcRVaO
	Gwng/qPNt0ER7YRgp22CiRMnORj9NWBAtC775h2FIYDcbH7wPEwi8os355e+wMZjgJbvSxG/RN9iT
	AUliEgvGm6Gq4Se0YRCimfuc8wFFX4NtW86QhhZYsdmbtnpz/NCaQsWJ3bRHCpWeQo2E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGskg-0002oo-ET;
	Wed, 14 Oct 2026 06:46:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGske-0002oe-G8
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:46:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zxVvhouO+69qAuqiJO0qt6uWBvP+OPPrVLEtUsWLTS4=; b=RQIhBeIeC6YGFBsaRLLkkN0pUp
 C3y103dfF0Bvw8oFToZFJ0xEYArJ5hyNOfdkuO/BuwVX9XlwyCP9TXnjABL7bSAa57sm1IDzcV0iz
 6n0XyxrXvtLBA7yHctqOMZAc+tiuN8PkGQXxAHR9hE65Q/GZkTMb7vQ2uyzUgc6L7IVE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zxVvhouO+69qAuqiJO0qt6uWBvP+OPPrVLEtUsWLTS4=; b=i1+G9C/upHUk7YcEF2MjPYtTAx
 Hpul2gM8oG7aTbGQx0SzhGBHUeu522EXBP32FrmQL6m2EGR/9wPBLqIR8UHnGTAN8mSLpM6i6SFhU
 SZO0V04QxiqJyUKT5Com26MAKyp9Jqs8TKO+8DrFoFLW/HJyyCqP0nG8yShSNU/LQPv8=;
Received: from mail-pj2-f9.google.com ([74.125.227.137])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGska-0004N8-Le for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:46:09 +0000
Received: by mail-pj2-f9.google.com with SMTP id
 98e67ed59e1d1-3a51696a650so2215224a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 23:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791960363; x=1792565163; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zxVvhouO+69qAuqiJO0qt6uWBvP+OPPrVLEtUsWLTS4=;
 b=iciFZSSQQBiQrtnRHp7KiOzt3eBAOWS+3BjwTyKVmnRqEfJdtaFmKCd+qRh6FEMFNh
 9xqb9T5M0Nb0NQWqunwZ80DRa5NeyZ8Et4lYrG9f/7tmCRtUnBhWELuweanDU2WbYCDf
 ctcq0o8pDJZ4Y8dFATtMELOiokOiRJegkAxWq3QfEdyol1qMt8bvoR1eteCsQKLd3cdY
 1U0AlucznIPUBX1VO+cOkUiido77pK5m4KhhFk9LgBrv/k/P+sISFDXgOfsRVeuwv724
 8bmtUR5mL/LmyP+U7iv+Ogm2ydmdbCGO+JfbwUbWLc0m116gf+LLFa8vhymrtAUeBVe3
 jU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791960363; x=1792565163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zxVvhouO+69qAuqiJO0qt6uWBvP+OPPrVLEtUsWLTS4=;
 b=DLsq0XqD3PPnXMpCzVu3bPBK8FuvL7V7YvOMmgal7JsFO2IQPWO3nK7GVmhHZdZTGk
 odsiJhsEVr1t5qksF1/bkvNBUuaHWWR/3fKYwnPYui5/Y0lXOe+gBK2Szhhpqn0TTY2e
 1xWzJyG77zZx5OxM7glAayewfru2Lg51ko6ERJi6rkLa+ex96AskQPA57c2Sb0IqKXYk
 0Cpy9U5MWzz2IphOkWG33WX2KAdLqaah+jgeKxIaGkUS4uYQ4lqB5ZsBY8BYhFeDvafj
 V/aunrncMGO8UnkC/i0OTJYFIrzA9T4SuP/Ps/xiy+dvuclrgdBUlIgxgLTtpnuhg7Jn
 K3Wg==
X-Gm-Message-State: AFq9FYL13kVpVpBCb3O8SX1oY2vNmCPzxh0AP84eP246QiS2d3VDvKCV
 LuutQ2B7SUILwFMNKjokElAMXg/COLqJwqSglIcqRrslCSqCbMUTbcMpeXp2YOFfgJM=
X-Gm-Gg: AYBFou3dl6p4hl8zAdHAFHywv+5gJx5gufUUcB/0VzWRrgwG+gSXk++7YCImmGIVhkb
 HW7fhsualDHMIfAhfZlQuwqJOqM7iE0Q2u1yrX1sGjWXp51v/3KY7HYFko1K9U7AF8+h9JlktDL
 gh+sMI/JwTm48kJBvPGG5aJ5h9oRrkdz1e7tljBE83sRLIe9Rp3KYyMsOxL8cxEXW4K1JtlJVCU
 uSZuiNKAT7yhOV8DADjEm/M3q9tqpT/0MEUJPuby5lx3wQtK2oD7nu6jMNodL16auvXlU7iGGYQ
 JG8KtbFbB3spEKaKNf2iuJuAe2txSuS9Etm13qknItz13Pby0asD2XK6ZXjxxEhGzCVmtEBCaks
 QxC8kSGvdA09pwTQR6ktcnwF20wDruUPCk2rD+wRcWhJRZ1fBZvf8dNupJjRPHjLyL2Stsj1MPz
 vWFVzglXNZPI+W1E8/V6sGM3Jujr8Qsa4LsXHTinP1ODn9EiOFaTRbqKMczP5B1DBjE0XMLBu5c
 +AmSmTM9zFlhQteK6ngeh/yxEmNUNazbr2j
X-Received: by 2002:a17:90b:1dc1:b0:3aa:f4af:1e14 with SMTP id
 98e67ed59e1d1-3ab3ac7eeb8mr13207845a91.51.1791960362956; 
 Tue, 13 Oct 2026 23:46:02 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f04e324sm3236371a91.2.2026.10.13.23.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 23:46:02 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 14 Oct 2026 14:44:40 +0800
Message-ID: <20261014064445.2835813-12-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xGska-0004N8-Le
Subject: [f2fs-dev] [PATCH v5 11/16] f2fs: handle partial truncate of large
 folio dirty subpages
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

A large folio can be partial truncated and stays in folio mapping, we
need to clear the subrange dirty bits and uptodate bits that the partial
truncate covers. If this partial truncate happens to clear the last
subrange dirty bits, then cancel the whole folio dirty state.

Also add a guard in f2fs_write_folio_dirty_range() so a large folio
subpage whose disk block was already truncated (NULL_ADDR) is skipped

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 129 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 122 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b9f2054f514f..4228c26bee0d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -362,6 +362,27 @@ static void f2fs_cache_write_end_bio(struct bio *bio)
 	bio_put(bio);
 }
 
+static bool f2fs_ffs_has_dirty_subpage(struct folio *folio)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned long flags;
+	unsigned int nr_subpages;
+	bool dirty;
+
+	if (!f2fs_folio_has_ffs(folio))
+		return false;
+
+	ffs = (struct f2fs_folio_state *)folio->private;
+	nr_subpages = folio_nr_pages(folio);
+
+	spin_lock_irqsave(&ffs->state_lock, flags);
+	dirty = find_next_bit(ffs->state, 2 * nr_subpages,
+				nr_subpages) < 2 * nr_subpages;
+	spin_unlock_irqrestore(&ffs->state_lock, flags);
+
+	return dirty;
+}
+
 static void f2fs_write_end_bio(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi = bio->bi_private;
@@ -418,7 +439,8 @@ static void f2fs_write_end_bio(struct bio *bio)
 			wake_up(&sbi->cp_wait);
 
 		if (finished) {
-			folio_clear_f2fs_gcing(folio);
+			if (!f2fs_ffs_has_dirty_subpage(folio))
+				folio_clear_f2fs_gcing(folio);
 			folio_end_writeback(folio);
 		}
 	}
@@ -2909,6 +2931,40 @@ static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
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
+	} else {
+		folio_clear_uptodate(folio);
+		folio_clear_f2fs_gcing(folio);
+	}
+}
+
 bool f2fs_ffs_test_blk_dirty(const struct folio *folio, pgoff_t index)
 {
 	struct f2fs_folio_state *ffs;
@@ -3811,12 +3867,31 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
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
@@ -4366,6 +4441,7 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 		bool verity_in_progress;
 		int folio_submitted = 0;
 		bool bias_added = false;
+		bool dirty;
 
 		submitted = 0;
 		retry = false;
@@ -4514,9 +4590,9 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 		 * Redirty the folio if dirty subranges remain in a large
 		 * folio, or if order-0 writeback fails due to an error.
 		 */
-		if (f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
-					(err ? pos : end_pos) - folio_pos(folio)) ||
-					err)
+		dirty = f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
+					(err ? pos : end_pos) - folio_pos(folio));
+		if (dirty || err)
 			folio_redirty_for_writepage(wbc, folio);
 		else if (!f2fs_folio_has_ffs(folio))
 			inode_dec_dirty_block(inode);
@@ -4527,6 +4603,14 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 		 */
 		if (bias_added &&
 		    atomic_dec_and_test(&ffs->write_pages_pending)) {
+			/*
+			 * For a large folio we clear PAGE_PRIVATE_GCING only
+			 * when the last dirty bit is cleared, otherwise the
+			 * remaining subpages are no longer written back as
+			 * checkpoint-guaranteed data (f2fs_is_cp_guaranteed()).
+			 */
+			if (!dirty)
+				folio_clear_f2fs_gcing(folio);
 			folio_end_writeback(folio);
 		} else if (!folio_submitted && folio_test_writeback(folio)) {
 			/*
@@ -5354,10 +5438,41 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
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

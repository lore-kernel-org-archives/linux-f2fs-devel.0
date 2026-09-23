Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8405EC98302
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 23 Sep 2026 02:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D2C/DB9xAgzCmSsq1rvsphV3PSaLiajEhUsxhUEQFgw=; b=eYkpW4RhuUJWC1HAQtdg7EDBZT
	+K3RmnVs9XOY43TcYAYCvZ0bn5rOAtqyAIr5SbQq4D9kogbO5MaDtW4jRcPzj4yzCnnk4hBNXQFIi
	nJCQmhQnsnVK8xiQmNo4fNX8Oc/BfU3wyPN4LrjzCkJUj5224vMopCUrfh2UBy8eqkVs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x9D4l-0000AB-Nh;
	Wed, 23 Sep 2026 02:51:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1x9D4j-00009s-Pu
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 02:51:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HqA+80dRJCagJodpppCE+xKvVH7PzCWMIz5FXbwN7wg=; b=J0Z36QEMa04tYLixmeYzlvyJb7
 1FX43Bdsh+1WRBGcKw4/Aoc2bMgz4bAwCJUHSe2Qg7p3yIkkKMTPP4f/F3e/z5HKQkyqRn/RnAyUM
 YAuD69N0UXW6veCkq5cy1ShPek0/pbppO32ovq0pqwjhaUNP3JSSpP1D1KVSI+joG08c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HqA+80dRJCagJodpppCE+xKvVH7PzCWMIz5FXbwN7wg=; b=SPFZQcWgtUOUBdjPmHAkLgEEmi
 Xc2yR4Fqm8a5haicvL+vXi5VD3VpxsshIQCqKb0XYN7LR21riBwCICXNW6bJ89Ktxq8UjvWbw2til
 iV/DKU5fJH5cwGxGXrDN1u4WDh67zF0XKQ1F/oD0H1m6qQ/lMR/EkSGqUIenhI35HrZc=;
Received: from m16.mail.126.com ([117.135.210.7])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x9D4g-0003ZB-98 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 02:51:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Hq
 A+80dRJCagJodpppCE+xKvVH7PzCWMIz5FXbwN7wg=; b=QFAw8cE3cpbQSRKDUp
 BAfNB99heb+l8gZF4GkikZKi/vEr/ArxJjjUQKhlX2uF9jBhmtLsq5QVGPUyHXaK
 FoEXWb4Cws8pH7cO94UM6MHRlegbBL79XtjerCQe9zqwI/r53jtIwBsWGcTKRrRm
 XTk2G25n+dt5akjC+YrIcq23c=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id
 _____wD3P4R9PrNqIedMAA--.36282S2; 
 Wed, 23 Sep 2026 10:50:37 +0800 (CST)
To: Chao Yu <chao@kernel.org>
Date: Wed, 23 Sep 2026 10:50:35 +0800
Message-ID: <20260923025035.2202070-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c4e0c6d3-ad28-4e5e-a938-08b7658e9931@kernel.org>
References: <c4e0c6d3-ad28-4e5e-a938-08b7658e9931@kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3P4R9PrNqIedMAA--.36282S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4fAw1rCw1UWw15Zr17trb_yoW5ZFW7pF
 WUKF1DGr4DJ3WUurn7XFn0vw1Sk3srX3y7CFWxG34ft3WYq3s3KFn5t34FyF1fKryxAFs3
 AF4jkay8XF4UGFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRCzuZUUUUU=
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBox42BmqzPn4o6gAA3W
X-Headers-End: 1x9D4g-0003ZB-98
Subject: Re: [f2fs-dev] [PATCH v2 10/14] f2fs: handle partial truncate of
 large folio dirty subpages
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
Cc: Barry Song <baohua@kernel.org>, Nanzhe Zhao <nzzhao@126.com>,
 Juan Yescas <jyescas@google.com>, Dev Jain <Dev.Jain@arm.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-f2fs-devel@lists.sourceforge.net, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, 17 Sep 2026 16:30:59 +0800, Chao Yu wrote:
> Since gcing flag is per-folio, so if block #0 is on gcing, but block #1 is
> truncated, it will drop on gcing flag of folio, result in triggering IPU on
> such dirtied block of large folio? also it will affect f2fs_is_cp_guaranteed()?

Hi Chao,

Thanks for the review. I think I may should change like this?

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f5421334ecf3..a94153be0533 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -351,6 +351,27 @@ static void f2fs_read_end_io(struct bio *bio)
 	f2fs_verify_and_finish_bio(bio, intask);
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
@@ -410,7 +431,8 @@ static void f2fs_write_end_bio(struct bio *bio)
 			wake_up(&sbi->cp_wait);
 
 		if (finished) {
-			folio_clear_f2fs_gcing(folio);
+			if (!f2fs_ffs_has_dirty_subpage(folio))
+				folio_clear_f2fs_gcing(folio);
 			folio_end_writeback(folio);
 		}
 	}
@@ -3575,11 +3597,10 @@ static int f2fs_write_single_data_folio(struct folio *folio, int *submitted,
 
 		fio.old_blkaddr = dn.data_blkaddr;
 
 		/* This page is already truncated */
 		if (fio.old_blkaddr == NULL_ADDR) {
 			ffs_clear_subrange_uptodate(folio,
 					i << PAGE_SHIFT, PAGE_SIZE);
-			folio_clear_f2fs_gcing(folio);
 			goto block_done;
 		}
 
@@ -4122,6 +4143,7 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 		bool verity_in_progress;
 		int folio_submitted = 0;
 		bool bias_added = false;
+		bool dirty;
 
 		submitted = 0;
 		next = true;
@@ -4224,15 +4246,19 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 		 * partially written back), the folio must stay dirty so that
 		 * the remaining subranges are written back later.
 		 */
-		if (f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
-					(err ? pos : end_pos) - folio_pos(folio)))
+		dirty = f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
+					(err ? pos : end_pos) - folio_pos(folio));
+		if (dirty)
 			folio_redirty_for_writepage(wbc, folio);
 		else
 			inode_dec_dirty_pages(inode);
 
 		if (bias_added) {
-			if (atomic_dec_and_test(&ffs->write_pages_pending))
+			if (atomic_dec_and_test(&ffs->write_pages_pending)) {
+				if (!dirty)
+					folio_clear_f2fs_gcing(folio);
 				folio_end_writeback(folio);
+			}
 		} else if (!folio_submitted && folio_test_writeback(folio)) {
 			folio_end_writeback(folio);
 		}
@@ -5054,6 +5080,8 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 			f2fs_remove_dirty_inode(inode);
 			folio_cancel_dirty(folio);
 		}
+		if (!dirty && !folio_test_writeback(folio))
+			folio_clear_f2fs_gcing(folio);
 		return;
 	}
 
-- 
Nanzhe Zhao



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

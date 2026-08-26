Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C660EC61DC2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WrUW1TnLRM0WwamulNrswou159RhDKWPyUGaBhpIKiY=; b=S2TSQILGBVJAL+iu08pVIo9CgB
	xhrRyn14zXOB0uJDav8IACGYIxUyurAf/dX3GStsBoUBCpQjw6cOuLzInF5BP/07JyBMSqyc8EJaV
	mOxJcYJp8rlJnGOJKG18goeAMb0M1y8x2xBwbVtGTwozcChiHc0W6UO/jigfdcX/qqMM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wz8yr-00083p-Ks;
	Wed, 26 Aug 2026 08:27:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1wz8yq-00083W-23
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 08:27:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xTxcu4E3tmYM+GICCGyDOJXm+kl6S84p+izHnMzMsVU=; b=cRIEYCKZthOnm7dwIhp3pFjPZ5
 b74S1wXY+CLkZ6VNlwrVKDUTMaNVrrmVi8k2er1cMNkTEzFujUvHuFn+o0PoXiKpyUJGasojOAdbR
 4qNyAOQwF2qBc2+w8LbPjEdBmUwzk6BaB8HAKTce21160pqi42SP8fbqzGKhyTPACDzg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xTxcu4E3tmYM+GICCGyDOJXm+kl6S84p+izHnMzMsVU=; b=nJFAk+NDhkO7Fz5fcw2GwgC1b0
 ywKq/j/0BV3R7tt/vjC5YJcoWSArdCEkIPC1nc4hdtGeCpN5wZ9+/O6TTWIok0wNdXUiTWKGjr8Z5
 mq5IiqIiTxSRjVlYbkaucRwVR2ipuLSA7e4+kcuLv2fOnyqG2S0oGKADvGQ09GqE17ck=;
Received: from m16.mail.126.com ([117.135.210.7])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wz8yp-0002d8-Eh for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 08:27:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=xT
 xcu4E3tmYM+GICCGyDOJXm+kl6S84p+izHnMzMsVU=; b=mDLRGLYP/67yelO3er
 st/2I++uemgflUHxHG2pGl6/23gNgODYa+1B/LNuEjIG1Vw7pxADykAkMpinSfK8
 kZJssYtfEYxn9NzglTIfCri0uoDqKafaWx8twTns+Wj5DTusk7yHgm0wzSPFdr8o
 PYpV0WcJYS7mpPrCYwJSLrpZc=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wD3F29Bo45qLzIoGQ--.14929S12; 
 Wed, 26 Aug 2026 16:26:50 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 26 Aug 2026 16:26:37 +0800
Message-ID: <20260826082641.2007658-11-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
References: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3F29Bo45qLzIoGQ--.14929S12
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr4fuFyrWr43GFW5Aw4fKrg_yoWrJw1DpF
 WDG3s8Jrs8J3Zruw1fXFn8Xr13K3s7Xr4UCa97Gw1fJ3WYv3sxKF18t34FgFs8Jry8AF1f
 Xr1jyay5WFyUKF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjeHgUUUUU=
X-Originating-IP: [114.247.175.250]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBogo5CWqOo0pS6AAA3v
X-Headers-End: 1wz8yp-0002d8-Eh
Subject: [f2fs-dev] [PATCH 10/14] f2fs: handle partial truncate of large
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

A large folio can be partial truncated and stays in folio mapping, we
need to clear the subrange dirty bits and uptodate bits that the partial
truncate covers. If this partial truncate happens to clear the last
subrange dirty bits, then cancel the whole folio dirty state.

Also add a guard in f2fs_write_single_data_folio() so a large folio
subpage whose disk block was already truncated (NULL_ADDR) is skipped

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 59b07b83b216..15774e8e8795 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2693,6 +2693,34 @@ static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
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
+	if (!f2fs_folio_has_ffs(folio)) {
+		if (folio_test_uptodate(folio))
+			folio_clear_uptodate(folio);
+		return;
+	}
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
+	if (folio_test_uptodate(folio))
+		folio_clear_uptodate(folio);
+}
+
 bool f2fs_ffs_test_blk_dirty(const struct folio *folio, pgoff_t index)
 {
 	struct f2fs_folio_state *ffs;
@@ -3599,6 +3627,21 @@ static int f2fs_write_single_data_folio(struct folio *folio, int *submitted,
 
 		fio.old_blkaddr = dn.data_blkaddr;
 
+		/* This page is already truncated */
+		if (fio.old_blkaddr == NULL_ADDR) {
+			ffs_clear_subrange_uptodate(folio,
+					i << PAGE_SHIFT, PAGE_SIZE);
+			folio_clear_f2fs_gcing(folio);
+			f2fs_put_dnode(&dn);
+			if (f2fs_folio_has_ffs(folio)) {
+				struct f2fs_folio_state *ffs =
+					(struct f2fs_folio_state *)folio->private;
+
+				atomic_dec(&ffs->write_pages_pending);
+			}
+			continue;
+		}
+
 got_it:
 		if (__is_valid_data_blkaddr(fio.old_blkaddr) &&
 		    !f2fs_is_valid_blkaddr(sbi, fio.old_blkaddr,
@@ -5075,8 +5118,37 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
 	if (inode->i_ino >= F2FS_ROOT_INO(sbi) &&
-				(offset || length != folio_size(folio)))
+				(offset || length != folio_size(folio))) {
+		size_t clear_start = ALIGN(offset, PAGE_SIZE);
+		size_t clear_end = round_down(offset + length, PAGE_SIZE);
+		size_t clear_length = 0;
+
+		/*
+		 * If the truncated range falls within a single subpage, no
+		 * subpage state needs to be cleared.
+		 */
+		if (clear_start < clear_end && f2fs_folio_has_ffs(folio)) {
+			bool dirty;
+
+			clear_length = clear_end - clear_start;
+			dirty = f2fs_ffs_clear_subrange_dirty(folio,
+							clear_start, clear_length);
+			ffs_clear_subrange_uptodate(folio, clear_start,
+							clear_length);
+
+			/*
+			 * If the truncated subrange happens to clear the
+			 * remaining dirty bitmap of the whole folio, cancel
+			 * the folio-level dirty state.
+			 */
+			if (!dirty && folio_test_dirty(folio)) {
+				inode_dec_dirty_pages(inode);
+				f2fs_remove_dirty_inode(inode);
+				folio_cancel_dirty(folio);
+			}
+		}
 		return;
+	}
 
 	if (folio_test_dirty(folio)) {
 		if (inode->i_ino == F2FS_META_INO(sbi)) {
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

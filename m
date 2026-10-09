Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFD5CA9EBE
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 16:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=undkpLlNm2Iyl7bpKuKG1sdkWpWULgB9l06hOI5Kmps=; b=Qprr30l1+YQ2WGzwJwliIzKi3w
	ntnavp31+LAWZhiseSE9yr21VUFwapRW6o8EWqG4aJMSIW6/bpAym5s8OtFQZpzptSexr133Ha9V7
	JbxnSJgUP5zJ2Z9Nj7nHMuID/+vPwz1leGB6y4VvH9ANPulobAmIGEkODBCPavOJ6ctg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFDTh-0003Jx-Vu;
	Fri, 09 Oct 2026 16:29:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1xFDTe-0003If-Qh
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 16:29:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QciNIKrv4TAqufgPmbHqPAzFhy4Ox5DXh4e51lt6JOg=; b=B4Z0ED98zGtadOdWglr6QyJ8w6
 HW5oq1O9SsSg/74EPdQnrIYsX2k2HkzSv+p4me4ksasjS+ohxh8KEiFbaKtGNOj00nRgRsmHbARGa
 TUsR9ZO/wNwGXFox3aujVwb4jBTArWhF1dhduoF1fm8rQwxvixalJgSxcNLRfvmlfYsk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QciNIKrv4TAqufgPmbHqPAzFhy4Ox5DXh4e51lt6JOg=; b=gY0p1fk5C1z2tjobmpZBx6oB7S
 ZvloqyqiBJuQKmEeATZU40xXS8CPRmIayZMkRmi3K+U5f+bGJtcm8OQyJ8AiVB+V/35tDXP2Av4Db
 Up0auHRpZJC3OhVYsRt3+OE4SWKBUGX6oU/Qm/itQRmnwKjjiDC8KH5ShRPxmMMKScJg=;
Received: from m16.mail.126.com ([220.197.31.9])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFDTB-0005S5-S0 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 16:29:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Qc
 iNIKrv4TAqufgPmbHqPAzFhy4Ox5DXh4e51lt6JOg=; b=Hun8hC/qCjVgg+xcuu
 ZOkWAeAkDE6MRALXs+m/0v+ne8kZbxl+hyLVRsn2gWdL9sezEi4WLLqeoWPpbILZ
 AXxdRkwvzqKrmwqNvi3tBtYc3XK0Ky2RjEqoWsj5WnlEGp5IhNWJYR0ZB0xdg4Nx
 waZiKJtA/By1VOgUWg4+rGPNw=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PikvCgDH3_w0FslqWTz5BA--.13078S5;
 Sat, 10 Oct 2026 00:28:44 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Sat, 10 Oct 2026 00:28:25 +0800
Message-ID: <20261009162828.4188050-4-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
References: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: PikvCgDH3_w0FslqWTz5BA--.13078S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF4DKF1xAFy7Gr15KFyrXrb_yoW7JF17pF
 yUGasrGrs5Wr48Wr1IvF1DZw1F93s7WF1UCFWxGasIya4Yq3s5KF18t34j9Fs8trW8Arn7
 XF18KFy8WF1UJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joc_fUUUUU=
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsRyhcWrJFjxJmQAA3k
X-Headers-End: 1xFDTB-0005S5-S0
Subject: [f2fs-dev] [PATCH v3 14/17] f2fs: fix zeroing paths for large folios
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
Cc: Barry Song <baohua@kernel.org>, Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 Juan Yescas <jyescas@google.com>, Daeho Jeong <daehojeong@google.com>,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-kernel@vger.kernel.org, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
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
 fs/f2fs/data.c | 16 ++++++++++++----
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/file.c | 21 ++++++++++++++++-----
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 19072fe7dbe5..05267ad91453 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1800,6 +1800,12 @@ struct folio *f2fs_get_new_data_folio(struct inode *inode,
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
@@ -1813,9 +1819,11 @@ struct folio *f2fs_get_new_data_folio(struct inode *inode,
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
 
@@ -2892,7 +2900,7 @@ bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index)
 	return test_bit(idx, ffs->state);
 }
 
-static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
+void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
 				       size_t len)
 {
 	struct f2fs_folio_state *ffs;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a33aae6656d4..80b716b58cbd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4476,6 +4476,7 @@ struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
 			bool for_write);
 struct folio *f2fs_get_new_data_folio(struct inode *inode,
 			struct f2fs_cached_block *ientry, pgoff_t index, bool new_i_size);
+void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset, size_t len);
 int f2fs_do_write_data_page(struct f2fs_io_info *fio);
 int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6eb0c8e05b66..f3c4241feed5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -822,12 +822,13 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
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
@@ -845,12 +846,18 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
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
+		f2fs_ffs_mark_subrange_dirty(folio, folio_off,
+				blk_end - folio_off);
 		folio_mark_dirty(folio);
+	}
 	f2fs_folio_put(folio, true);
 	return 0;
 }
@@ -1318,6 +1325,7 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct folio *folio;
 	struct f2fs_lock_context lc;
+	size_t folio_off;
 
 	if (!len)
 		return 0;
@@ -1332,7 +1340,10 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 		return PTR_ERR(folio);
 
 	f2fs_folio_wait_writeback(folio, true, true);
-	folio_zero_range(folio, start, len);
+	folio_off = offset_in_folio(folio,
+				   (loff_t)index << PAGE_SHIFT) + start;
+	folio_zero_range(folio, folio_off, len);
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

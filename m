Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B216CA6015
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 16:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cZtBeeqqfIFLiwHq6o0lzhp5B5G1Wg7OC+chjUvTyxg=; b=UcYfJYnkCoOrEo1z+rToZh8rOo
	ATDTNWUBDspZoqo8Wb5SSTsJpX4uHQ/S10fnhMI70GRBIJrW1t20JRuTCNOsc+T6O7MILG6bzYvwp
	FcQfvUCH3d8O44XFxkKehm6KYmKrK9s70YqBUE0nzJei7DXPPozm5hKYg3p8L5gI7mDA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFDED-0003jy-DL;
	Fri, 09 Oct 2026 16:13:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1xFDEB-0003jr-Lt
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 16:13:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CKzFpBiAKCgMr3fDTDIv2UklGANvEFrFjqk+dmuUxww=; b=Ehlpk4Z9QFhcCh2B0B7rItTVZ4
 y0odiGW99q+cXGZFdqWaupK6PivowywnG6CMLxsa2nLtEMxMf/v2DqIFf1fhGfa4YQkhikGM8HFYD
 ISF3KFQUiGW5is3UbZRX37cf12zygo67ILZ56g72fNgU8vJKbrWniDo7vKbcC8TGZm0E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CKzFpBiAKCgMr3fDTDIv2UklGANvEFrFjqk+dmuUxww=; b=QETZEvDJrQRbFECEq0+PIuP7Hz
 I62q9FCngrqHt4smwOJ56yXEG6iqDTFQGcF/JsbYYHEJPCdT+t0nsfN3MaCl4+Q/T7FxuIZYqdYht
 yFAYRmiGjCUiPOwjPn660z0qqnb4tn/Z25c/+EYY2rSzrQumzJKn0mW63Ekw+0ln3RFg=;
Received: from m16.mail.126.com ([117.135.210.9])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFDEB-0003lg-EY for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 16:13:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=CK
 zFpBiAKCgMr3fDTDIv2UklGANvEFrFjqk+dmuUxww=; b=A3AsdoppWr43Zz96KR
 eyJ5Fnuu6lqMoRuJdDDRNqi4OGdFbQ9o2cpWKSHhkBVuBeQCP0zTr1DEVOzLYfz0
 MFZw6/z1rNzFGUVzdvCs5xB5EsCNATOPo/Dfmw8GzUEVEGcn4F4MgzQcPmIHNZjY
 cPJ/rbPMIj/zNKPR+ckMcTHug=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wD3V46AEslqHAsZBA--.38226S6; 
 Sat, 10 Oct 2026 00:13:09 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Sat, 10 Oct 2026 00:12:11 +0800
Message-ID: <20261009161224.4163796-5-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
References: <20261009161224.4163796-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3V46AEslqHAsZBA--.38226S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr4UWF45Wr1DJF13tF4DXFb_yoWrKr43pF
 WUKwn5trZxJ343urnavF1DZr1F9a4Iqw47ZayfG3WfZF15Gw13KF10q347uF1YqrWkA3W0
 qF40kFyrW3WUJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUNVkUUUUU=
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBohW2hmrJEpVLWwAA3z
X-Headers-End: 1xFDEB-0003lg-EY
Subject: [f2fs-dev] [PATCH v3 04/17] f2fs: support atomic file large folios
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

ioctl can convert an inode with large folio support into an atomic
file. Support large folio buffered writes for atomic files as well.

Add a large folio atomic write_begin helper that reserves COW mappings
for the write range. For partial head and tail subpages, read the
existing data from either the COW inode or the original inode before
marking the subpage uptodate.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 86 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 68 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index af2bb02e301f..315506e394ed 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4246,18 +4246,16 @@ static int __reserve_data_block(struct inode *inode, pgoff_t index,
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
+	if ((index << PAGE_SHIFT) >= i_size_read(inode))
 		goto reserve_block;
 
 	/* Look for the block in COW inode first */
@@ -4423,6 +4421,61 @@ static int prepare_large_folio_write_begin(struct inode *inode,
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
+		if (f2fs_folio_may_unlock_balance_fs(folio, mapping, node_changed))
+			return -EAGAIN;
+	}
+
+	return 0;
+}
+
 static int f2fs_write_begin(const struct kiocb *iocb,
 			    struct address_space *mapping,
 			    loff_t pos, unsigned len, struct folio **foliop,
@@ -4505,8 +4558,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	blen = min_t(unsigned int, len,
 		     folio_size(folio) - offset_in_folio(folio, pos));
 
-	if (f2fs_is_atomic_file(inode))
-		err = prepare_atomic_write_begin(sbi, folio, pos, len,
+	if (f2fs_is_atomic_file(inode) && !folio_test_large(folio))
+		err = prepare_atomic_write_begin(sbi, inode, folio->index,
 					&blkaddr, &need_balance);
 	else if (!folio_test_large(folio))
 		err = prepare_write_begin(sbi, folio, pos, blen,
@@ -4514,23 +4567,20 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	if (err)
 		goto put_folio;
 
-	if (need_balance && !IS_NOQUOTA(inode) &&
-			has_not_enough_free_secs(sbi, 0, 0)) {
+	if (f2fs_folio_may_unlock_balance_fs(folio, mapping, need_balance)) {
 		folio_unlock(folio);
-		f2fs_balance_fs(sbi, true);
-		folio_lock(folio);
-		if (folio->mapping != mapping) {
-			/* The folio got truncated from under us */
-			folio_unlock(folio);
-			folio_put(folio);
-			goto repeat;
-		}
+		folio_put(folio);
+		goto repeat;
 	}
 
 	f2fs_folio_wait_writeback(folio, false, true);
 
 	if (folio_test_large(folio)) {
-		err = prepare_large_folio_write_begin(inode,
+		if (f2fs_is_atomic_file(inode))
+			err = prepare_large_folio_atomic_write_begin(inode,
+					mapping, folio, pos, len);
+		else
+			err = prepare_large_folio_write_begin(inode,
 					folio, pos, blen);
 		if (!err)
 			return 0;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

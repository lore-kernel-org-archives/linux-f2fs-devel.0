Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02C6CA9ED2
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bA/w6n5kPZkyE+Ewu7qf3Itx2Wommq34DG2Kl1pMZko=; b=Ttv4FrvTcqxZD7fhEStaVe/Y8B
	HA8E4Bqn17zrU2NHihAOaVVNeFNvJ7xvYR16X4lZtgKtaBrR32nPbKNW/26fJ1OSswgtrSotcLAa7
	0cm/5n9jcBglPE2Kzmg4ezNjkaWg2Q7z5/4pcY4kR1kdqaOyHrHizwqOBc5uthl5ad58=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGb7y-0000fx-68;
	Tue, 13 Oct 2026 11:57:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGb7w-0000fe-3A
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:57:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1JGn4fTJRmMMUCqNv1zrxHNWR67j4kFOuytFeUiq8dc=; b=F6QMkGKFgl4owwh2ZAt/8fDp/K
 YLH8hmpRR4eU8t352Me1+jXFiXmhsYyQOCS9IJIaaKlnfMW5bAF4UvOgAq27WLfUik8RvOtUFzKAY
 Zjpg5cX3bxAKkCcwvKHM94nUKrDcB39VQ0iSMk5p4I3nvUeYSG2PhormmaWK3vxSTZfI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1JGn4fTJRmMMUCqNv1zrxHNWR67j4kFOuytFeUiq8dc=; b=BGUXCXoftpWuPTl/lYdv5574/1
 RI7HEJP0TbLhB+Ul1phklkuSopnOv3fPsv5/6k2v/A77Ucle2mum57ZTxX6NDNYujrupQ51qGplNl
 KLV06tzz/KySBCNqBFllXD4P00h1tPE7TkonTNZ0ZHKQjI60K3bZfu+vXapppKoBe0U8=;
Received: from mail-pj2-f10.google.com ([74.125.227.138])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGb7w-0005Qn-8s for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:57:04 +0000
Received: by mail-pj2-f10.google.com with SMTP id
 98e67ed59e1d1-3ac144119e4so620602a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 04:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791892618; x=1792497418; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1JGn4fTJRmMMUCqNv1zrxHNWR67j4kFOuytFeUiq8dc=;
 b=J8gOmJVTjW7wNOqTqqRTVRb8svk3KpG/XAoudvc5JHfy8D9gUke+pSJy5gMWKDMKal
 hLmLm1+9g//oWgdoVTNJ0ozHnc++UConncBfi/DSSsTBvTyNxtA1j7HdZVqkT0/cirq5
 lq+/SmETNsin6UYb/OrLl9fqVASq7u0gUEmPEvlltQZ0THY8BtxbxLftu5NLXmc5S+4p
 g646Y3flr3SSmAI1VfnQannBhTD/RB5j5Qj8K/dBxH6wMaSQpu1tgWGsOt2yMfbmWYPw
 38bxiqe86VaMNfTitEeYiu3AGRrC4VI6Bd48AJZ7VX7HftP2KMGKmdrqm4Kmg2tgyU7W
 gy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791892619; x=1792497419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1JGn4fTJRmMMUCqNv1zrxHNWR67j4kFOuytFeUiq8dc=;
 b=dgzdahyOXEfRHT0LUghehS3Yn3UzUlcAmkgqxCXRKf8xWenHxBS+r6+8CKoUwzCDp1
 h133hzxhumB9FsGQ3D8pcZatLjD/UTb86sRaZCwKnLFq9LkrAFJWRsdlpLEpJuD85vQl
 IXxG9snx8sFT7Mmjf4yS69oWaUnDoANazL/3iSvXz7SJ6axo3AmYDEBWQ8Zy2ztNJwAS
 xXGDvvqJ2YK4W1/o+tBtbt1V/hz0BNvOACx4S9vsDYNxi7PJleq13lfv33SKA+3exjh1
 6qaZU7XOt8T9lAUDNA3LjklotDh6mjWUqvJ4ChSOcK4UpxgfSdfB3L0Tz3DNFyWF2gIs
 a40Q==
X-Gm-Message-State: AFq9FYImv3q8R6hwJsTkA/6b+Tf1f7Xs1/5UINq4cRls0upn1fcTfrUp
 wxpryQc8bEphJg6cl67U3gv2UXwn2SXyxr47S1bvs7YLQg18paQkU/eM8f9O/2aknJc=
X-Gm-Gg: AYBFou0WL80r/VNf9AOmua0m1X8gGqvBEY46fiwKJzYNGdY0BGeUyViYvaCZ0Be6HjX
 SRXWan5lXDGG4UgrdPRDSSDkUvyggm97u9K9Jv+kCZNZzoLMSgv77EmFqghuMsMuxpD8Q46kanG
 +jgNSIsN4pjiyAfgGk+/I5KQLIFcXHhHvBDqW288ixACEvsUYOJ2awK/tZ9MIlKiHrWUbwsMHHl
 bbn76t2/Mr2Baac9LpoWr5LeMy9VabovRuSHHVA+QVWz2/sYYKBi+Q+/kTKFoHJlqpLlcWRwGTW
 oMWHv9Iny+0mBYNE94XA8R7NY6SdM4osq98S8+/Z+9wHRyzVEwXbWwCabi9z//PsJwfpg8C/rYN
 af3O3idnvNQdakIcMgzY2bgjTiUW2WSFPNrLd6lwQaxFf5dia2ostyu+wmZleorUhxMX51bI8Ef
 M3msDIx8uGMl76bJapeAjhJRncUbmXl56EFmNqPXEVsOmIuO7YDzSQwWAifhxkykuVzi6xTCOIv
 uBKN7MqMaU3lkiSG/xGlEJ3LhUMP0sribC/
X-Received: by 2002:a17:90b:5870:b0:3ac:403d:6232 with SMTP id
 98e67ed59e1d1-3ac403d6b24mr1509265a91.55.1791892618559; 
 Tue, 13 Oct 2026 04:56:58 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab37139b59sm21248516a91.13.2026.10.13.04.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 04:56:58 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Tue, 13 Oct 2026 19:56:09 +0800
Message-ID: <20261013115621.968742-7-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
References: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1xGb7w-0005Qn-8s
Subject: [f2fs-dev] [PATCH v4 06/18] f2fs: support atomic file large folios
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

From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

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
index f2b89181f..2ae3013b6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4245,18 +4245,16 @@ static int __reserve_data_block(struct inode *inode, pgoff_t index,
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
@@ -4428,6 +4426,61 @@ static int prepare_large_folio_write_begin(struct inode *inode,
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
@@ -4510,35 +4563,25 @@ static int f2fs_write_begin(const struct kiocb *iocb,
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
@@ -4546,6 +4589,14 @@ static int f2fs_write_begin(const struct kiocb *iocb,
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

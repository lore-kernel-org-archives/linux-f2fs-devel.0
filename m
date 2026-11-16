Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0FC606A31F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 04:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JasU+IkQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MbbBEqp/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RjPh/6fS;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oNyDIwwM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=iK3EGuWkoL6Fe3iQTQa7z001P/H5uBOahzN04ozgiJk=; b=JasU+IkQtclOhsCd+LrdzdrX5B
	yKVix+YVKVkQK4K0610afNgzDM+mPRatZX2tbZbahlGAGYnc8EJYjdZmHmaNbKBtoAjNCAxmeOD4t
	rlhpK/XVckT5cocvw9IyvA0jURTxpPKRFcynNPp6ByWYboEXpqUPOglRTzzipMuU0tPI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSo2H-000000006iB-1IHN;
	Mon, 16 Nov 2026 04:09:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xSo2E-000000006hW-49hP
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l/kLLywOSWBBFLTEPiIbk+45w2BLqtK8W3R0cbQbwWA=; b=MbbBEqp/7sResGGJEuOrH8MSAF
 R/Z96hOSq6Z5iZLniPuZBajinaMo3xSTZnUMxJ6Ct4Xn0ALfJZ2I28ELax+8c6xKyunXRIrGXk37g
 pmxX5pBiW3fgIueLDuEIQ73JOjAlqNI5G5j8bdF6XwEIgQXPQXlDNUl7mb3UbN4BLP7U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l/kLLywOSWBBFLTEPiIbk+45w2BLqtK8W3R0cbQbwWA=; b=RjPh/6fS4di6KGi5ts9MWUECE1
 XldAaIKQ0UZ8stigtwpiSOh4vjCNC1YI5b/AZP99VTTCJvxAfYJghH/0cZ7jCLzfzithsubjzlOHv
 Ku6Q4ZFg+lTWur/uDSidqLFcKz+6i/htrpN/i4hsCyiUAh+QAJIdfzkTka2Jb31wWUzo=;
Received: from mail-pg1-f177.google.com ([209.85.215.177])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSo2E-000000005gz-1sPv
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:38 +0000
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-cddc250d815so1035589a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 20:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794802173; x=1795406973; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l/kLLywOSWBBFLTEPiIbk+45w2BLqtK8W3R0cbQbwWA=;
 b=oNyDIwwM12In/fBn/iBYjhMRCNqU1Z5XzV49sezM70nSBW4vCBmXRxValZZ+7UPd3D
 PzrBrfDJN4vFu4KlGt4dO5PXEwk7qcHaaLFtnTzRPQeKYy8CTNliCrxbXSF9bLpikakw
 GYdHmERxNrcisrCUjYFHK46NrkI9Hapxx8iwRlGJM3y/IYuDTLDOi3arHCG7LxChYmY7
 K3YVJaZyZ5aQa3xoSTG+LNR696gXuhfv7sXj3v/zplf0sZyGMPDlUGm9FL+b4OfC3cyQ
 I3p5er8FgONXKZSNX3/30X9qQ2nQNNAonnuQlSRspVEDxukghxKhlMsqvxtcf7y9MEHP
 2dww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794802173; x=1795406973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l/kLLywOSWBBFLTEPiIbk+45w2BLqtK8W3R0cbQbwWA=;
 b=QO3g9VVuoyiJGUs6Bg0iOV9qTQbfxNyoFM3djbcqn5SmtzWvIvReeM25c0Eh/KNFEm
 EsFgytEnRtiyPgn9zkbLY6MEXsQJJ7VVrt1xW93WFoI+lnwZHuNOsqwXixXsPaQb/7Fr
 H8+OtFKlozSCqZwWiTa5eTBcaHGI7GmN6qEt1HR014MUqVq98Jm7ZIlwX96CfDV79DfK
 Bs8q81LAU5aCzsOrJN7g8XBxrmSrVqVoD7qJ/wP0xnlXaKVH1jN51CRdAkTGXy5/UcMM
 gPFzWlW9ge7MD4BVHx7IZERq2HVdxvN/eyCH7qbCCdPNdrpYI7e8hwu+o3phHcxYiZKi
 7UuQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEK4GhRje4n6tUmLZ3DJDvJcX6HO+UzdbVvd6Sjc2VE+woWhdz7IZTa6viL8qf/Z9eW3b/BEHCp9WbzNJaUyCet@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+pfk6i/CMlWOM2pKfl34Ossf8gUPZB43SCTeLMM3xSdxiDi6Co
 A7Wud5RZJT1SzgzFmVUymoLkZSNdasuKnHPJmP6W1YIapBqgclybn7Hb
X-Gm-Gg: AYBFou0NkQrickDBoC+XX9ZIj5SrNMYShFOUXFquRPfG25fn3DhhhfM/yfIH3GmFdbA
 JQsv8mQAaizoPei9dkPaareGJZ5c0o0XqjuGOTkYc3HHd/J965e6FkzzJ/VyH++QcLvkaTgee2S
 krUsPISRvBWCpK3lw+4o0rZxaG/hG8uUugVkKyZ7JZla0JMDv6vBdKMUCczwi174+jk63XNCvOh
 3XqiEMNhizz/3ZBc4Vfo8nmVtVobviqwMzV5UE6N0M46U3okTfD5AwMwU5gFRFXhgM3biCM5KPj
 EWRmYGHFU2h547wrZz6Gt2/lQdkJEMeGr9McnmgKrJ6+wcXcno2cLyJheP4Mr2byYX3wgBgOixJ
 dqH5L7f5e4UJw9dIoXUJ9D04tFSl5yTG4dUbmOb2DoRUXjUvjQm9w06vbmP2qGMX1CBfrc1lIgX
 O4B2IJX/FB26uK0FO67Bi57SPDD0Py2/v85oWS7hztYAahBsrKW9ubvilIfTlUl2WVnqTlFWlXA
 uqMZZJ+F1DgLMAdV4xiVjEpZTkrvyf4elOFWbUXZxqcoIi/rXL3kNSY2x3Isey36Q58H8CvPwmF
 4XkvdozhJMH5T8K22C/y4BH/MzkfeznxsYx0+LENW/IF65RiRYJNID/xV1w+52gRE1sF7Jm9zHi
 HHSzDCRN5kYBUACB3HAMXdvWJhiXQ5e51ugSRhk5i0Uzis9iE+Ny7Y45SBhJJVFH4BFwp
X-Received: by 2002:a17:90b:3b82:b0:3b0:96b4:ceb7 with SMTP id
 98e67ed59e1d1-3b1b0815b3fmr9869158a91.8.1794802172703; 
 Sun, 15 Nov 2026 20:09:32 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3f09b92sm7191989a91.4.2026.11.15.20.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 20:09:29 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sun, 15 Nov 2026 20:08:47 -0800
Message-ID: <20261116040851.2849696-17-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261116040851.2849696-1-daeho43@gmail.com>
References: <20261116040851.2849696-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xSo2E-000000005gz-1sPv
Subject: [f2fs-dev] [PATCH v2 16/20] f2fs: preserve inline data in subpage
 block mode
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

A write to an inline inode converted it to a regular inode whenever the
folio held multiple blocks, allocating a block even for small files.
Convert only when the write goes beyond MAX_INLINE_DATA; otherwise read
the inline data into the folio and write it back to the inode block in
f2fs_write_cache_folios(). This also applies to an inline inode that
uses large folios when the block size equals PAGE_SIZE: its writeback
now goes through f2fs_write_cache_folios() instead of
f2fs_write_cache_pages().

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/data.c | 54 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b4f16afccc51..7dd6764a9363 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4804,6 +4804,16 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 			}
 		}
 
+		if (f2fs_has_inline_data(inode)) {
+			err = f2fs_write_inline_data(inode, folio);
+			if (!err) {
+				f2fs_folio_clear_dirty_blocks(folio, true);
+				goto retry_out;
+			}
+			folio_redirty_for_writepage(wbc, folio);
+			goto retry_out;
+		}
+
 		folio_start_writeback(folio);
 
 		/*
@@ -4992,8 +5002,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 	account_writeback(inode, true);
 
 	blk_start_plug(&plug);
-	if (f2fs_has_multiblock_folios(inode) &&
-	    !f2fs_has_inline_data(inode))
+	if (f2fs_has_multiblock_folios(inode))
 		ret = f2fs_write_cache_folios(mapping, wbc, io_type);
 	else
 		ret = f2fs_write_cache_pages(mapping, wbc, io_type);
@@ -5060,6 +5069,16 @@ void f2fs_write_failed(struct inode *inode, loff_t to)
 	}
 }
 
+/* Fill @folio from the inline data for a write within the inline area */
+static void prepare_inline_write_begin(struct inode *inode,
+		struct folio *folio, struct f2fs_cached_block *ientry)
+{
+	f2fs_do_read_inline_data(folio, ientry);
+	set_inode_flag(inode, FI_DATA_EXIST);
+	if (inode->i_nlink)
+		f2fs_cache_set_inline(ientry);
+}
+
 static int prepare_write_begin(struct f2fs_sb_info *sbi,
 			struct folio *folio, loff_t pos, unsigned int len,
 			block_t *blk_addr, bool *node_changed)
@@ -5113,10 +5132,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 
 	if (f2fs_has_inline_data(inode)) {
 		if (pos + len <= MAX_INLINE_DATA(inode)) {
-			f2fs_do_read_inline_data(folio, ientry);
-			set_inode_flag(inode, FI_DATA_EXIST);
-			if (inode->i_nlink)
-				f2fs_cache_set_inline(ientry);
+			prepare_inline_write_begin(inode, folio, ientry);
 			goto out;
 		}
 		err = f2fs_convert_inline_folio(&dn, folio);
@@ -5535,7 +5551,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	 * and #0 page. The locking rule for inline_data conversion should be:
 	 * folio_lock(folio #0) -> folio_lock(inode_page)
 	 */
-	if (index != 0 || f2fs_has_subpage_blocks(sbi)) {
+	if (index != 0 || (f2fs_has_subpage_blocks(sbi) &&
+			   pos + len > MAX_INLINE_DATA(inode))) {
 		err = f2fs_convert_inline_inode(inode);
 		if (err)
 			goto fail;
@@ -5592,6 +5609,23 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	blen = min_t(unsigned int, len,
 		     folio_size(folio) - offset_in_folio(folio, pos));
 
+	if (f2fs_has_inline_data(inode) && f2fs_is_multiblock_folio(sbi, folio)) {
+		struct f2fs_lock_context lc;
+		struct f2fs_cached_block *ientry;
+
+		f2fs_map_lock(sbi, &lc, F2FS_GET_BLOCK_PRE_AIO);
+		ientry = f2fs_get_inode_cache(sbi, inode->i_ino);
+		if (IS_ERR(ientry)) {
+			f2fs_map_unlock(sbi, &lc, F2FS_GET_BLOCK_PRE_AIO);
+			err = PTR_ERR(ientry);
+			goto put_folio;
+		}
+		prepare_inline_write_begin(inode, folio, ientry);
+		f2fs_put_cache(ientry, true);
+		f2fs_map_unlock(sbi, &lc, F2FS_GET_BLOCK_PRE_AIO);
+		return 0;
+	}
+
 	/*
 	 * Flush the cached IO of this folio before touching it, especially
 	 * for the large folio prepare below which reads and updates subpage
@@ -5700,7 +5734,8 @@ static int f2fs_write_end(const struct kiocb *iocb,
 	if (!folio_test_uptodate(folio)) {
 		if (unlikely(copied != len)) {
 			copied = 0;
-		} else if (f2fs_is_multiblock_folio(F2FS_I_SB(inode), folio)) {
+		} else if (f2fs_is_multiblock_folio(F2FS_I_SB(inode), folio) &&
+			   !f2fs_has_inline_data(inode)) {
 			f2fs_ffs_mark_subrange_uptodate(folio,
 					offset_in_folio(folio, pos), len);
 		} else {
@@ -5727,7 +5762,8 @@ static int f2fs_write_end(const struct kiocb *iocb,
 	if (!copied)
 		goto unlock_out;
 
-	if (f2fs_is_multiblock_folio(F2FS_I_SB(inode), folio))
+	if (f2fs_is_multiblock_folio(F2FS_I_SB(inode), folio) &&
+	    !f2fs_has_inline_data(inode))
 		f2fs_ffs_mark_subrange_dirty(folio, offset_in_folio(folio, pos),
 								   copied);
 	f2fs_folio_mark_dirty(folio);
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

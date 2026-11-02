Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CF7606A33D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OcmpKHLA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dav4avQx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mQpFpw9N;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XWTH5Z1H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=N4pPH8ZP2DWdNQRL11eeRv8bntM6Y/y8R65mDAuLGXM=; b=OcmpKHLAwk9HOv5ODP2xCNqMut
	wUp1oofqGBS3a5pAJ4Hmt1Hlk76Pb/5N34U2jVxkEG+AHqqberT3YvOn2It7jGrlMdAu5+Hnv4JmX
	NumWXOlW+RLSc/Q3O3KK+aEsP+8rNeGNRDUYM97rhQ25anMNSPH2NZDb9lGnupCZ2ySI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNxu8-000000003XA-0wuI;
	Mon, 02 Nov 2026 19:41:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xNxtk-000000003Rk-0fMf
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/OMHA/5duEqXXG8e2OhiyICgmgVvLKQ6iYWKm0v5+Lk=; b=dav4avQxawyryDgVhuoMKcBpE5
 4YcqMpHIrqemq2T1wT04WT/C9phwZZsiTBaVzdUiSAOIKyz+iVq2TCVytchj1bpnGIxST/vt6pq2/
 VOS6dbMSPjLcNJI+mQU/5egM2aveIIa8bGCj+zuJiof1aQ/+kuy4x2HuYu5TtK2eLiq0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/OMHA/5duEqXXG8e2OhiyICgmgVvLKQ6iYWKm0v5+Lk=; b=mQpFpw9Nt6IMVk6GYV4X/qpP3H
 lYlUWAlYlGxwC7nqdGGBz7hH01tvxWEZrDDHA3uj6Ml9m+MuEQ4KYfdi8pMILavJcDsGCXEH/PrLn
 geQQCD0cn+jDyZa2Y+N1i+VYbEpz6+T1fG9g7EknrhSjihodF4p8bTORA+43zAd71yrY=;
Received: from mail-pg1-f180.google.com ([209.85.215.180])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNxtb-000000002E5-0fRs
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:44 +0000
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-cdb1199bfd8so1001330a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 11:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793648437; x=1794253237; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/OMHA/5duEqXXG8e2OhiyICgmgVvLKQ6iYWKm0v5+Lk=;
 b=XWTH5Z1HiZqgEYIpnweQtzamd6oYfvERNMsdDtHYs14C0hTDfGX3cYskaP8hRAiuLf
 M7pwXLeQIxgKfZ/zKGfdgWd8tTYxBiFTCgAaUyfUlJXsG0Rzqt3+guKpZNWjULGLqLpa
 3DUjaEIGmezkJFgol39AXhyPom30icAlUePtDml/o2cRXx5nKLMj/C3UkWcxt55msdIo
 7/jOL7UYrBOP/WNWEmVEJXrNox8jbJR/DZEuTV32eqqXMwdd5jR0rmbD2mwD+5RDOKrj
 yuGsVL0+WVG9sWbfAJ+9B2HGFL6+vzfwHjlxq2IbWFZpfdNMixWU1Z/+pZ0ODc/eqMzj
 ItKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793648437; x=1794253237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/OMHA/5duEqXXG8e2OhiyICgmgVvLKQ6iYWKm0v5+Lk=;
 b=F42b32YWy1BpTCt+Oz/jqND275lp0UtWHF8MFLsQ1qSPJvh7rxsKhMjRG7tjCulMA5
 kGAb7jfjTBt1XNztdnJUvmOTwuSHm/baX6Gg3hJMweCh3nTNyTgQhGQg/tUYUV3aV/hj
 VSEJvMUg/651SP+IAWgvbVHl1cwt2FsAhQPzNhy9+mteupPetktaw8kYdfBHYrT7qvGR
 THxsJKnmxv+RuUmtXU6pBa/oV5HcguuYm/yESCJU+BwNXplTmeWAcYeilqKTMDDQng5q
 2Qful4AgViM/lNpbS8ikVhvcOPVHgdRxFy9NdBcHiRO0cagsQzRyd2GupeBlVD9AHNwm
 tGdw==
X-Forwarded-Encrypted: i=1;
 AKwUvBznWXjtFTFwP8ME2t5uzjptT+rycYxl/wOJcWWzhvxe4VJ1kCfHOKznko2MTFOaIoBVn1/cgK1RxqxHmI13jy7l@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKVvhmFO5YfSdtEy+/fz5UZkkTrwrdZvTssBf4FzFjCqmE8B3iK
 1nXiSJYEC1JMV1eJPSeTZARYK/Pac3Sg/g1Mha6o/++nsR0y0Tgyi24cz4ynyb4D
X-Gm-Gg: AYBFou3kiftl8+wAAhIQs/Os9bSk2bJMZddEAkA2lyXyw/N+2KMheZ0thyw7LIuZU/V
 msmW+xWXVraCj6YBdGXmznAnMtG9JpMoLFDuv/hHcBmXudMYp/QaPriwund+/rcZufypHLwqR+b
 Lsr5+MTwxVM9EIUlYSmmUKKe6vvwNNExqyySY6o7AuC0yNlINT9sO8DVCl/67ktl+PNFOxXd1hz
 YRhOx1XEc+oSHnFre0IkUDN8NMVYJoD3XVFuySMnRu6wUEcrqvWc1anzuhjGCW7dj3FLM01k/zq
 IXm31nU1ExpjJtbzUutrc8fX3/mDEOpYYTfHShuy8xXbioNwAKzuvbX4vnJbIThM+J1T4XiG4WX
 99l9tgzuukCCWiq7XH7hQ21wy/ixYXRdcwJ6t4svV4kKgOUCdZY7YTE1JR0zjxH6BGTK3Tz/ow7
 DMCEt0TCbQO/StQ2eEM6ZJGCyCLvp0bB0D13Pp0+eC3YRp4DzwkARhBNX35sW8dWnj49UdAGJv2
 Rtvr21Abl65wbqueboT/GNJTPbeQ+8zu2IAdGgy38C8g48mMJkH0fHQJNNtReCnXUYuwgPfXLky
 vjhG8aYr5HXZbrQQliZRgPqPg4h1+vKFyCisqeUxFBEbq9CsH30iF52lqdf+RNBHDrJksg0U9RJ
 GxA4Zu2TQ2lP+OAgQ/AObOtT/ogN8kn6KHhVvWKW3lJw9A7xJj0Mws9Jqc3onZ75KCvc=
X-Received: by 2002:a05:6a21:6190:b0:3e2:6825:beec with SMTP id
 adf61e73a8af0-3e928df4bbamr9908575637.19.1793648437422; 
 Mon, 02 Nov 2026 11:40:37 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb364c48d4sm241826a12.27.2026.11.02.11.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:40:35 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon,  2 Nov 2026 11:39:48 -0800
Message-ID: <20261102193952.3002018-17-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261102193952.3002018-1-daeho43@gmail.com>
References: <20261102193952.3002018-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xNxtb-000000002E5-0fRs
Subject: [f2fs-dev] [PATCH 16/20] f2fs: preserve inline data in subpage
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
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
f2fs_write_cache_folios().

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/data.c | 59 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4e4d1b0d6004..a7cc7231b572 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4732,6 +4732,21 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 			}
 		}
 
+		if (f2fs_has_inline_data(inode)) {
+			err = f2fs_write_inline_data(inode, folio);
+			if (!err) {
+				f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
+							folio_size(folio));
+				inode_sub_dirty_blocks(inode, f2fs_blocks_per_folio(sbi, folio));
+				goto retry_out;
+			}
+			if (err != -EAGAIN) {
+				folio_redirty_for_writepage(wbc, folio);
+				goto retry_out;
+			}
+			err = 0;
+		}
+
 		folio_start_writeback(folio);
 
 		/*
@@ -4913,8 +4928,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 	account_writeback(inode, true);
 
 	blk_start_plug(&plug);
-	if (f2fs_has_multiblock_folios(inode) &&
-	    !f2fs_has_inline_data(inode))
+	if (f2fs_has_multiblock_folios(inode))
 		ret = f2fs_write_cache_folios(mapping, wbc, io_type);
 	else
 		ret = f2fs_write_cache_pages(mapping, wbc, io_type);
@@ -4981,6 +4995,16 @@ void f2fs_write_failed(struct inode *inode, loff_t to)
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
@@ -5034,10 +5058,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 
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
@@ -5454,7 +5475,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	 * and #0 page. The locking rule for inline_data conversion should be:
 	 * folio_lock(folio #0) -> folio_lock(inode_page)
 	 */
-	if (index != 0 || f2fs_has_subpage_blocks(sbi)) {
+	if (index != 0 || (f2fs_has_subpage_blocks(sbi) &&
+			   pos + len > MAX_INLINE_DATA(inode))) {
 		err = f2fs_convert_inline_inode(inode);
 		if (err)
 			goto fail;
@@ -5510,6 +5532,23 @@ static int f2fs_write_begin(const struct kiocb *iocb,
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
@@ -5618,7 +5657,8 @@ static int f2fs_write_end(const struct kiocb *iocb,
 	if (!folio_test_uptodate(folio)) {
 		if (unlikely(copied != len)) {
 			copied = 0;
-		} else if (f2fs_is_multiblock_folio(F2FS_I_SB(inode), folio)) {
+		} else if (f2fs_is_multiblock_folio(F2FS_I_SB(inode), folio) &&
+			   !f2fs_has_inline_data(inode)) {
 			f2fs_ffs_mark_subrange_uptodate(folio,
 					offset_in_folio(folio, pos), len);
 		} else {
@@ -5645,7 +5685,8 @@ static int f2fs_write_end(const struct kiocb *iocb,
 	if (!copied)
 		goto unlock_out;
 
-	if (f2fs_is_multiblock_folio(F2FS_I_SB(inode), folio))
+	if (f2fs_is_multiblock_folio(F2FS_I_SB(inode), folio) &&
+	    !f2fs_has_inline_data(inode))
 		f2fs_ffs_mark_subrange_dirty(folio, offset_in_folio(folio, pos),
 								   copied);
 	folio_mark_dirty(folio);
-- 
2.56.0.317.g454f8302e1-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

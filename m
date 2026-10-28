Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B37B606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HpdlkzuI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EVn+Fz/D;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hyjlSYjw;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JjhjX+9Q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=JmS189bXYGeDuMVbeW6suFAER8y7QyIeZ/31xhlzSQk=; b=HpdlkzuIWTM+KSZoSdaVwm9U2f
	LJN8ZGsN9MiuqyyyJfWdv/aHgbeXswy5uDfOyPlBOYqsuSxPQFg4Q6f/S7FS+pZP44LtQ63zg6iu4
	ksqFLNUiGRMjde6DufARg3CLVzodsQh/l+G2T9P1VpmuhD1oV1Aeh59/PV/3krDV52Pk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xM5q7-000000002pz-1VLT;
	Wed, 28 Oct 2026 15:45:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xM5q6-000000002pp-05ef
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:45:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pnvm2ffQ47kEKQYG/Jpzm/e4KWcDnVu7ijOSI5382Wk=; b=EVn+Fz/Dv5SU8a6VSuI3tl4lBp
 ikqLkXTBxMbP+WeESPeGcBiZcETst6KkeJf0yBQKQjTDR/aeNhrJYaoptR15KEXF1rwvKyKCvMSk7
 5+/Ke4hpqS2Pw5KDPA3dxslawcrVbLiniwinjNLt0GcAstiNRjJS+Cnpl6leJqpOs1l0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pnvm2ffQ47kEKQYG/Jpzm/e4KWcDnVu7ijOSI5382Wk=; b=hyjlSYjwNdtUZpaypm63dB9/C2
 TRo/47RN4TngSoNGQ/mKez5ZjEaokBl12Nkaak5E5DfFM86nUPdCXbF1IL9Ds2osoR79WxjUkNmUG
 1PpQm9dnym4+xSCH0nMSGq3+rPdEYRE7TF3LLCV2uq7oVQ5FAhHvTcXqiumuaZ2WLydU=;
Received: from mail-pj2-f7.google.com ([74.125.227.135])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM5q2-000000003ap-1J0o
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:45:21 +0000
Received: by mail-pj2-f7.google.com with SMTP id
 98e67ed59e1d1-3ac63aee1ecso304089a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 08:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793202312; x=1793807112; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pnvm2ffQ47kEKQYG/Jpzm/e4KWcDnVu7ijOSI5382Wk=;
 b=JjhjX+9QWHqhKqRPCvBTmOB9fM9ZmZWWOtg8ensb8uEDSrWl7Jne/kIe/eVBVx6jHM
 Pp5ec3jXGdtFVthrY5ZzdktlnIDQBngODXYvOI8xGkXt8QlpqHGtKKNGgUP5l5mqVNkf
 0N/MdIU+m/1NcFJRA3mVP6X7VcAGUwRPq0IvwQ/5USkXbbkCNv8lH7IT5eFnEnny4M2l
 vGmwqdSwn0BmmyuiRp4CAwWu9EBNgPeCsZbN0PFXzyadMBIlFYYV5qwPh1jVah0sWqGI
 75UiMS/aBRuMuS0ouiO71mdqhQdmSy0jhesYkGXrjyUAJJYRb8jcEv/mGeqDb3aKxZ+o
 46Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793202312; x=1793807112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pnvm2ffQ47kEKQYG/Jpzm/e4KWcDnVu7ijOSI5382Wk=;
 b=E1IbjzNXCaUZSj6f6Ch+Ppx8MY3ZsuDlepSIsDAshssCwRrrBuQBA7fZT+bQ5xEsvS
 X8wxE0wgkWC0x9oXz7xpGM7X/OuBCzjfTGzmePj+EiPQpG0NhGDUbml2vjeAudGcM1Ks
 SRdCC8u//35vYDygrfr4AY7d+AK3f5tFi1aW21HWWWDlWZ5zUm4fLMv6WCCdjPv1Tvnz
 VsiKf/7xWPdYQMQqAWlqllbrdrdcNHZTxq6bStQ2/eRWvDFQakugZXQH+sl1WbK9kxjs
 HFjYFOrsbAhcXyYrHfQr5vkHJtT9js4tQ3ek8P0TpHWtTdpnFdeca0vC0IXDZyLk+xSZ
 Nhnw==
X-Gm-Message-State: AFq9FYINprA5FpkUkDDvKQ6FAsDCSgBhDNMhdI2Yr11Uw/AQMMUXhD0P
 sp5R726SEOw434O0uvNaMb1xHpZ0k3noyyIzHXcjOM4AYaXcNQ6MRkbxr6iEOyTJ5KE=
X-Gm-Gg: AYBFou3JPP+AkE7gNn0dYHr6mnFAjAO1g5m2ASso/rlaMP9pRxbRMZt0kkG6VSz2sAV
 Jnr39x/n4ebOE6Cr0UA306Q72k1OK8hnZeMvjuXdakZxW0OWoLMGOwjsM9k8oELAIxFKGi8ifa/
 Nzhkzx1l6094mh6hg/0jNyyxxsgC/jKtTVSsklp1P+hnKb8/n9zNR1JCIzbCz9S73kvBOv8MJmW
 4CHZzT6D+FMW/R8DWXcnvoG4StIFk/QBN/WT4fKTwVWGxO5bR3TFl692/GvyCINPlHZiF0N5u8H
 gatBRPXrz3ArfscO674CVGQV1JoLoIthpIIIGyAWOEAa35G/hK2ikKFKlbElIo7LBy2zmvXtFfB
 nU8LGe/suw93V0BlPWShZR/UXxbVgU6Wj89NTisxdJwAoTGoFyxnq0ZJ54q3nKt4NlsEVU6j2I4
 pXqKuVvkK8R0Y1oeilB8QE/w1syLT9YGJlxRsCQ//5mPNoOHQzHciPi7TcQkn/hcf1Ed4PIPqlh
 cHJd4bj21eFRlg24SrXsD01sdOh3aLjgQH72me29K+rm9XU/58QbEpHSAMA52yNkwJmSrMv76bh
 p3wUx8D5jxEBo6eYZEuKcoAv/Jbx09/0EiMQa/exxXRmpDZyWmc85CpoOdZh5uZBDUc=
X-Received: by 2002:a17:90b:3810:b0:3ac:b08a:ed2c with SMTP id
 98e67ed59e1d1-3ae5822fb8amr2110195a91.40.1793202312214; 
 Wed, 28 Oct 2026 08:45:12 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6be5105sm24111655ad.37.2026.10.28.08.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 08:45:11 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 28 Oct 2026 23:44:02 +0800
Message-ID: <20261028154407.1601430-12-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM5q2-000000003ap-1J0o
Subject: [f2fs-dev] [PATCH v8 11/15] f2fs: handle partial truncate of large
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
index d76038d82e16..16775df79212 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -410,7 +410,6 @@ static void f2fs_ffs_put_write_pending(struct folio *folio, unsigned int nr)
 	if (folio_test_writeback(folio))
 		folio_end_writeback(folio);
 }
-
 static void f2fs_write_end_bio(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi = bio->bi_private;
@@ -2977,6 +2976,41 @@ static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
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
@@ -3754,7 +3788,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 
 	/* This page is already truncated */
 	if (fio->old_blkaddr == NULL_ADDR) {
-		folio_clear_uptodate(folio);
+		f2fs_clear_truncated_page_state(folio, fio->folio_offset);
 		if (!f2fs_ffs_has_dirty_subpage(folio))
 			folio_clear_f2fs_gcing(folio);
 		goto out_writepage;
@@ -3906,12 +3940,31 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
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
@@ -5473,10 +5526,41 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
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

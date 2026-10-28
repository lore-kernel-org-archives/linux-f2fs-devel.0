Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C0C60A382E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NEUqgdYs;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hr/7Z2Nh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fO2GRSRP;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cZ9FHHyW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=UTnvvjOMm+dtb3MCw52ARUZk3o53zHEsreEyISlUFk8=; b=NEUqgdYsWPDWw68Onds6m7DDCN
	XLpfmksLe9RV2YBMgZG9g3n7xmgPwyQ9paUVfzYGEXmzvm/UAVDCk/apL8tKVHhB2/m0K2D8tnBQY
	6d+rzYgc1nWOMwYXrmBr56bY3izEPFzrgcD4Keni/FgAVfQwm1HS+02JsjCwj+af++QM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xM5qB-000000000xa-2AVI;
	Wed, 28 Oct 2026 15:45:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xM5q9-000000000xS-1PWS
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:45:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7s2V/JSFPmAtncKl1XH2cagAkIbveg/MT0dKEEuJMwc=; b=hr/7Z2NhviMYKprAhq8TEWi8GP
 DAq/NhTtbP7laxBkFTzInLBG0zvyLwBQlOlI7vY27gNwoBnKeuvXD3AZ5nrkKtZFifRI8NvzOEYYP
 y5HYxXKvhEwllFfeD4rtoSqSBhF9iUmPDa1guYZL+S5tD6Ew1PqxjG3CxzU8N3OCcKJs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7s2V/JSFPmAtncKl1XH2cagAkIbveg/MT0dKEEuJMwc=; b=fO2GRSRPVF841NJ5eK1PLpd7tN
 yaWZYyzz7khxKHnunFvTjgBAzXpIpRScqKI9wZKfx3zdkVJ3aU7RSM9/AS7E9rJLRmf5BRwC2Fgnc
 uGe+PPsMmJBDiBwGPZI73ulPXDe+vlqmsrrgGIEGvSR1Kt2TQ49x259KTX2loY7KyyhE=;
Received: from mail-pj2-f2.google.com ([74.125.227.130])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM5q7-000000002O4-1MiX
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:45:25 +0000
Received: by mail-pj2-f2.google.com with SMTP id
 d9443c01a7336-2e613f813b0so3057845ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 08:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793202317; x=1793807117; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7s2V/JSFPmAtncKl1XH2cagAkIbveg/MT0dKEEuJMwc=;
 b=cZ9FHHyWTWK2CvX9I4QhDNPaa1jcU8kFjJy03BHMOyMcGfKI9tq0qEFRXmdiO08EUb
 2q63hGYlxSGXBJICOvxaChycZ/M/+FlSJ6cAmO922KQEpEvo8cgfdGCK2XOmIULfKl9R
 hsPfRgfsNLfAhyi8Lmth1nbBDEjp2NJwTjY4PNIOHLvDepx62Z/NRYDNMEVlqxAd9yqG
 dL4zHAKhM7q2E0itGP49hyhevkha7OxZ8WQs18mrMom7II9LnK5JIGEUV8X65u5XgSIk
 0YEaQsXSGs8/NSB6wsj0EHMYjRtZ+6ubqOAfaMbUHKuIKrx2CV27pjvvsCwK6mm/wlJC
 nyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793202317; x=1793807117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7s2V/JSFPmAtncKl1XH2cagAkIbveg/MT0dKEEuJMwc=;
 b=U6e6BYIWu6s27IHPHEqJY6oyDM+Gggmhav86h88QhhrrfmL/RYSVz9WIxkJWwmmIQV
 eq6yPUiG4EpBMRjKr9MG5v2ZtHh7oOz1WXMXy23soDCs63O4HBLVybK4zLw14R+DoI8a
 XU4fHN4gRJmjskJjYOLb03Zspv7x3fEnOManoPWB9lM1OtU7DGAfsfx6WgrA5q+JifS6
 khUlQnXhlmwg8G1lMa8RFrBEjW/bUcfUjxomuuNJi19PRFl66Lv1x7l9DJRK4MyOcyf/
 AwkH1KkI+gcRHx41xzmjzLbARIy+/G0DZ/+QTapQE/atUcrPOmmXQUIzzeJWJefH2fSp
 Z5bA==
X-Gm-Message-State: AFq9FYLJwg9dm+ys0m6TnqMCIfzuiF4/07jXG1YPfsYhEV90hKM0r/Wu
 tIjHYNnD6C1+aJsxzeWlf/TiITZEiqQN9w+E2p0huhsboOdaHO8qkK5YVzxBZymX5f8=
X-Gm-Gg: AYBFou2fGP5qYazpHM+8z6raBav0eGEtizRhphLjK8H9Ai2xn+3KM8D9tVFFtRMCJmW
 lRr+NuA9iFKddTGSyd846HRettGTY+kFVW8Eekm2g99+WyNA6+O0A0yvx864h8KdHqxps+VEqmv
 fi5FnKORZZ2MtpVPW+VXt8UFzvraLQUMWMKzAcTK2zsBcJMBZVn8GMBmbYvtHOPkE7Y6vwcLx1G
 AOUV7HbiFyMsgNCFEIeJQD9DgO9moU2yNO/65cgha1MoeD4IN9PK4dJT6ieMpo3PEgKuPRuEdEG
 bfIrAX4qLEa+TCx5tP5h95i+WttBiwXnv5W96hCvH3nD4jgEqPX3CWvVB1Ta7CafdWyzXVFr0Ub
 I6FGPu41J577S4Bz98KRw3Ycuutw7/fyNah3n91opdlYJbWw+ULEpkIZxSyGXCLCBZCQz6DN3ns
 uZTl9+Dl1FyGur4meIoYLAMiBZ42O/gcMFwgWjmUKjSpYaQ6KDj8kuWf2E2A4a4xFPNLVf9VLOj
 gOoofe1FuSh4gyil8ipga1HfWe4+qxYXhs0Ia0c8mwwsb8AFIcXp7xdhugl9W1h/UD9cmxvPeUT
 V0EsX9H7zF2DLBxIKZ/AQ9ZXnt17Vz9rUCwPwe/OBEAL8PInzHSnmLyftIgO71KaYw4=
X-Received: by 2002:a17:903:ac7:b0:2e8:81e2:1d42 with SMTP id
 d9443c01a7336-2eb0753fdd0mr10397185ad.39.1793202317085; 
 Wed, 28 Oct 2026 08:45:17 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6be5105sm24111655ad.37.2026.10.28.08.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 08:45:16 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 28 Oct 2026 23:44:03 +0800
Message-ID: <20261028154407.1601430-13-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM5q7-000000002O4-1MiX
Subject: [f2fs-dev] [PATCH v8 12/15] f2fs: fix zeroing paths for large folios
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

Several f2fs zeroing paths still use PAGE_SIZE based offsets after
a file mapping can contain large folios.  This is fine for order-0
folios, but it zeros the wrong range once the target block is not at
offset 0 in a large folio.

Use offset_in_folio() to translate the file block index to the folio
offset before zeroing data in truncate_partial_data_page(), fill_zero(),
and f2fs_get_new_data_folio().

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 18 +++++++++++++-----
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/file.c | 29 ++++++++++++++++++++++++-----
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 16775df79212..da54fe425f78 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1861,6 +1861,12 @@ struct folio *f2fs_get_new_data_folio(struct inode *inode,
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
@@ -1870,13 +1876,15 @@ struct folio *f2fs_get_new_data_folio(struct inode *inode,
 	if (!ientry)
 		f2fs_put_dnode(&dn);
 
-	if (folio_test_uptodate(folio))
+	if (f2fs_ffs_test_blk_uptodate(folio, index))
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
 
@@ -2953,7 +2961,7 @@ bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index)
 	return test_bit(idx, ffs->state);
 }
 
-static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
+void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
 				       size_t len)
 {
 	struct f2fs_folio_state *ffs;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e20805d4a099..412053e1e507 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4491,6 +4491,7 @@ struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
 			bool for_write);
 struct folio *f2fs_get_new_data_folio(struct inode *inode,
 			struct f2fs_cached_block *ientry, pgoff_t index, bool new_i_size);
+void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset, size_t len);
 int f2fs_do_write_data_page(struct f2fs_io_info *fio);
 int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ef9b9baa1a79..36258d401818 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -846,12 +846,13 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
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
@@ -869,12 +870,22 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
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
+		/*
+		 * The folio was read back above, so the subpage is
+		 * already uptodate and dirty data stays valid.
+		 */
+		f2fs_ffs_mark_subrange_dirty(folio, folio_off,
+				blk_end - folio_off);
 		folio_mark_dirty(folio);
+	}
 	f2fs_folio_put(folio, true);
 	return 0;
 }
@@ -1338,6 +1349,7 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct folio *folio;
 	struct f2fs_lock_context lc;
+	size_t folio_off;
 
 	if (!len)
 		return 0;
@@ -1352,7 +1364,14 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 		return PTR_ERR(folio);
 
 	f2fs_folio_wait_writeback(folio, true, true);
-	folio_zero_range(folio, start, len);
+	folio_off = offset_in_folio(folio,
+				   (loff_t)index << PAGE_SHIFT) + start;
+	folio_zero_range(folio, folio_off, len);
+	/*
+	 * This subpage must be uptodate here, which is guaranteed by
+	 * f2fs_get_new_data_folio() above.
+	 */
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

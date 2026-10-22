Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E415D606A319
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fYrW24hg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KMYXE0/1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kuBAwXek;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IxsccwpF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=cUwI8vHYcFUdWJ0+DXTdG9IxBiWU98M5Xk38LR49RMc=; b=fYrW24hgREZ2Rean+qMK6U+bih
	nM9+qb7iA5o/UkHMeyIu4K3nY2if1FIYbzq33kvI0gHDMdTR9ddOikWkOSMYdRTfBKOOkoIl1LRVu
	oxC4lTtKKTlVzpiNgRWdIkov4vwYCHbntVC2y/2sUmpsffyYNSPJq1+BgwYVrGP0CTPY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJndR-0000000072G-2e0t;
	Thu, 22 Oct 2026 07:54:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xJndQ-00000000723-3kL0
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:54:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DcsfVmg9lqhQkDJnOn8GHeE1c/RlJPp+Ost5Rs5+0vQ=; b=KMYXE0/1agdSKCfwVAl3bfPARy
 nXZ023u3BPTylf0O8maoB6y3l9mMygixQJdsTZuYqLxYc3Cbmj3TBPVeklKSPrP0ArRbkM5n5UXbh
 mEyTPskXGaz7tUknmEGu4UgAXrDyR5ZM8CXg5bODdglNbwkU5e9WCWSropsPRGNMOnjQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DcsfVmg9lqhQkDJnOn8GHeE1c/RlJPp+Ost5Rs5+0vQ=; b=kuBAwXeku0vByH0J8PVb4dzTct
 IkjtoCQRMSlXkDC+VM22LpFZ9pGll8mVqLi1S7RgGynWCj0aJj/EV6btJ7o0tpb5f7YvaE5W39U2y
 gKx3Y5OAoFQlUFfJNmOHfHSjssJlbDoytmoVJfucbV6YPyI4yuoXuU2pk+0EPVV29Dls=;
Received: from mail-pj2-f10.google.com ([74.125.227.138])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJndO-0000000051A-2lVh
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:54:48 +0000
Received: by mail-pj2-f10.google.com with SMTP id
 98e67ed59e1d1-3abe4821449so840148a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 00:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792655681; x=1793260481; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DcsfVmg9lqhQkDJnOn8GHeE1c/RlJPp+Ost5Rs5+0vQ=;
 b=IxsccwpFa3CdtUIci0kHPnuvx6TJtyasCBHP4XwFXEV//muCbWcQccEla/4g2lCq0F
 yBie818AjwlvDWCc+JPWN8KroqZgkXY7XrYzztmlJn1nTCVkx7o1/4ZaXSzGvGgszkqe
 2O57y3N8I1FZzzYppnJ/6EYJk5ro+dvX3B6nlbVRjTOmNLbx7wzmDKZ2dFIiolvJORfD
 QZlJnRyBWN9PSW4ldnx49LL19j52M1mrbMnCELhmL2jOXecaFnePuo/ermwNLZH880A+
 ZUAC/Ymq6xfQWbb6xys4Q7c5XmkQ0CVzvE0nPxNdYVU2aNWVOjVhcJysfqkhFt/QXDQ8
 TjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655681; x=1793260481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DcsfVmg9lqhQkDJnOn8GHeE1c/RlJPp+Ost5Rs5+0vQ=;
 b=XK993dQWgdBclJg7sImz4j5DBTLF8oPVDfjBB00Cq1NdkRxSW3sWYZBcxZf/h+uDVp
 XPcDRYeN6WAYv40eGWTAs1d0f/LBB6L+r1CSLrLkPB8MELD+oXp1naZL1hnELr4VQt0s
 38Ty5qIrfsjEntuBTKOrwLw7ATDs3lz5ldvQ3nZ4D5RJfSPuo3/Svn5kdWetXlwZ6ksu
 +qkmI5NmM5pIacZmX+8UyHbYIWCXAuOw255bjp1bdINL/xitFlHM8HcXRLnQaxL95NQg
 RCaxj9CvFiSaUX0bwF2zFH6W4tcQXSDd9uowOe2je99Zqy48HwBSgPy9PnHTQ2o00IOT
 I47g==
X-Gm-Message-State: AFq9FYK7iGoUNl8As8UdWl2kaPfMrAztEoFiHU4mY098LZyLh4NvIczK
 amv7wN0aHtmGhLfFpoGo7rJTRgRPvDg99hf6+FyJsAPOqdMQT8Qk6P/T3ztZMk7ZGoY=
X-Gm-Gg: AYBFou2bRRjRS2m3yUYOHvf4R2Hi3j6QevmeDUozNbtOlCSpaqV8BhroxYCT978LdWg
 rnxWLLjy32qAVsk/fLdJddnV+CeCDt8IluIFmvkuGaFXYBWUMVCwudZv0Eirm7o3yFRXJBd9raV
 Hvei7JAL8xUYv7/cfA+hv7b5VnXtib32SWCs+QHr1JMQDwUniOruOkLgJJFDAHzT2kOQr06MC+r
 x3pwuvIs2CrAYdiFHiMy0+fFn79A7ukVM7x5I3LqE6TF3VyVFUG0H8f4ZiQw1yzIEsxKF7pRukL
 RravthUjtc1CUNGSkwN603/xDEDd1/9U5W/RC4q6VJfiijIXclJfJ0ITPn/y6pNpgsr7hixvs3v
 9PkY9OvM5rkaK4HWrxnFnofaXLpopA6aHKcGZbUBJICcI01JrsQsRk8AT2sRBZZppxrenb8eOcg
 mBJKQbthhsbowOt24Cm6lsTVORh7DTvz9hAq0P4yX2KcPG6OuYfDzc9H8NS5YMpJgwf7vcl3UPV
 NWLCeaJsR9hmeQgnzuWlHHfFCBj7Fl2IeaVeykLRhC0rFqvKywGZGQJzqneEdzV486XWA1BJ1Zb
 YmSgG754GJmAneIDe40rA1WcvVGkqAcGeTFQRgk=
X-Received: by 2002:a17:90b:5243:b0:3ac:a7ee:6760 with SMTP id
 98e67ed59e1d1-3ad86ccdc8fmr3664564a91.23.1792655680945; 
 Thu, 22 Oct 2026 00:54:40 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada4896c71sm3202562a91.6.2026.10.22.00.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:54:40 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Thu, 22 Oct 2026 15:53:39 +0800
Message-ID: <20261022075343.3043003-13-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022075343.3043003-1-nzzhao.sigma@gmail.com>
References: <20261022075343.3043003-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJndO-0000000051A-2lVh
Subject: [f2fs-dev] [PATCH v6 12/15] f2fs: fix zeroing paths for large folios
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
index 24613b00f843..f71fb7c993ef 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1839,6 +1839,12 @@ struct folio *f2fs_get_new_data_folio(struct inode *inode,
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
@@ -1848,13 +1854,15 @@ struct folio *f2fs_get_new_data_folio(struct inode *inode,
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
 
@@ -2931,7 +2939,7 @@ bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index)
 	return test_bit(idx, ffs->state);
 }
 
-static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
+void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
 				       size_t len)
 {
 	struct f2fs_folio_state *ffs;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1b63dd961f15..2c9343eb6b5e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4480,6 +4480,7 @@ struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
 			bool for_write);
 struct folio *f2fs_get_new_data_folio(struct inode *inode,
 			struct f2fs_cached_block *ientry, pgoff_t index, bool new_i_size);
+void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset, size_t len);
 int f2fs_do_write_data_page(struct f2fs_io_info *fio);
 int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 808b72d3d78a..439e84a4aec3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -833,12 +833,13 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
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
@@ -856,12 +857,22 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
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
@@ -1325,6 +1336,7 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct folio *folio;
 	struct f2fs_lock_context lc;
+	size_t folio_off;
 
 	if (!len)
 		return 0;
@@ -1339,7 +1351,14 @@ static int fill_zero(struct inode *inode, pgoff_t index,
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

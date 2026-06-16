Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4D5CD98E1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=f5WW1vr+B70cz7eCKqz6N3GM+MoHEQbC7du0KU70xy8=; b=QPLizbuetUwcDatsPSkITMahul
	6yl3dksUpnz8JO8+Q21Je5v8C6BbdVU5n5xDqltJhwXnEfG9MKkE/GE+pR71CpPSzHg1KrrIdwikO
	DytuTSrsSYmtZZPjh0eW8RnC5OaBceJvoIvs2q0CimSlVuxKfkdQBGT53CfN8LGGF6hQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZTHZ-0008DW-GH;
	Tue, 16 Jun 2026 12:52:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wZTHX-0008DP-Tq
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 12:52:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6wTu2G7CFNDzyaij0dtf+dWTaSgNcLjr+WkVqdvLHos=; b=ht8vvNlM+lPE8jGRF9KdVhNPiV
 igNfyRQh15mOOthHOkk8pUuX9IoKTHv0irU1nN+ZqoNyOWXAoZWXU/hIO4r5RlavAPgukDYf+TAf/
 CmBZamuT3sZpOTDAs+kiIMuJJ8xdn7d6z2NlROBcTtP1EJ+YdBsglfPxEEww4S6scIBU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6wTu2G7CFNDzyaij0dtf+dWTaSgNcLjr+WkVqdvLHos=; b=F
 wzW96QXZc4TUvpZoVRYu9VfRSPmA3RyL0yaFxrf9+XarlqtuJSHXPFXN3YXfTSmptO9SgDeE8l/l6
 3UZwxRMW2xIXGn9l234sHQ9b6EyterYU+9G5vHMiwlJBIZj2gEm3U+28ovfT5PUFhrXtG9DOmJ+/q
 plJxcvq60WGCX3nE=;
Received: from mail-dl1-f44.google.com ([74.125.82.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wZTHW-0006UB-1K for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 12:52:43 +0000
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-137dd4cc208so2346271c88.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 16 Jun 2026 05:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781614352; x=1782219152; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6wTu2G7CFNDzyaij0dtf+dWTaSgNcLjr+WkVqdvLHos=;
 b=FxGKplszm7BqnLfzfzZ0HJFmbLtKQ8pq3+SfsETTISsbvzCAfeIryYlVvQ6bxheYEl
 JpRrtyl0VaK/89Zn+umI3QnjlYVYAmE7LoDIRs58SkHfBvwMNXFV84fgUuJLzN7GSuqD
 /CWPUxMprf5vV5EjUUy54pZpZrZIwt6dpE/BX2hcMhGD5fFn4bnguYapqsi1HEv1Smh+
 +fiyqEQx6sTZb+YX1Q36LpSldDGH/t+Jw+cugbmdqXInNif2YIETm55+WLnsv0sw6GU0
 EPBiM9eY5ZopnxH23DnVoXh8/l/CvZcJs4/IHghjvntgn3v3ZGwGa1y4rsGbB4IRYWh4
 6Wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781614352; x=1782219152;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6wTu2G7CFNDzyaij0dtf+dWTaSgNcLjr+WkVqdvLHos=;
 b=JSuRxrLhigPjxWpj40oVu2HPB+jcyWg0JulNTsdbbVFPnQXdT4N7UhNZ9CbFTvgtQg
 ZULcWVTNig6IzXLQ6cbjxe+Ip2YY5o6/kyqwfOHSLLBsBQp8ufMMBdnRtoQiNo68fZkV
 P+HwT2C8DO8OZHDnPpcYYWJQV4mW7EfAz2HgIcBHsoi2BRguS+fY44UG4qDzNbVMcoCC
 +laWRQ3PbSuyGka3/bLOvxyC4n+JItwjOMmP2Thy7K0+GP07xIF9K6i6sKVjlyx9J+u3
 wM0m6Yg4buvtGRxMvG1aeEyE2+T8ir+je90VBzUxzNg3ppTWBDF3+A+UL7CJnHCUNKPo
 NC2g==
X-Gm-Message-State: AOJu0YwpikJZZHBdrq1STHCXUVvDn7ER77+Em6GhgxLCAk4IRiXID4en
 aKAS6l5H0DxmHhsdmEheJf1B1sr9nJ6egrq2X7J7/Z80c1h2HvGoW6pk
X-Gm-Gg: Acq92OGluJUL4DSWUtrFggMJL1GX1TXRKJJ3u9YqHQsUGkPiHVjAZ8fXTVNQJCnTkZ6
 KZBTn4EBPXfvH1QVTf+nhIIt0RjwJbF7UkoywQj1Z3UYrowH09Qpev9OGN3zJodvE1B3HRMmpbE
 /r6Mefxho8ICNP1iAAEzyybcBfu3xCiBSvNhJxKMFd3kfW9KfUQC2gD2PZA803vhdKKQcOF8VoF
 RkAJAs07yNztyfwD7q9ZrHRpxXBLuXAoAJXVNKPEuIhvwVddD+Wu9GTuu6iSDHgtPNKJfnZCRV6
 zm0mE7ju/NZ+CUAR0XaYB5YZvMgmncivlyg5vAfuxnyzzGeHbMArpTXwZph5FiMg3ExYXBmSp4m
 pA2JpS2Uyl5CzQ/qajXJQcZaFQ2jSozs2AxuXnZER5T+iLkVjIB97OIYUQV2add6syrvhIiw4hF
 mweIPSNTdsY3rsgRAXsfx08ZBH+xFxmqYS50k0srTqzbCmPozXtJmOBaRgOTLwEedBXtuy/g==
X-Received: by 2002:a05:7023:b09:b0:132:c944:9ec7 with SMTP id
 a92af1059eb24-139857b99a7mr1717055c88.1.1781614351574; 
 Tue, 16 Jun 2026 05:52:31 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b8fbde7sm13299228c88.2.2026.06.16.05.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 05:52:30 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue, 16 Jun 2026 20:52:19 +0800
Message-ID: <20260616125219.1396871-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wZTHW-0006UB-1K
Subject: [f2fs-dev] [PATCH] f2fs: account compressed writeback by raw folio
 type
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
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Compressed writeback is always charged as F2FS_WB_CP_DATA today because
WB_DATA_TYPE() is called with compressed_page set.  That is wrong for
normal compressed file writeback; the CP guarantee belongs to the raw
pagecache folio, not the compressed bounce page.

Use the raw folio for the writeback count type.  Also keep one raw page
under writeback until the compressed end_io callback is done using sbi,
as normal compressed writeback is no longer protected by the CP-data
counter.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
QEMU/KASAN tested with compress_mode=fs and compress_mode=user, using
concurrent 1MiB compressed writes and a background sync loop.  The user
mode case also ran F2FS_IOC_COMPRESS_FILE and fsync.  No dmesg splat was
reported and fsck.f2fs passed after unmount.

 fs/f2fs/compress.c | 34 +++++++++++++++++++++++++++-------
 fs/f2fs/data.c     |  2 +-
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 91855d91bbdd..be9483b9a401 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1487,9 +1487,19 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
 	struct page *page = &folio->page;
 	struct f2fs_sb_info *sbi = bio->bi_private;
 	struct compress_io_ctx *cic = folio->private;
-	enum count_type type = WB_DATA_TYPE(folio, true);
+	unsigned int offset = folio->index & (cic->nr_rpages - 1);
+	struct page *last_page = NULL;
+	enum count_type type;
 	int i;
 
+	if (unlikely(!offset || offset >= cic->nr_rpages ||
+		     !cic->rpages[offset])) {
+		f2fs_bug_on(sbi, 1);
+		type = F2FS_WB_CP_DATA;
+	} else {
+		type = WB_DATA_TYPE(page_folio(cic->rpages[offset]), false);
+	}
+
 	if (unlikely(bio->bi_status != BLK_STS_OK))
 		mapping_set_error(cic->inode->i_mapping, -EIO);
 
@@ -1501,21 +1511,31 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
 	}
 
 	for (i = 0; i < cic->nr_rpages; i++) {
-		WARN_ON(!cic->rpages[i]);
+		if (WARN_ON(!cic->rpages[i]))
+			continue;
+		last_page = cic->rpages[i];
+	}
+
+	for (i = 0; i < cic->nr_rpages; i++) {
+		if (!cic->rpages[i])
+			continue;
 		clear_page_private_gcing(cic->rpages[i]);
-		end_page_writeback(cic->rpages[i]);
+
+		if (cic->rpages[i] != last_page)
+			end_page_writeback(cic->rpages[i]);
 	}
 
 	page_array_free(sbi, cic->rpages, cic->nr_rpages);
 	kmem_cache_free(cic_entry_slab, cic);
 
 	/*
-	 * Make sure dec_page_count() is the last access to sbi.
-	 * Once it drops the F2FS_WB_CP_DATA counter to zero, the
-	 * unmount thread can proceed to destroy sbi and
-	 * sbi->page_array_slab.
+	 * Keep all sbi accesses before the last raw page writeback is
+	 * released, so an unmount thread cannot free sbi while this callback
+	 * is still using it.
 	 */
 	dec_page_count(sbi, type);
+	if (last_page)
+		end_page_writeback(last_page);
 }
 
 static int f2fs_write_raw_pages(struct compress_ctx *cc,
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a765fda71536..1466a7825dc5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1092,7 +1092,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	/* set submitted = true as a return value */
 	fio->submitted = 1;
 
-	type = WB_DATA_TYPE(bio_folio, fio->compressed_page);
+	type = WB_DATA_TYPE(fio->compressed_page ? fio->folio : bio_folio, false);
 	inc_page_count(sbi, type);
 
 	if (io->bio &&

base-commit: 7cc48ead1a8a96f2dd1eabd87c2f22947dc84cdf
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

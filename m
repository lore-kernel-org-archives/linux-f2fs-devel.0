Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B060ECC6B03
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D7na5P0nI9QW9gP2tFX6qzMdaf3d/nDbFG1CACdXjKE=; b=Y1+JBkuj3+/wHr7p+Bjd4Tl8kX
	YbtYStx+iNeh8ntTjme/eJJmDb42rmR1COAYvWsrW9GRoAtTYN+rLtzDNfXCScbhSR+qkyIG8tBsB
	F3GigfLiIOZpCB7H5rjmW0QFeLNGR9cZF4QJDrjD54coNRZmdpnJK7tmRZJkS0U2or40=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGb8P-0002Fq-Rr;
	Tue, 13 Oct 2026 11:57:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGb8O-0002Fg-Px
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:57:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oZkECa2D/Ld14c/OJR1CbTK/ThR+UM78dn5n+j0wGE0=; b=VIUpqgWwPlFvxFS9uk2eQlRwSH
 P66x2o0dwIOpC2K48qWPZ7OT/veKiOb4p1pKa/oKEOWBAecrf5lA3PALYQwov8BnqMeL6s0nnyUS+
 FMWxvgyoYfq3umukJE90pGVbgOHiTZE2iv4HekH41ZijsinBivwutjkFt4AeZN74JNYs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oZkECa2D/Ld14c/OJR1CbTK/ThR+UM78dn5n+j0wGE0=; b=FuSyF800YTU8dVfUDrnZ6SsEbZ
 q+FrVjxxd+WO1R6iqOknJsuxK9TGiuUyAqSj6OwYWULPArf5Z742/QAjGHOMsA9fe31qvylIKpfzM
 4VjcCMOazbRi7ZbDc0oT+SpR6jaWdUTxUjTIy9NR2cKCtLUAWM8a03yq8hyIuRFqeByo=;
Received: from mail-pj2-f8.google.com ([74.125.227.136])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGb8O-0005Rq-59 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:57:32 +0000
Received: by mail-pj2-f8.google.com with SMTP id
 98e67ed59e1d1-398b9f722abso1434210a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 04:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791892646; x=1792497446; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oZkECa2D/Ld14c/OJR1CbTK/ThR+UM78dn5n+j0wGE0=;
 b=knVBA1tKNiEUDjctPEKd6dDS0sPTU7zJ3hrHXLOIp3khZ2Ml/12ALr4f8HAwpT9TLD
 gFFwgLHeTPTaSaxbb4Z8ybi9VRg0E64sAovbMGOTCjDSQyuJhP2tpwCZqP++GuvsmvkP
 Ku6JmeCuFk/mW1U0Jd1S0RRSXHCVNwSFL4iLDYkO758/3VCpeDgRgOsQ5yOKsvHeTRls
 21w4nBk/fkSUOLEfnOxLjPMPlx52b+37ka/Zl4YMtz9MrMoNkT1NkfborcJidrtpeChv
 ovJWK+BalXU6mlVGks3QHrwE33HYYVQveTTf4LM2fdWg+XzZ9FOnlrvOy4Tyc1QNPd2u
 ri1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791892646; x=1792497446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oZkECa2D/Ld14c/OJR1CbTK/ThR+UM78dn5n+j0wGE0=;
 b=VY7MRJhmlD9dBmfkISUB89WWiXFofVw+5Quyvdhqj8jBKh3W8lwP6UP7Nk2AoKWdb4
 m+RGNOqVjdjOd5anmF0rXtZSzAy5cW2iOFG1hH9f7j1+1ukf1DcD9fExR6gmh946jyT8
 ny4qx3dnBVKY502kxqQPENffYBdUVg+pwcjmGjuE6GORIFOTAlPxeBKqInGFB/x2z+H+
 Huig+H0c3K3GF2E8zYHhHKlzalcWL3+BaqEgSVUxCIdYQn9FFl8HajlfwbGtqqvyWL81
 yuqqoOXXKwt2+0M8nc4TB6BtvZYetyi01yjjFfGOtzo7DJUyM6h0ERhHNNOjbO7xVgSg
 kHqQ==
X-Gm-Message-State: AFq9FYIBwKt0u6E7B2PlztWoSV5k97GPfO7IyZ5/DRQIaNp8qaIRzSp7
 OEpfhZIF8+R83ror/hsl5+T680hRTN0xz4A0x7PGf+4Y0KwSjmpQ/rIOxg8IzJML9h4=
X-Gm-Gg: AYBFou0p/nH96VtvOEB9K8JN1pOdEGNuvO1nbvPIaf/E3E7gXDeB0FrlOhRC260eoiH
 a52/KlhOCJea6sO632XV8jJXa2FcPNPuMrbOJK+67mXVEMpG5vGjipCcBiYizZhF4iepTIdT9Fl
 /Z86+QJDA+cnWLwOqXa4jBMIDjGvHCT1vS4Le+8rq9db5+1wjZ+wQ5kLy69tzFnNJNcYM9hE+2n
 Tfu//jJYfnxOUYO6wEZg0e/UOcvPNLz+9GLN7Mj15Xy9hXmEKx56hp/kKC2Z9YEkS6u5FdHW2ZL
 dLdeyXXJhbMm/Uljjmip5BVv3UoMxLfjir6oPIVsg60S+CT0fFQ7M5W8tf1bTy0/ig/Ue20B166
 urq4EDmj/rPo5sBYMbQmUArQXExIqg9Mo/VZoGEKMbDTIpl6EOYkGoActb1MCAixzumRMrLxnVW
 8hYi8Yg/DZ5DGVKwJ3eg/MJYPAGHJ4b5jkyHyOleYx0GwoSHfwVs/cO8a/1mTo6/iIxHbl7dTTW
 1KJM4L82DhVCzTZop5CIZ25oPgCKRI6jjImVg7j2mMkf28=
X-Received: by 2002:a17:90b:5444:b0:39e:6a7e:ee18 with SMTP id
 98e67ed59e1d1-3ab3ad26901mr8688398a91.36.1791892646351; 
 Tue, 13 Oct 2026 04:57:26 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab37139b59sm21248516a91.13.2026.10.13.04.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 04:57:25 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Tue, 13 Oct 2026 19:56:15 +0800
Message-ID: <20261013115621.968742-13-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
References: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1xGb8O-0005Rq-59
Subject: [f2fs-dev] [PATCH v4 12/18] f2fs: support partial uptodate large
 folio read
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

Buffered write can have write bytes smaller than folio
size for cases when folio minimum order is not zero.
This can left partially uptodate folio in page cache.
So we skip uptodate subpage read in read_data_large_folio.
Also mark hole subpage uptodate in uptodate bitmap.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8b9a4788c..0c4c41871 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -148,6 +148,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 		struct folio *folio = fi.folio;
 		unsigned nr_pages = fi.length >> PAGE_SHIFT;
 		bool finished = true;
+		bool uptodate = bio->bi_status == BLK_STS_OK;
 
 		if (!folio_test_large(folio) &&
 		    f2fs_is_compressed_page(folio)) {
@@ -163,6 +164,9 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 				(struct f2fs_folio_state *)folio->private;
 
 			spin_lock_irqsave(&ffs->state_lock, flags);
+			if (bio->bi_status == BLK_STS_OK)
+				uptodate = __ffs_mark_subrange_uptodate(folio, ffs,
+						fi.offset, fi.length);
 			ffs->read_pages_pending -= nr_pages;
 			finished = !ffs->read_pages_pending;
 			spin_unlock_irqrestore(&ffs->state_lock, flags);
@@ -172,7 +176,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 			dec_cache_count(F2FS_F_SB(folio), F2FS_RD_DATA);
 
 		if (finished)
-			folio_end_read(folio, bio->bi_status == BLK_STS_OK);
+			folio_end_read(folio, uptodate);
 	}
 
 	if (ctx)
@@ -3109,6 +3113,57 @@ static bool find_next_valid_block(const struct folio *folio,
 	return false;
 }
 
+static unsigned int ffs_next_uptodate_subpage(struct f2fs_folio_state *ffs,
+			unsigned int start, unsigned int end)
+{
+	return find_next_bit(ffs->state, end + 1, start);
+}
+
+static unsigned int ffs_next_nonuptodate_subpage(struct f2fs_folio_state *ffs,
+			unsigned int start, unsigned int end)
+{
+	return find_next_zero_bit(ffs->state, end + 1, start);
+}
+
+static void f2fs_skip_fully_uptodate_front(struct folio *folio,
+			pgoff_t *index, pgoff_t *offset, unsigned int *nrpages,
+			unsigned int *max_nr_pages)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned int next, skipped;
+
+	if (!f2fs_folio_has_ffs(folio) || !*nrpages)
+		return;
+
+	ffs = (struct f2fs_folio_state *)folio->private;
+	next = ffs_next_nonuptodate_subpage(ffs, *offset,
+					    *offset + *nrpages - 1);
+	skipped = next - *offset;
+	if (!skipped)
+		return;
+
+	*index += skipped;
+	*offset += skipped;
+	*nrpages -= skipped;
+	*max_nr_pages -= skipped;
+}
+
+static void f2fs_truncate_read_extent(struct folio *folio, pgoff_t offset,
+				     unsigned int *len_blks)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned int next, end;
+
+	if (!f2fs_folio_has_ffs(folio) || *len_blks <= 1)
+		return;
+
+	ffs = (struct f2fs_folio_state *)folio->private;
+	end = offset + *len_blks - 1;
+	next = ffs_next_uptodate_subpage(ffs, offset + 1, end);
+	if (next <= end)
+		*len_blks = next - offset;
+}
+
 static int f2fs_read_data_large_folio(struct inode *inode,
 		struct fsverity_info *vi,
 		struct readahead_control *rac, struct folio *folio)
@@ -3153,6 +3208,11 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 
 		len_blks = 1;
 
+		f2fs_skip_fully_uptodate_front(folio, &index, &offset,
+					       &nrpages, &max_nr_pages);
+		if (!nrpages)
+			break;
+
 		/*
 		 * Map blocks using the previous result first.
 		 */
@@ -3185,6 +3245,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 			len_blks = min_t(unsigned int, nrpages, max_nr_pages);
 			len_blks = min_t(unsigned int, len_blks,
 					(unsigned int)(map.m_lblk + map.m_len - index));
+			f2fs_truncate_read_extent(folio, offset, &len_blks);
 
 			for (i = 0; i < len_blks; i++) {
 				if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
@@ -3203,6 +3264,13 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 				ret = -EIO;
 				goto err_out;
 			}
+			if (folio_test_large(folio)) {
+				ffs = f2fs_ffs_find_or_alloc(folio);
+				spin_lock_irq(&ffs->state_lock);
+				__ffs_mark_subrange_uptodate(folio, ffs,
+						page_offset, PAGE_SIZE);
+				spin_unlock_irq(&ffs->state_lock);
+			}
 			continue;
 		}
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

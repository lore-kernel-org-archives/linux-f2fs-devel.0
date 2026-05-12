Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DA7CD484E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 05:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1dCER9kujan8Ydzyd6zZYItmd2wepm9vPR9pCjOVzIk=; b=WSRvtalgyOJLoKQx1OHV0BVAC+
	sOsFzZR0OFjZJbY0ytdVe2aM1BIqu0c33633Vg/9aTle6d0cD7aFobgyRriJ9j8c2yjhjNCTP/DG3
	mTDhMHACKFmwpDeoJx2LAkcKWHZFV7I1EXWn4SOmytLkActi07HULkJiRJ1/GAf7kju4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMfoV-0007xC-Af;
	Tue, 12 May 2026 05:37:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wMfoT-0007x4-Pi for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 05:37:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ev7MltnomSEjjmIrAClD1smxf1HDQkp+MmOA2POEN6A=; b=A25JACWD54NGNT7ofxtaJWz27z
 Rmf3RuDzzSNq7F4zABpKl2bQcwG1RoknIOqwmC6FrRcB6tX9cmhT7ntte4CsWWrMjhw/bdtHlJMqf
 b0fyiKleWZZpPsXIsVksiOImUsRw/C1dcYsuUjgrnhq9QQWCL1zttK7csrbRJag91IdY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ev7MltnomSEjjmIrAClD1smxf1HDQkp+MmOA2POEN6A=; b=DXLrGnDj0iF6NbvAJwG3GsX4l3
 LUv0NuqPBRkFituO61WjtYGyVKjq37walY8f5NSCV72/LzRYDQf/xMBESamW7oxUbVIydqIPufw9Y
 mOA8mszZbxKqCCnoVgVZ0JPHuhlMdrQv3e6FUUhVZzaFvwbmOW32BOJReIIF11XhtobE=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMfoR-0004r2-Vb for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 05:37:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=Ev7MltnomSEjjmIrAClD1smxf1HDQkp+MmOA2POEN6A=; b=zOhBM88aoj3+RmnJTzDvDvX5oq
 9MzT6jc6jjaEccKxyQYyttFDbnopfvJYVRTvD8rnrI3Ljs3ORV4RDMFYqZF0hzK1GyoLlju8YU49c
 dnoc07+jiOkMGYudxEb756NG3xXZ2I4+ryFlzH/OCqMIE6PWkPy8ypBzQ2eo/PcP0REfgJB0rK+Ht
 Q1mnJjTvGTg1lgE6PiC2A4TxfqdYU4PRtOUemJ2/oREQHvCceIpP6h2RCBmZUElPNeD0lluN0F4ym
 3kmCUQ2sDP38uOsiipbmNekSLq9daxjQS9H420VZrcOfYp1xO+fG6rF3yDlpNsMTGI63uZXnHkWuD
 7UfSxpEg==;
Received: from
 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at
 ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wMfoE-0000000FfQG-1Tlu; Tue, 12 May 2026 05:37:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>
Date: Tue, 12 May 2026 07:35:24 +0200
Message-ID: <20260512053625.2950900-9-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512053625.2950900-1-hch@lst.de>
References: <20260512053625.2950900-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wMfoR-0004r2-Vb
Subject: [f2fs-dev] [PATCH 08/12] swap,iomap: simplify iomap_swapfile_iter
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
Cc: Paulo Alcantara <pc@manguebit.org>, linux-doc@vger.kernel.org,
 "Darrick J . Wong " <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, linux-mm@kvack.org,
 Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, linux-f2fs-devel@lists.sourceforge.net,
 Steve French <sfrench@samba.org>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

add_swap_extent already coalesces multiple extents, no need to duplicate
that in the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/swapfile.c | 104 +++++++++++++-------------------------------
 1 file changed, 31 insertions(+), 73 deletions(-)

diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index cf354fdfb7c3..a4e0ca462cc4 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -6,57 +6,32 @@
 #include <linux/iomap.h>
 #include <linux/swap.h>
 
-/* Swapfile activation */
-
-struct iomap_swapfile_info {
-	struct iomap iomap;		/* accumulated iomap */
-	struct swap_info_struct *sis;
-	unsigned long nr_pages;		/* number of pages collected */
-	struct file *file;
-};
-
-/*
- * Collect physical extents for this swap file.  Physical extents reported to
- * the swap code must be trimmed to align to a page boundary.  The logical
- * offset within the file is irrelevant since the swapfile code maps logical
- * page numbers of the swap device to the physical page-aligned extents.
- */
-static int iomap_swapfile_add_extent(struct iomap_swapfile_info *isi)
-{
-	struct iomap *iomap = &isi->iomap;
-	uint64_t first_ppage;
-	uint64_t next_ppage;
-
-	/*
-	 * Round the start up and the end down so that the physical
-	 * extent aligns to a page boundary.
-	 */
-	first_ppage = ALIGN(iomap->addr, PAGE_SIZE) >> PAGE_SHIFT;
-	next_ppage = ALIGN_DOWN(iomap->addr + iomap->length, PAGE_SIZE) >>
-			PAGE_SHIFT;
-	return add_swap_extent(isi->sis, next_ppage - first_ppage, first_ppage);
-}
-
-static int iomap_swapfile_fail(struct iomap_swapfile_info *isi, const char *str)
+static int iomap_swapfile_fail(struct file *file, const char *str)
 {
 	char *buf, *p = ERR_PTR(-ENOMEM);
 
 	buf = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (buf)
-		p = file_path(isi->file, buf, PATH_MAX);
+		p = file_path(file, buf, PATH_MAX);
 	pr_err("swapon: file %s %s\n", IS_ERR(p) ? "<unknown>" : p, str);
 	kfree(buf);
 	return -EINVAL;
 }
 
 /*
- * Accumulate iomaps for this swap file.  We have to accumulate iomaps because
- * swap only cares about contiguous page-aligned physical extents and makes no
- * distinction between written and unwritten extents.
+ * Report physical extents for this swap file.  Physical extents reported to the
+ * swap code must be trimmed to align to a page boundary.  The logical offset
+ * within the file is irrelevant since the swapfile code maps logical page
+ * numbers of the swap device to the physical page-aligned extents.
  */
-static int iomap_swapfile_iter(struct iomap_iter *iter,
-		struct iomap *iomap, struct iomap_swapfile_info *isi)
+static int iomap_swapfile_iter(struct iomap_iter *iter, struct file *file,
+		struct swap_info_struct *sis)
 {
+	struct iomap *iomap = &iter->iomap;
+	uint64_t first_ppage;
+	uint64_t next_ppage;
+	int error;
+
 	switch (iomap->type) {
 	case IOMAP_MAPPED:
 	case IOMAP_UNWRITTEN:
@@ -64,35 +39,31 @@ static int iomap_swapfile_iter(struct iomap_iter *iter,
 		break;
 	case IOMAP_INLINE:
 		/* No inline data. */
-		return iomap_swapfile_fail(isi, "is inline");
+		return iomap_swapfile_fail(file, "is inline");
 	default:
-		return iomap_swapfile_fail(isi, "has unallocated extents");
+		return iomap_swapfile_fail(file, "has unallocated extents");
 	}
 
 	/* No uncommitted metadata or shared blocks. */
 	if (iomap->flags & IOMAP_F_DIRTY)
-		return iomap_swapfile_fail(isi, "is not committed");
+		return iomap_swapfile_fail(file, "is not committed");
 	if (iomap->flags & IOMAP_F_SHARED)
-		return iomap_swapfile_fail(isi, "has shared extents");
+		return iomap_swapfile_fail(file, "has shared extents");
 
 	/* Only one bdev per swap file. */
-	if (iomap->bdev != isi->sis->bdev)
-		return iomap_swapfile_fail(isi, "outside the main device");
-
-	if (isi->iomap.length == 0) {
-		/* No accumulated extent, so just store it. */
-		memcpy(&isi->iomap, iomap, sizeof(isi->iomap));
-	} else if (isi->iomap.addr + isi->iomap.length == iomap->addr) {
-		/* Append this to the accumulated extent. */
-		isi->iomap.length += iomap->length;
-	} else {
-		/* Otherwise, add the retained iomap and store this one. */
-		int error = iomap_swapfile_add_extent(isi);
-		if (error)
-			return error;
-		memcpy(&isi->iomap, iomap, sizeof(isi->iomap));
-	}
+	if (iomap->bdev != sis->bdev)
+		return iomap_swapfile_fail(file, "outside the main device");
 
+	/*
+	 * Round the start up and the end down so that the physical extent
+	 * aligns to a page boundary.
+	 */
+	first_ppage = ALIGN(iomap->addr, PAGE_SIZE) >> PAGE_SHIFT;
+	next_ppage = ALIGN_DOWN(iomap->addr + iomap->length, PAGE_SIZE) >>
+			PAGE_SHIFT;
+	error = add_swap_extent(sis, next_ppage - first_ppage, first_ppage);
+	if (error)
+		return error;
 	return iomap_iter_advance_full(iter);
 }
 
@@ -110,10 +81,6 @@ int iomap_swap_activate(struct file *file, struct swap_info_struct *sis,
 		.len	= ALIGN_DOWN(i_size_read(inode), PAGE_SIZE),
 		.flags	= IOMAP_REPORT,
 	};
-	struct iomap_swapfile_info isi = {
-		.sis = sis,
-		.file = file,
-	};
 	int ret;
 
 	/*
@@ -125,16 +92,7 @@ int iomap_swap_activate(struct file *file, struct swap_info_struct *sis,
 		return ret;
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_swapfile_iter(&iter, &iter.iomap, &isi);
-	if (ret < 0)
-		return ret;
-
-	if (isi.iomap.length) {
-		ret = iomap_swapfile_add_extent(&isi);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
+		iter.status = iomap_swapfile_iter(&iter, file, sis);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_swap_activate);
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

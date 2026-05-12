Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D957CD484E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 05:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZDNBN8/Zr38fQe4o0BmH3BMtr2S/zx6FY6hBPjewtEA=; b=EMhnER+e9kC5qnF7LnpQw3WuNw
	0enXNGOT1cWkGC+i4ZFHbjsNeuvkc9RgkC9mPBcmoDHCay2hRRBjxkEF+ql0uUDD95B2bGPCelMHh
	4bJj8QzdsoUs7aK72M+L26T4S5nTxajdb3B948ge5YJM2qZYMEex9qyA7c0GxqmUFNoA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMfoN-00032q-MC;
	Tue, 12 May 2026 05:37:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wMfoL-00032k-U6 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 05:37:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GNG6f/qsobCnQrMhBOENN8KDFhS7LUQniOJgelpzd6g=; b=lBCpFlGr8lS4DpkxSqnZbI7X33
 z/IUtkJeZlldTUCVHWB3yadGSfagrFydSHODOrBvfivzVawH0V7Z0c6Q2BLL0ym0SmooRruZJzq0z
 IbcBMlkkZPZJ1ZsF08U8WPZRJcbmnhkzvS9HhMFabc1QsqVWhw/NbrmUfeC7vMxnn62E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GNG6f/qsobCnQrMhBOENN8KDFhS7LUQniOJgelpzd6g=; b=JS1lc4trwSAmTLCN84Nn8ZAEyE
 yUUqvx0QtFPfeYgJc4JHuOGccOFLGthfUN/YVK6MYAQtTxfkLcLn3CRJTi4gKvz2i5DthSK4kgljj
 CP20alOBRPUGc0iINqwMBcWjoNXQCWfwabv2mSZHY8qxTPhO8p1iYRNRELyKvDbTJ1v4=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMfoK-0004qe-Qp for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 05:37:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=GNG6f/qsobCnQrMhBOENN8KDFhS7LUQniOJgelpzd6g=; b=T+9tuwEeXC5tQgcpvWKYfuq6Ar
 uKkEDYS0He1n12AYyubbJb1pKFwP0d0egx+o3zSlEHg33Z+uNrYMplMAd1fCjYcVjBidd1n34L8DK
 yofO+zJRzWIbLRHqeLst7TRdnMK1aRDpYTT0iIQ6IIOy6TBzDn6JFvcDscaBZdLTC1OsW2eOjm3YW
 EFb1C3k0vinDbZ33FIm1eb3PLLRF4xxvmFXprvKiBggk5QgqvmIOvXvpsL8EgCQV8IL6Xkdfigr9F
 zwHZAG0Q/JdYvWqG+ejmLyrFHsg1w1ZB6VSHKa4nxK61Ndh02jSbtEK//PKZzbVyiFuzG30kwk7vc
 Bah3mVQg==;
Received: from
 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at
 ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wMfo6-0000000FfOs-3Cda; Tue, 12 May 2026 05:37:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>
Date: Tue, 12 May 2026 07:35:23 +0200
Message-ID: <20260512053625.2950900-8-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512053625.2950900-1-hch@lst.de>
References: <20260512053625.2950900-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wMfoK-0004qe-Qp
Subject: [f2fs-dev] [PATCH 07/12] swap,
 block: limit swap file size to device size
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

Don't blindly pass the value from the swap header to swap_add_extent,
but instead the device size rounded down to page granularity.  This
activated the sanity checking in the core code that catches a too large
value in the swap header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 453141801684..067e46299666 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -951,7 +951,9 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
 
 static int blkdev_swap_activate(struct file *file, struct swap_info_struct *sis)
 {
-	return add_swap_extent(sis, sis->max, 0);
+	loff_t isize = i_size_read(bdev_file_inode(file));
+
+	return add_swap_extent(sis, div_u64(isize, PAGE_SIZE), 0);
 }
 
 const struct file_operations def_blk_fops = {
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

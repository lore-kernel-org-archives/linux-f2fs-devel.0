Return-Path: <SRS0=+7CQ=U6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB45C0650E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  1 Jul 2019 05:24:59 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B00208C4;
	Mon,  1 Jul 2019 05:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="bWG5c1LL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Et+t7YGa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KsWG9+Wo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B00208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hhooB-0006aR-2u; Mon, 01 Jul 2019 05:24:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=078492c59=damien.lemoal@wdc.com>)
 id 1hhoo9-0006Zf-Bp
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Jul 2019 05:24:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UdePb14iwpIhTECPZqoEnffGJFfl+7aazz8VG0SNlvQ=; b=bWG5c1LL1yW1lgnroz1t3mUqIg
 YJLw875vB/7oHvfTnRjO/6fExDdc9+djWhmwWfdnU+keT/3xoVgsq3ak0eekz1pSFEMwLu1lvagpp
 3OzLz+Y9Fc+seDIjjamXXDr9w5woUNM4e+3XWZ/BSUtTI3rUfEk2Htwo0khZ+1tq4HTk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UdePb14iwpIhTECPZqoEnffGJFfl+7aazz8VG0SNlvQ=; b=Et+t7YGaBgPehcyfhUKBF9lWZP
 bZ1CtyAwdWEQeiYt6A9hTc2oqFrxfJdYn4hsWIw+UyP4sk6EsG9uRESH1dG9rHir+a1+479FFwnF/
 FQ/PTbrr80n3Zhd8l1fppNHRtKG/JEuhW4y12Lbw7WuWzCkq4ac3Qfy6rQALsbU4D104=;
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hhooC-0037dv-JA
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Jul 2019 05:24:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1561958697; x=1593494697;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eKp5BWbm2czEOH0r/etBmUeYCDH36g7dJVTVIL5yAqs=;
 b=KsWG9+WoMLmrxagivsSCQ160kXbMR2Efzdaq5dr8mQaV/nQLJWUtOcFs
 pvEL6Lk56XsZnZc5h8BJy3uhWedDOlD5x27uLnWMc6pAXkbgufSOn6uJW
 rINUzNiYutSMNUUayj7rC0DIj0YqHIVc8404LuNUV8DEOjt/zwRhoUAxY
 CpKivvXDekte4nfSc8HDiQUTE5AzVUwjxUqjRL++tu6NuRgjXjRUYc++u
 opv2L3SCyJxKLHkNclPwMoMGlP7MgdwgwDSJZ0pAGmfqYItVtxCO+IDEw
 XsW1gUVFxnPLYCGXHTs8A78R+VbuGbg1GTpA6ZQs2ghGiJqEFd9Lu4qum g==;
X-IronPort-AV: E=Sophos;i="5.63,437,1557158400"; d="scan'208";a="111921718"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2019 13:09:22 +0800
IronPort-SDR: Aoxa4p66OliqP2ruWlqLZd3N9DHtU7sa8SsZpN51J7aHwluZhc5A12OBOPlBmTa7/50EeRn1nz
 Mw2yO8DNppeicsZnloFPdxO32raNRGpO1orc43S7chiQAgTUOblZGO/SzevnrQVWfchwQjSXdZ
 Ra0JI2Qtra/GosY+wAetafUKVb4lwjy34/Py5vUoZOD9LXv5fs0csUc0Nu/VEGWWi+H3W/doLh
 jSZwx8K2lt67CtEVPkguziZScyFznbwnu3N6kdAjx2Cx8iY9ncG/s73Lj3Z7xhUc7RnNgO6Ih/
 KmivXJNeiumA1SBBiIR5PJ6L
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP; 30 Jun 2019 22:08:23 -0700
IronPort-SDR: d3MFX2II8ZNJ3WoQ6jf1YRJkftAnMXltUI6f3zNTDR7smaUTcGCaiVMXkff/WYVUpF5UXvSQ9E
 a/Xx9pkPY8Jll6aM0CCdWyyGcpxCah3A3NHprd3rphkQd1CVLYFz3SJ4VZlHfz3GmRoipQ3kO+
 oc120j1L4eJ7aNYk3dvXqJHvKObKVAvUZclqkYqVqKLlhx3GUQQyj+6qnhsAy5uUrMsHbJqLOI
 voUuUVTHXJ+yJm+BqQVdNBq7PlvJ67HHN91n+aWBuLnVH8Xk791uWDw+5cl2pfqQAVtZhqfX6r
 t2w=
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip02.wdc.com with ESMTP; 30 Jun 2019 22:09:21 -0700
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon,  1 Jul 2019 14:09:15 +0900
Message-Id: <20190701050918.27511-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190701050918.27511-1-damien.lemoal@wdc.com>
References: <20190701050918.27511-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-Headers-End: 1hhooC-0037dv-JA
Subject: [f2fs-dev] [PATCH V6 1/4] block: Allow mapping of vmalloc-ed buffers
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
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

To allow the SCSI subsystem scsi_execute_req() function to issue
requests using large buffers that are better allocated with vmalloc()
rather than kmalloc(), modify bio_map_kern() to allow passing a buffer
allocated with vmalloc().

To do so, detect vmalloc-ed buffers using is_vmalloc_addr(). For
vmalloc-ed buffers, flush the buffer using flush_kernel_vmap_range(),
use vmalloc_to_page() instead of virt_to_page() to obtain the pages of
the buffer, and invalidate the buffer addresses with
invalidate_kernel_vmap_range() on completion of read BIOs. This last
point is executed using the function bio_invalidate_vmalloc_pages()
which is defined only if the architecture defines
ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE, that is, if the architecture
actually needs the invalidation done.

Fixes: 515ce6061312 ("scsi: sd_zbc: Fix sd_zbc_report_zones() buffer allocation")
Fixes: e76239a3748c ("block: add a report_zones method")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 2050bb4aacb5..3b6e35f73fd7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -16,6 +16,7 @@
 #include <linux/workqueue.h>
 #include <linux/cgroup.h>
 #include <linux/blk-cgroup.h>
+#include <linux/highmem.h>
 
 #include <trace/events/block.h>
 #include "blk.h"
@@ -1479,8 +1480,22 @@ void bio_unmap_user(struct bio *bio)
 	bio_put(bio);
 }
 
+static void bio_invalidate_vmalloc_pages(struct bio *bio)
+{
+#ifdef ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
+	if (bio->bi_private && !op_is_write(bio_op(bio))) {
+		unsigned long i, len = 0;
+
+		for (i = 0; i < bio->bi_vcnt; i++)
+			len += bio->bi_io_vec[i].bv_len;
+		invalidate_kernel_vmap_range(bio->bi_private, len);
+	}
+#endif
+}
+
 static void bio_map_kern_endio(struct bio *bio)
 {
+	bio_invalidate_vmalloc_pages(bio);
 	bio_put(bio);
 }
 
@@ -1501,6 +1516,8 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 	unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	unsigned long start = kaddr >> PAGE_SHIFT;
 	const int nr_pages = end - start;
+	bool is_vmalloc = is_vmalloc_addr(data);
+	struct page *page;
 	int offset, i;
 	struct bio *bio;
 
@@ -1508,6 +1525,11 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 	if (!bio)
 		return ERR_PTR(-ENOMEM);
 
+	if (is_vmalloc) {
+		flush_kernel_vmap_range(data, len);
+		bio->bi_private = data;
+	}
+
 	offset = offset_in_page(kaddr);
 	for (i = 0; i < nr_pages; i++) {
 		unsigned int bytes = PAGE_SIZE - offset;
@@ -1518,7 +1540,11 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 		if (bytes > len)
 			bytes = len;
 
-		if (bio_add_pc_page(q, bio, virt_to_page(data), bytes,
+		if (!is_vmalloc)
+			page = virt_to_page(data);
+		else
+			page = vmalloc_to_page(data);
+		if (bio_add_pc_page(q, bio, page, bytes,
 				    offset) < bytes) {
 			/* we don't support partial mappings */
 			bio_put(bio);
-- 
2.21.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

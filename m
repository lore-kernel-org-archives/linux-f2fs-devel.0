Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F7DEB596E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Feb 2026 07:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:References:MIME-Version:In-Reply-To:Message-Id:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ji84spod8yV0raEanG7WdYaINjb8umsUlARVfwWoVlI=; b=OyUNyRrT1W7ONk9NnKGYWZ4ITM
	+FziPdgbBGpuw/D3qvmQJMdxj0gdbjl5uqL3qiHZ2wwb0487H0sO4gCotPNg5oVPfzxovERwRQUuK
	H4SxaKwXS+VDiJiIGRZGvoo6NmSYv/cXa9IOVvC9kXmtlSfO0SlJ9W2lTNJWP7+tB4zg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vq4II-0005CZ-Is;
	Wed, 11 Feb 2026 07:05:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <kundan.kumar@samsung.com>) id 1vq4IG-0005CH-Tu
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Feb 2026 07:05:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=edeVYa6HjHZ4mu4TNinC+G+5M3aq+ckeGzSwrEoltMw=; b=BnTMVOuHP7yFiGRaGt89rkG8PS
 5kYw8PHBFOVDamB88yYBNbafO/cJPtVa4OhMhEiNPa8ZISZ+stAdP4NpDRg0vRQmR8D6ArXcWlT5S
 bqU96uP1KWjzL69HVdcgrGREJ4hghMnptUJzA+HegGC8ehhGsm5xEPpUoSMj43ALqfXU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:MIME-Version:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=edeVYa6HjHZ4mu4TNinC+G+5M3aq+ckeGzSwrEoltMw=; b=blSh5LV8zYEd7FQ5mVlVOFYwPo
 o4WxRtW1DOKSLRuJeUPTJ+rnVW8tFBBsJrdEspSe+sGZnfitULJZdstL5XT+SV5+4AzOQT0PbhNwd
 5ixLlRwYAIveG5UonTuCQtZi3j/RvQ9ZNtQAvHChQi0ylE4WfGzWucH76K4YKkJN/bYo=;
Received: from mailout2.samsung.com ([203.254.224.25])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vq4IG-0003Rt-QA for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Feb 2026 07:05:49 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20260211070541epoutp02da451df8ee8cac38a4129a95f0dd74d9~TH1gjIhr30379603796epoutp02Q
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Feb 2026 07:05:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20260211070541epoutp02da451df8ee8cac38a4129a95f0dd74d9~TH1gjIhr30379603796epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1770793541;
 bh=edeVYa6HjHZ4mu4TNinC+G+5M3aq+ckeGzSwrEoltMw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aH7kH25ZyT7pyRQPignlNgiFNjjwRnxACeUltC5fCGZkiRkeW1x/5xksxISc6Sgee
 PI8PrslZaQ7lD4yQm6eHxjT/E7xNozuLuk7ozXJblFDAnC6aObzdO9EeV1N1mOelqX
 oQxnQQrshd4lRSimPyae7sjj3aJ58FOALWfw/e60=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
 20260211070541epcas5p22ea11564e42c12bf2d2a7997c38e4772~TH1gGnm850532905329epcas5p2P;
 Wed, 11 Feb 2026 07:05:41 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.89]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4f9qFw3zKpz6B9m5; Wed, 11 Feb
 2026 07:05:40 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20260211070540epcas5p3ba81064a4695a85d47735158b49f16e7~TH1e6Q9yM1263912639epcas5p3N;
 Wed, 11 Feb 2026 07:05:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260211070537epsmtip2d73bad556e4e9fae0a3866bd2089ad7c~TH1cP-LPZ0195901959epsmtip2X;
 Wed, 11 Feb 2026 07:05:37 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, agruenba@redhat.com,
 trondmy@kernel.org, anna@kernel.org, hch@lst.de, brauner@kernel.org,
 jack@suse.cz, viro@zeniv.linux.org.uk, djwong@kernel.org,
 pankaj.raghav@linux.dev
Date: Wed, 11 Feb 2026 12:30:55 +0530
Message-Id: <20260211070057.22001-3-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260211070057.22001-1-kundan.kumar@samsung.com>
MIME-Version: 1.0
X-CMS-MailID: 20260211070540epcas5p3ba81064a4695a85d47735158b49f16e7
X-Msg-Generator: CA
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260211070540epcas5p3ba81064a4695a85d47735158b49f16e7
References: <20260211070057.22001-1-kundan.kumar@samsung.com>
 <CGME20260211070540epcas5p3ba81064a4695a85d47735158b49f16e7@epcas5p3.samsung.com>
X-Headers-End: 1vq4IG-0003Rt-QA
Subject: [f2fs-dev] [PATCH 2/4] f2fs: stop using writeback internals for
 dirty_exceeded checks
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
Cc: linux-nfs@vger.kernel.org, gost.dev@samsung.com, anuj20.g@samsung.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 gfs2@lists.linux.dev, mcgrof@kernel.org, vishak.g@samsung.com,
 Kundan Kumar <kundan.kumar@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Replace direct dereferences of dirty_exceeded with the core helper
bdi_wb_dirty_exceeded(), removing f2fs dependencies on writeback
internals.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/f2fs/node.c    | 4 ++--
 fs/f2fs/segment.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 482a362f2625..d450b282cc55 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -78,7 +78,7 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 		if (excess_cached_nats(sbi))
 			res = false;
 	} else if (type == DIRTY_DENTS) {
-		if (sbi->sb->s_bdi->wb.dirty_exceeded)
+		if (bdi_wb_dirty_exceeded(sbi->sb->s_bdi))
 			return false;
 		mem_size = get_pages(sbi, F2FS_DIRTY_DENTS);
 		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 1);
@@ -119,7 +119,7 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 		res = false;
 #endif
 	} else {
-		if (!sbi->sb->s_bdi->wb.dirty_exceeded)
+		if (!bdi_wb_dirty_exceeded(sbi->sb->s_bdi))
 			return true;
 	}
 	return res;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 07dcbcbeb7c6..d7166f1f000a 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -1000,7 +1000,7 @@ static inline bool sec_usage_check(struct f2fs_sb_info *sbi, unsigned int secno)
  */
 static inline int nr_pages_to_skip(struct f2fs_sb_info *sbi, int type)
 {
-	if (sbi->sb->s_bdi->wb.dirty_exceeded)
+	if (bdi_wb_dirty_exceeded(sbi->sb->s_bdi))
 		return 0;
 
 	if (type == DATA)
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43AEECD4851
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 05:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ccm8/rpyjs5DPocqp2J2WauISdYXO1gFG0b3LXdNhBE=; b=eZELVUtCFV0R/dW21T0P7kppJM
	0R4KpZJqUhjXrB4/BOpMLEH6bJIy/m12RA4v0oC4DPMbKybDybqCBaUNZ2BbjZvQmop1ZwyFDCAHl
	yMnwa2wx76hzvnlCTCIE4Xb8ttcOhfNxH8yctSDebhFv6ymqWfg+PkHRunvvGB++cdkM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMfoD-0002ov-92;
	Tue, 12 May 2026 05:37:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+9f3c1ea353498f61ccd0+8297+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wMfoC-0002ol-It for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 05:37:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SFnfiE6eXJFzgFJiNYniWIOwAjN0Z4qYfw3E7XgNBJs=; b=F9nAOWBA/rESxJ8EaD9L1SdPze
 wjwVORmES5umE89DknxS3BiyMur4uJAsFQp+aSlLhY0+QZu881IpXWE4vpQy+pRoxCJ6D+6Wnu7Gg
 D0VerHCVBVONYHfU/pJETU/TY0zhuMgH1E5gDY7AdRTqVi6lwR+te2rVI4mOGGQwYprk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SFnfiE6eXJFzgFJiNYniWIOwAjN0Z4qYfw3E7XgNBJs=; b=RrfcfAAG1/+Qz1HE+GM+A/lvKQ
 lDJ7ha8DlPS+dbCyZpn0mD9meUlY1RIZ4BqO1OJTaitoeM+CVT7znjY7J6NgxqXypffP54y71IRJf
 NHFUQHCjPQnFBvuD+Yohf2+P7b6mVh9SwbAB5s0VM5UvFeyfmNFC1FC7Qufec86TqCvM=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMfoB-0004q2-Aj for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 05:37:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=SFnfiE6eXJFzgFJiNYniWIOwAjN0Z4qYfw3E7XgNBJs=; b=fBrYSimVUdqrWfQJb5ZGKTYrxO
 a4Q2JOWiqE1CrUKooGJ+LnGljcIS8i0i67sgotq7jYGDfkK4CReONqXDgpdqL0znEO5HEjqAeTVi8
 xILDvqBWxJWjF/OI/KDh56u7zEK8MasUS6riWjIJ6RJO/PBZmt7PIHIwBbtxNNUzWvywTl8FBUngp
 ttTGV9wVPAzvKL/ydNorpVDlfSZXsRT+mFxIzvvFpNdabt4qSFEM+hU4NtmDYDGVH/LhwHQYIXmNg
 +785VZ7NDn66h/wVUqsB1lC5B/w0u/0Zv8F7lWQfn8l8nnNUP7CB+0nr3BgxUAS9rRdxQv0hrzSEf
 sYvsiBQw==;
Received: from
 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at
 ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wMfns-0000000FfM7-0BDl; Tue, 12 May 2026 05:37:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>
Date: Tue, 12 May 2026 07:35:21 +0200
Message-ID: <20260512053625.2950900-6-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512053625.2950900-1-hch@lst.de>
References: <20260512053625.2950900-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wMfoB-0004q2-Aj
Subject: [f2fs-dev] [PATCH 05/12] swap: cleanup setup_swap_extents
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

Reflow setup_swap_extents so that the flag checking is not conditional on
a swap_activate method.  This is currently a no-op because the swapoff
code still checks the presence of a swap_deactivate method, but it
simplifies adding a new check, and also makes the SWP_ACTIVATED flag
more consistent.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/swapfile.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 651c1b59ff9f..1b7fc03612f4 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2783,25 +2783,24 @@ static int setup_swap_extents(struct swap_info_struct *sis,
 {
 	struct address_space *mapping = swap_file->f_mapping;
 	struct inode *inode = mapping->host;
-	int ret;
+	int ret, error = 0;
 
 	if (S_ISBLK(inode->i_mode))
 		return add_swap_extent(sis, sis->max, 0);
 
-	if (swap_file->f_op->swap_activate) {
+	if (swap_file->f_op->swap_activate)
 		ret = swap_file->f_op->swap_activate(swap_file, sis);
-		if (ret < 0)
-			return ret;
-		sis->flags |= SWP_ACTIVATED;
-		if ((sis->flags & SWP_FS_OPS) &&
-		    sio_pool_init() != 0) {
-			destroy_swap_extents(sis, swap_file);
-			return -ENOMEM;
-		}
+	else
+		ret = generic_swap_activate(swap_file, sis);
+	if (ret < 0)
 		return ret;
-	}
 
-	return generic_swap_activate(swap_file, sis);
+	sis->flags |= SWP_ACTIVATED;
+	if (sis->flags & SWP_FS_OPS)
+		error = sio_pool_init();
+	if (error)
+		destroy_swap_extents(sis, swap_file);
+	return error;
 }
 
 static void _enable_swap_info(struct swap_info_struct *si)
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

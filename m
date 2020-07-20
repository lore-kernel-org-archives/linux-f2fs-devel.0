Return-Path: <SRS0=oydM=A7=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A24BC433E4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jul 2020 00:14:06 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0FC82177B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jul 2020 00:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ZbCU4N1B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="GBb64Gbj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IfvaB5pj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0FC82177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jxJRT-0004fg-Q3; Mon, 20 Jul 2020 00:14:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <rdunlap@infradead.org>) id 1jxJRR-0004fY-Vw
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 20 Jul 2020 00:14:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w3ocKZG4wB9+BN3HWi6dTE1pwLbH0jUZXg8mdu1fAZE=; b=ZbCU4N1BlOf/EqAgCrsrQeWv0B
 RzBGOPuNbsu4rt3vUdDsEqmT8tLhhRwJw/VJxZVc8ZxXlb862d89NqpKbh2JTr4MkGQDJp8iNMaHh
 aO/SguGqNebmERLdWfSus5khMHf7jkIb/em6zQ++R2SrJ4VdVyNCml8DL2HWDwSfXOoY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=w3ocKZG4wB9+BN3HWi6dTE1pwLbH0jUZXg8mdu1fAZE=; b=G
 Bb64GbjaPSx8EWUmx5gWe8t5/2CjR5ddXE3ZVIM1+h0uz0LScrxvnA7Y/V4fNeQ/ozYcZ3bDrXYVy
 zMrXoRd2OlaSaiIiBAmMiEGTM1onsD111h6Md1d0/rYBIqGC2mSAnsIyXB0DbL+UTGWzsVMEqA9uV
 vw0QWvjDnnvsZ3ZA=;
Received: from merlin.infradead.org ([205.233.59.134])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jxJRP-00C11w-4z
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 20 Jul 2020 00:14:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=w3ocKZG4wB9+BN3HWi6dTE1pwLbH0jUZXg8mdu1fAZE=; b=IfvaB5pjviEa3rTvLBwVBYZVfI
 p9QNyt5uyU28PO7PozjAJipC0XsS+cIcnJ8fa1JINcIyT96WBmzTnBSEyBB1MHAdSrmCwvWgyB9dm
 tptQ2GMgiqfJrLebL6qva7Cw7KAfkbmfQgd04vcHL4ivCWW5q6T5qNqL4PTN50eQmdMEOAHE9gcWH
 ufVg0DcyAKzJf7S6ywmCuy+rS7V+Ve27QKmSvbrU9m3n1+dsePyT+1QIE+E5tAV5mDkXd7X9uRBoK
 lXSx+VX8Zb9Zn4GzdlgORNlYbEkUkpnYz3px3nIW6h+HAj1BMkxfN0cFH99ZK0Up48mAwRHWQu9n0
 x1RDlqKg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxJRE-0003y3-Ow; Mon, 20 Jul 2020 00:13:49 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Date: Sun, 19 Jul 2020 17:13:44 -0700
Message-Id: <20200720001344.25138-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Headers-End: 1jxJRP-00C11w-4z
Subject: [f2fs-dev] [PATCH] f2fs: segment.h: delete a duplicated word
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Drop the repeated word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
---
 fs/f2fs/segment.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/fs/f2fs/segment.h
+++ linux-next-20200717/fs/f2fs/segment.h
@@ -187,7 +187,7 @@ struct seg_entry {
 	unsigned char *cur_valid_map_mir;	/* mirror of current valid bitmap */
 #endif
 	/*
-	 * # of valid blocks and the validity bitmap stored in the the last
+	 * # of valid blocks and the validity bitmap stored in the last
 	 * checkpoint pack. This information is used by the SSR mode.
 	 */
 	unsigned char *ckpt_valid_map;	/* validity bitmap of blocks last cp */


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

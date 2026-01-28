Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C89D3F07A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Jan 2026 15:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nGCj993utGCOoyMkqRRy0ZA967BR63H2qplsys14HeE=; b=HinpaLPsQxSo+nLcXGp7/Gbrnz
	ONlKJBcDJi9lP9IWAHdC11Vb/9MiFiBZ69IxRnBp+CU91UeBo5tVF+HnExe4pGVd2bIKD5MfNboN5
	/4hwCZpvjyGWoPcLoTGHdcgF/R34fF+Jd2nzKKS0yxQdvapNGw4UZse7j7n7a/moK2tg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vl7Rx-0003YC-MQ;
	Wed, 28 Jan 2026 15:27:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+97ec6e74097c8d3e794e+8193+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1vl7Rw-0003Y4-0b for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Jan 2026 15:27:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0Ic6Dg2kMbDfbML3FwgTOGvJaqoJ4sjBOcPdz8pJF9g=; b=hSnMUHcisJ6QTDjyK2u/fC0Lry
 HPvzqc1QXL2P203Iu1jVCPYIMDJ5NF7odlebVcPvIgsbxZVVVAfumdW8WRtS42d4x8rTUMtd6hPq3
 rRHScgctQC+XsgBMMQPqD9ctV0bXsx9yZZxVT5L0E9ESqgFkW8AiAz/nA1GViXcE6DLU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0Ic6Dg2kMbDfbML3FwgTOGvJaqoJ4sjBOcPdz8pJF9g=; b=jfhR0HDBYmsr3uipwHujyFMXr7
 v8fXywUlnO2uodNhKuuGUNdNPXmJ/0NLDELWGI1TjL2UAecB01hHxTIBHCw/ltUbPw0Xb4Axxie0j
 ZokrScqI9w79ri8iLRWE0r8fhtuVm4VREI9do4dN4Ojf+n/R1UkF4jV4l2YJPWDyyMNU=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vl7Rw-0002TE-Bx for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Jan 2026 15:27:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=0Ic6Dg2kMbDfbML3FwgTOGvJaqoJ4sjBOcPdz8pJF9g=; b=xWZ0Ob6Uwc4f4G2Brz/N7pMrg8
 QKnBg+DCe3ZSuhqviV+qcmwdg5AagT/Z/h4hZz+QI1YhT2huEuSGXZeNQiCgIl7LzEJqG7uhbjnoT
 PKWq2B6/deeNtMiwKQmPs9I/sF2J90aAtSn2qyC8/M3zZ4mvSiTlfoMAp5zs/Wh2iDLjtJLSPp+LZ
 XarLdYIi8U534G4VVt6RUrtE4Fa5tkNbRYWkugmQwoUJsb0l+Wv3InbPS21Whs+mF0IRsitQBHT0G
 LYXBRDmKEFhOj1/x/4eYUhycHwK3XVa4vwPOB1TJhjueiGE+M3t83jCio5EynrdWazsGHOD5+wlbn
 9OmJglyA==;
Received: from
 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at
 ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1vl7Rg-0000000GHKF-1SPU; Wed, 28 Jan 2026 15:27:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Date: Wed, 28 Jan 2026 16:26:15 +0100
Message-ID: <20260128152630.627409-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128152630.627409-1-hch@lst.de>
References: <20260128152630.627409-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1vl7Rw-0002TE-Bx
Subject: [f2fs-dev] [PATCH 03/15] ext4: don't build the fsverity work
 handler for !CONFIG_FS_VERITY
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
Cc: fsverity@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, "Darrick J. Wong" <djwong@kernel.org>,
 Andrey Albershteyn <aalbersh@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 David Sterba <dsterba@suse.com>, Jan Kara <jack@suse.cz>,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Use IS_ENABLED to disable this code, leading to a slight size reduction:

   text	   data	    bss	    dec	    hex	filename
   4121	    376	     16	   4513	   11a1	fs/ext4/readpage.o.old
   4030	    328	     16	   4374	   1116	fs/ext4/readpage.o

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/ext4/readpage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index e7f2350c725b..267594ef0b2c 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -130,7 +130,8 @@ static void bio_post_read_processing(struct bio_post_read_ctx *ctx)
 		ctx->cur_step++;
 		fallthrough;
 	case STEP_VERITY:
-		if (ctx->enabled_steps & (1 << STEP_VERITY)) {
+		if (IS_ENABLED(CONFIG_FS_VERITY) &&
+		    ctx->enabled_steps & (1 << STEP_VERITY)) {
 			INIT_WORK(&ctx->work, verity_work);
 			fsverity_enqueue_verify_work(&ctx->work);
 			return;
-- 
2.47.3



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA0EC43334
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Jun 2022 08:12:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nyqnb-0004e2-14; Wed, 08 Jun 2022 08:12:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2) (envelope-from
 <BATV+ba9ae8ab3d8ecaf97ba4+6863+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1nyqnZ-0004cZ-Fv; Wed, 08 Jun 2022 08:12:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Szf0A6CRm0TBzxMXL1+4gkRAFMANtEnQnq4pU3N3BDY=; b=bsPwGQwRIM7wXwhxQXlya5Pxx7
 KkwnEaEaZ2M1FnZcmQP2k1mynoFbi11xnIYW+dvlrCRGb1dBSYZapZ/v7sGw1eA0pVSN1tqkzvjlt
 CmJ15BMuWahEbsYzgY8LBr6phvF3CAt4hbdiGgT7sU/MezTHKmd4tgGCPvoGHh0Tk4z4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Szf0A6CRm0TBzxMXL1+4gkRAFMANtEnQnq4pU3N3BDY=; b=YbhFpJB27VE5XHdwn8ztC74pm/
 gjoajTuB8SZ45B5lNxLYLwP7fUdBuS9PIUWjlTNfCBilPSSiTL1Pr3bxmOM7l449BR7dXfzW7zoOT
 bsndfQhR4feMermZT69VTkokreF3NUueWsmp/3jEiSCFGRiXD2ugDUQr9DQ/A/z3uzu8=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nyqnZ-009aTo-67; Wed, 08 Jun 2022 08:12:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Szf0A6CRm0TBzxMXL1+4gkRAFMANtEnQnq4pU3N3BDY=; b=bYF6iw7wjd0y+Z+F/STcPCdMi7
 QSbSyR1GVcGFHB6mUBGkUCvisiY89ZNNX0/Xw7TDYYqDhHEMDOkqpQ78YG7sV4Im0du6F72Z2caY2
 H1v0O8XuuqPMcgOMYc4Efb1MkS92YKtPUeCLJbq9RGFmaygkN6erKP+/0UYxlGLIp8l92hgq4KJ31
 kF5IB4FI7Rq0HgNYKMpkwaCRGuxqr9lQsYWHvQqZ+Vswy62VOxb0dtM/TNE4n9Rus3hm4P1v786GN
 Bu2U9oHHaP3qDEJtlCQFZ55nYDw8n8UvwKtVqn7mGlBP2GXKaLdhKDC9jgMMNKOZ33JSqYzDxDfna
 Md/gh56g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nyqnR-00Bqhf-Qd; Wed, 08 Jun 2022 08:12:09 +0000
Date: Wed, 8 Jun 2022 01:12:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Message-ID: <YqBZ2fWTyU9cbyR+@infradead.org>
References: <20220606204050.2625949-1-willy@infradead.org>
 <20220606204050.2625949-5-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220606204050.2625949-5-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1nyqnZ-009aTo-67
Subject: Re: [f2fs-dev] [PATCH 04/20] mm/migrate: Convert
 buffer_migrate_page() to buffer_migrate_folio()
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
Cc: linux-aio@kvack.org, linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
 linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jun 06, 2022 at 09:40:34PM +0100, Matthew Wilcox (Oracle) wrote:
> Use a folio throughout __buffer_migrate_folio(), add kernel-doc for
> buffer_migrate_folio() and buffer_migrate_folio_norefs(), move their
> declarations to buffer.h and switch all filesystems that have wired
> them up.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

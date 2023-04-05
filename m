Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62485C76188
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Apr 2023 15:47:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pk5Lv-0008Gl-VH;
	Wed, 05 Apr 2023 15:47:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+46b8a92f13ae362fdcdf+7164+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1pk5Lu-0008Ge-JQ for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 15:47:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/a4RYFvjJCESxZnfN0nD29LBSxPBoE93Z5aSyhucaTc=; b=PtBFq0ziXbI+hAADIhOjOsl0Ms
 yDd3GsDV676jMhw1DgEgVsUag1zn1OlOq589PXg8+o8NhpHCojuCPx3lNuxfkvQWBETrYEkVmvh47
 91N8aU/6z504OdwXRAflmNPs/2TpvkJZR2ddk+eWvCttQnCvEThjBzXSgpNi8vC4LOro=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/a4RYFvjJCESxZnfN0nD29LBSxPBoE93Z5aSyhucaTc=; b=UBLYgEURsLuW/AoTEKR1LvFL/q
 vqKSYAMmZIoiuL9alAtMTxZECJww12eNExyJoTAhfarqxEIhQH18Zl8qIlMeuj69nIJvTSmCW8e2a
 RxbGT/8NecG7h8gQ2FfUrORU8K3CkAWOycgg/NB2Y9AGLKxCB/2+fvrw7lz7T0Hx28Q0=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pk5Lt-0001hc-Oh for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 15:47:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=/a4RYFvjJCESxZnfN0nD29LBSxPBoE93Z5aSyhucaTc=; b=uZ5h4XuoSXe9+bgTWZvctsPSxL
 J8n1Ti8TOouo/7zVirWNYVC1UyJOxKJpvj0IV+068Sq2z4depUOryc2RPjsLDhDshySk3s1ERkMpO
 twG0PSY4Y9A4gHSqC5CiZ3DMrNnYamMfG6SDrpa5Hbgson6ObhdtRptTunuu6/oiaeD91NhGeqxl2
 LLiW0vhAwI9MzSnUyZBwOw1mxO39uzvhLDuMN7ocWBeWMY6tdeepv0CTpk6k8mMGLRIx/k4z9ngyj
 nvah9ZylV5D24DoACN/gpECeBwawUgtXs3FnYtThZl3pWf+dDadXNQQ65Tb5WLmAhQS1NHqb3/aKN
 ufVxLm9g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1pk5LR-004xwQ-0b; Wed, 05 Apr 2023 15:46:45 +0000
Date: Wed, 5 Apr 2023 08:46:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Message-ID: <ZC2X5YlHMxzZQzhx@infradead.org>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-6-aalbersh@redhat.com>
 <ZCxCnC2lM9N9qtCc@infradead.org>
 <20230405103642.ykmgjgb7yi7htphf@aalbersh.remote.csb>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230405103642.ykmgjgb7yi7htphf@aalbersh.remote.csb>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1pk5Lt-0001hc-Oh
Subject: Re: [f2fs-dev] [PATCH v2 05/23] fsverity: make
 fsverity_verify_folio() accept folio's offset and size
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, agruenba@redhat.com, ebiggers@kernel.org,
 djwong@kernel.org, damien.lemoal@opensource.wdc.com,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com,
 xiang@kernel.org, jth@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Apr 05, 2023 at 12:36:42PM +0200, Andrey Albershteyn wrote:
> Hi Christoph,
> 
> On Tue, Apr 04, 2023 at 08:30:36AM -0700, Christoph Hellwig wrote:
> > On Tue, Apr 04, 2023 at 04:53:01PM +0200, Andrey Albershteyn wrote:
> > > Not the whole folio always need to be verified by fs-verity (e.g.
> > > with 1k blocks). Use passed folio's offset and size.
> > 
> > Why can't those callers just call fsverity_verify_blocks directly?
> > 
> 
> They can. Calling _verify_folio with explicit offset; size appeared
> more clear to me. But I'm ok with dropping this patch to have full
> folio verify function.

Well, there is no point in a wrapper if it has the exact same signature
and functionality as the functionality being wrapped.

That being said, right now fsverity_verify_folio, so it might make sense
to either rename it, or rename fsverity_verify_blocks to
fsverity_verify_folio.  But that's really a question for Eric.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

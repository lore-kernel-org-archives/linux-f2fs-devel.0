Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F209C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Jun 2022 08:03:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nyqeq-00066F-NJ; Wed, 08 Jun 2022 08:03:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2) (envelope-from
 <BATV+ba9ae8ab3d8ecaf97ba4+6863+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1nyqeq-000669-6C
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Jun 2022 08:03:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lmlll0xHee/vEiVot8MaIaDnFq94X7SQmNxMGuo2kIg=; b=KKO/nM/KcbiN0Rs5MKO54sVOqG
 42GUPuuqF1l+/i3Kh63KbQiuAYdcGuXyChOB4L5U/6AQgd0jbNEOqEm0uxHYkFI9Z2/BH+8UVn4ZV
 70kmegFUCtGJjoqByPd+n45e/pPGd1Dul4UvN5s/TR6DQYy/PHUkH0OP8Y5fDIDUcq9A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Lmlll0xHee/vEiVot8MaIaDnFq94X7SQmNxMGuo2kIg=; b=Sj2x/wkEvWdZt3H1yW8Icdagca
 w5U6yWxVHUVkszl3WlPxCpuMjOIifxsvk0MvKnNOKbuppl0Jv4c0f8jwh8+O1w2fULRcSrwNZpRkE
 VcouldmzErN7SZoRx6ujdWQfA2q2hn6Hfv/yrT2fYDTaxSzfVShXsAcjZF/08ytXzaMo=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nyqeo-009Zwa-Bh
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Jun 2022 08:03:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Lmlll0xHee/vEiVot8MaIaDnFq94X7SQmNxMGuo2kIg=; b=K99MhL27rbGpyk6oZoCQHDJStN
 ATHqNPOPl7fmyyQofTDK54G9VDdXR1JVCTiKCNsyr/ha1NjCveZwfyr+ElXb6XTm4WzMWeGZrNqoP
 5YXYRBZ/7Jh9lheCch0n+4CO+bhipsSd9uBl3meB+fpXyr3N/vuS+NureIBbTXMUob/JPzY9Ita3n
 rPGXBOz7FEXZ8SjNR69uDCDib2RwXZNJiLNaSJtWaPlbu5qnHUXq3m6OFZVDMKd1O9sq9xB+VDKM5
 Dm2DLmp0am4A0lVr3uXzeX8+FPn7RkWsYdGC0GKaalaGr3v/k6XOaJBNnhuKawVGhybCgpknzNBKc
 BwrsYkgw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nyqeh-00Bo4j-Cp; Wed, 08 Jun 2022 08:03:07 +0000
Date: Wed, 8 Jun 2022 01:03:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Message-ID: <YqBXux0cF90xV80C@infradead.org>
References: <20220605193854.2371230-1-willy@infradead.org>
 <20220605193854.2371230-5-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220605193854.2371230-5-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1nyqeo-009Zwa-Bh
Subject: Re: [f2fs-dev] [PATCH 04/10] ext4: Convert
 mpage_map_and_submit_buffers() to use filemap_get_folios()
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
Cc: linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sun, Jun 05, 2022 at 08:38:48PM +0100, Matthew Wilcox (Oracle) wrote:
> The called functions all use pages, so just convert back to a page.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

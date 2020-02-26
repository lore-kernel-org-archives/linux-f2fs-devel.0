Return-Path: <SRS0=pqVX=4O=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2724DC4BA13
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:08:06 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13D5206E6;
	Wed, 26 Feb 2020 17:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="aMVq4gEv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="VrInMluq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jBVHe720"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13D5206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j70AH-0005xf-Ki; Wed, 26 Feb 2020 17:08:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+7931773228f1d9803703+6030+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1j70AG-0005xJ-Mb
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 Feb 2020 17:08:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zuKVx+x+d2CRDbmOIHUQcsQ78U8eI2O7e4FcEVHD4ak=; b=aMVq4gEvrljmkyzPzetEsozRWw
 D8aC7dZmOf2or0hIGY1HCi+O6tDN/+LClqrwplnZcSJGJmDeixY6f7j3S58Jg+6MQ7Pe8Acud2gyY
 XDqIJA7Zsgfuo5TWAJ7kk3FI77sUk+Be3ODHPJTNwlZNIfZje/sdSlUoUcy4msom7q2c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zuKVx+x+d2CRDbmOIHUQcsQ78U8eI2O7e4FcEVHD4ak=; b=VrInMluqXPoP2Apr1tq8m89Mn0
 E2Dy2u9Mna7KB0z20Uf9wQj+wrK8PwumuAtNN0eRf/bwnT7AX2YXFLYQcUWDPtfCnCEe9YIHmvSp4
 y9rqgzgoej9LhooB2bqlSL27nE0rsYw1uB5NeSB94gZvPWBDSdgTi7wNpuVM5OXvm2jo=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j70AE-006uuq-PZ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 Feb 2020 17:08:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=zuKVx+x+d2CRDbmOIHUQcsQ78U8eI2O7e4FcEVHD4ak=; b=jBVHe720Oz4QM93RRxqAXNQ+0L
 hWsUsZNuf4kg3JgIqeGTrjOerzaCcO7/g6K7je+ek18c1KIg7UxZU/PK+NCVRK8Lhl11GYraKadBQ
 j8DC/ExYyXkdNDQ3QANaihJyM5OJMk3BU48kHyDWUtAO6TU3X5oRaproeODcdij1tHX8xtUb5Nyud
 g5p4pNlxRSYPL33pdpP57VC0ee2Z0ra1tzT8bv5CqewJ1zoRCrn1NakUzAnanqvl4ZdiKEp/4saYm
 bGaTczv7VSWTEXBvCl05ml3WPBX3ZXNCUKYhbJfoI4k9LCVnThYNxIZ6x7nxXVdGLr6bGfdC3fPTU
 Vf8uoblA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j70A7-0008Vg-QE; Wed, 26 Feb 2020 17:07:55 +0000
Date: Wed, 26 Feb 2020 09:07:55 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <20200226170755.GE22837@infradead.org>
References: <20200225214838.30017-1-willy@infradead.org>
 <20200225214838.30017-26-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200225214838.30017-26-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1j70AE-006uuq-PZ
Subject: Re: [f2fs-dev] [PATCH v8 25/25] iomap: Convert from readpages to
 readahead
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
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Feb 25, 2020 at 01:48:38PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Use the new readahead operation in iomap.  Convert XFS and ZoneFS to
> use it.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFDECFC279
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Nov 2025 14:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lNpRVowrAQip6t7lSd7vsGEAKzu2CNmNO1G79WRB8dc=; b=a3lC+SevwZbzZtj/pjwoZC0b3w
	Hcd+UST2wTYNrhALyx2tED9O2GYY4puNKzvAJTQyw+kaBIh0bDkQJX2yRGnU2kNOWMiyLYakWHyKE
	GueqnsEyIQ+fWwsoBnLnHAJAQmxNhX7ieZe4CY1MiQgYnNxy2InfRZrYH4jotyAUSnSM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vMSA1-0006DV-Eo;
	Fri, 21 Nov 2025 14:30:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1vMSA1-0006DO-0U
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Nov 2025 14:30:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rWL9wwR2J7ur6WOaG2a8HXovHrgszFBK7WTZWMyo8ak=; b=c3ZhcfOaB5vsx+Xwkpdf/XnTFh
 iZVs/ZwZSKutbinfxd8k4CJuuXV4Je/K8gOS7X4wclsEcCGWkh/Rr+uXAJ4Arvvtw6iyw4RMrg9D5
 G/G7fPmWxTVELisF1MDRWdhrEAgO9Bo3y6zEip7RpsAEWrGa9i+ZadGgddhDPtXdQhYY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rWL9wwR2J7ur6WOaG2a8HXovHrgszFBK7WTZWMyo8ak=; b=gD8YGT9hAt7tJB/nV3KNYTS7Sv
 K6i4/lSUFxZLvv3byi6sO1sIjqqUNV1ZyVpDMGTEg/SfwVsY0HwfvVWAhuz3EPbKDgoj69Z1PHAss
 FfLXuKIebEgFrHOtLq5BeR1YGq6AsNxo6QiGFYB6bT73IxKDi59klTTBZ07I59eQJpUo=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vMSA0-0008AP-M6 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Nov 2025 14:30:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=rWL9wwR2J7ur6WOaG2a8HXovHrgszFBK7WTZWMyo8ak=; b=O22jO61BxSdaC0izHP8pSZOrFO
 6W8RsHSXwq1ul46hFyH40TgXN49NMB1uTyM70T2JJKnpK9DNgoRH+Z2BQ8qFX/69h4FQpuqfANAfy
 bjB96/02Co5+lPsVSPNcterNtTFaTojSWU9sq+Gd8m88zGVhzmx9L6sH9O0zF30TplrlA3trAYRq/
 0JHtEdZaoee1QhsCTAl7AMnv+2Ld7MQ7MB3KmDOCIvheAFlmUFQ35c8UUN26VMRTCjPLIITwT+0zN
 gxJdto+vYI0YyGVIk0ikxC0o9uLKxh40c4XoAc+8+kbvQhKGhMqw1wk746LWgW+GM6ZGONbLuqZ4d
 ZeiOSjAA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1vMS9p-00000002zZ2-1DP9;
 Fri, 21 Nov 2025 14:30:41 +0000
Date: Fri, 21 Nov 2025 14:30:41 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <aSB3kcsneAS94DgU@casper.infradead.org>
References: <20251121014811.1971698-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251121014811.1971698-1-jaegeuk@kernel.org>
X-Headers-End: 1vMSA0-0008AP-M6
Subject: Re: [f2fs-dev] [PATCH] mm/readahead: add a desired folio order for
 readhead
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
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Nov 21, 2025 at 01:48:11AM +0000, Jaegeuk Kim wrote:
> This patch adds a desired folio order in file_ra_state in order to get
> non-zero-order allocation for readahead.

Why?  Does it not ramp up quickly enough for you?

I see a lot of patches from you that say what the patch does but very
little about why.  Please explain yourself more.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

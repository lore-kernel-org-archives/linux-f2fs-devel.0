Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E04FEA80C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Mar 2026 05:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x592jE8e+xyFmtzFA4MujbPu9XkQCFHxr3jJS7zP8cM=; b=BI8MD4YNKnpfVE7v+V+V1aFoo2
	fgXbGtnOJe6taEOP0zRIXVLUsBbpe4/656V9Pop7r+/Rnnw2NdyEwM01in+wE7sSfchGlUBxDGugI
	qZAC+5nkVtGMBqxm8K5YPKH4MwUBvyDFXICftFeWCL/33dQTL2eKalBapLTqNxqd9wTc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w5HB6-0002BB-3B;
	Wed, 25 Mar 2026 05:53:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+3b37efca848b3caba94d+8249+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1w5HB3-0002B3-DQ for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 05:53:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SHDXUeS5jnR7y0znBQ+/KFl+xqNiEw10GPaQ+zVa7q0=; b=ShglfpI0usI6myCM1oTk+3kJKx
 37sYUo+tJ/KdyGatPBSrziMESwrsUyonr6PUYOicFDQ6bgCdgxVjAs/K1APQfEOABbxHg+7KBzcwb
 qB7GUSS0WXCf9Ngj5OVLq1kSrKOzjWDps3hiF/IfV/nDCGABDN0+3vD1YCT5wxMt0spM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SHDXUeS5jnR7y0znBQ+/KFl+xqNiEw10GPaQ+zVa7q0=; b=grGWdkSJ4a7JZAW6HzNFcT/mjC
 7ki+C5b6i2Uyn/PWIqRosC4+aCdYdvbnJ0lmduIxSXuNUn1+MXCF61YDDS+lQlrj9Y5VyyrkWEOD4
 wghaxYoFOiyIrLGgs6yoJGSdaiok9pXgPQw2YkIkVZuBTpIV7qxxIZqypcplXXuMnkkY=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w5HB1-0001Fe-V7 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 05:53:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=SHDXUeS5jnR7y0znBQ+/KFl+xqNiEw10GPaQ+zVa7q0=; b=4oEgKq+Z9wK0/UfLZYwjfIQJae
 QX0Ib6GUJWXRdxWpiZjrnwawzI2WP/kg3FX+sWKJNVm05/u+uHElk0YBR5/GyzYLop8GtNqbdu4VV
 vZ6NxzKIsZWte3mqlLXNnoEvHSisA3lvqQUH3xcH+S2vbLy0GTLDQ4UOqGPyRpdhMBX37Q1WVm2q2
 x+RKePvh+V3C0f+bBuLqK8Orn7IbdoIf3vOr50M6a2XD/Azc6x1fHyCkWp75Ryz3cHXlMyab3TIbK
 +sA+eiytnPpTWT4U4aH0Sd9v6ILU1GN92ML8pPd1OSEFKUK79rGzXowJ/7HA0dprQlfeevZErKiMr
 irUEVJgw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1w5HAr-00000002koM-2gNL;
 Wed, 25 Mar 2026 05:53:01 +0000
Date: Tue, 24 Mar 2026 22:53:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <acN4PWKHvk_33VB7@infradead.org>
References: <20260324025656.493776-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260324025656.493776-1-chao@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1w5HB1-0001Fe-V7
Subject: Re: [f2fs-dev] [PATCH] common/rc: support f2fs in
 _require_fanotify_ioerrors()
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
Cc: jaegeuk@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Mar 24, 2026 at 10:56:55AM +0800, Chao Yu wrote:
> This patch allows to run generic/791 on f2fs.

When was this introduced?  This doesn't currently exist in mainline,
and it would probably help to run your fserror implementation past
Darrick and fsdevel for review.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

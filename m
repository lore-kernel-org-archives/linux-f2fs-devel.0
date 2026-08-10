Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C960EC5AD4E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q7wUQpNIgSEZqgdj3ALyVcn1veat3vTamXGDsVpwktE=; b=QqPQDllJuD8UJxz79kukB5JMQ7
	4p4M/E4LWaHdM9jIOOdUgHNUDLPJKJGVdo2yTBHCWoSpWJTAkOOui1puBbwZo4kIY+B4/4EVAzv9E
	q3vmBz4zJP6P9zsG4y1xK5cv6kvsTUkG8wENUZeZerDweaX4PBwxIZ+iSIHHiaCupQRE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wtLS3-0003lY-N5;
	Mon, 10 Aug 2026 08:33:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wtLS2-0003lS-R9
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 08:33:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BAtyw81+dBMiu7XlLAIQLatNTnzJYfKHmuu6xvYOIyo=; b=k2tD5e+ZN3dQI6/G56RWxhmWsg
 Ki9aRkOqHGFNfhCMldj9W1WcAqT0WKru9YJIPGPDcUNFzCvdGG9xPaYQMuQyRb0wXAhqHnw5vu0MQ
 DkNu4KbylDllSr+yEP9BKBLw+OW0f/+s7pOIgM4tfHaMLjdna/hDzOSCzjvw+L+8R1L0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BAtyw81+dBMiu7XlLAIQLatNTnzJYfKHmuu6xvYOIyo=; b=FX3+WRiUd8kcDTKPH5YnfMng0G
 tOlTz5T7tXkRQUIfaAJaMlboMVL9w859ZEA0Y1scOczb9zZ+mEuLxCV2ADFxeTr6TV0Je15frXH5A
 nIgsrc4gA/38Xav5n8ye+TH3mfoiGi59oyqbjwsfhg6uLO/gPRM/RkZvZjcAds6NUtPo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wtLS3-0000PK-2u for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 08:33:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B3DA241499;
 Mon, 10 Aug 2026 08:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF9E1F00A3A;
 Mon, 10 Aug 2026 08:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786350817;
 bh=BAtyw81+dBMiu7XlLAIQLatNTnzJYfKHmuu6xvYOIyo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=AZ0sNoTsACbmKvxS8u/yWus9xVKhsJ1sw7YXHSY0plOcnJztWWyy6K7DffjeNScfJ
 M1ACXgiigHq/zftVDKz2KWQRGvyhIb+tyw1bJEKJWMSf7zAfFLjUEf69iE9aidV2UK
 tbheV4Pug5nZv+XzwjxuCRiZGSsO9yDsnUCK3y5U18rVHPNC0BIusLbm5uw7Fxmvh3
 pfzhRxc+pyg8ksrAsCAZPvmSRJ8Xo2tl2L5rDjMoQtBTm/Eg8azJOFBogY2QPgJHoB
 0FS0xvBC8mBOthwT7GrgoxXEcYjYsI5TmBe2531CO6lj3KX3kM7EykqimuYVUqzl+r
 5fz1kjp8sjgpg==
Date: Mon, 10 Aug 2026 10:33:32 +0200
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <anmMB2QB_CkGEdN0@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260803200820.393203-1-aalbersh@kernel.org>
 <20260803200820.393203-12-aalbersh@kernel.org>
 <20260804174347.GC14046@lst.de>
 <20260804182453.GA2904385@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260804182453.GA2904385@google.com>
X-Headers-End: 1wtLS3-0000PK-2u
Subject: Re: [f2fs-dev] [PATCH v14 11/21] xfs: don't report dio_mem_align
 and dio_offset_align for fsverity files
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fsverity@lists.linux.dev, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-08-04 18:24:53, Eric Biggers wrote:
> On Tue, Aug 04, 2026 at 07:43:47PM +0200, Christoph Hellwig wrote:
> > On Mon, Aug 03, 2026 at 10:08:01PM +0200, Andrey Albershteyn wrote:
> > > Sashiko.dev reported that while fsverity files falls back to the
> > > buffered IO for Direct I/O, they should not report non-zero values in
> > > dio_mem_align and dio_offset_align, meaning it's not supported.
> > 
> > This doesn't make much sense to me.  If we didn't want to report
> > we'd also want to not set STATX_DIOALIGN | STATX_DIO_READ_ALIGN.
> > But in the end there is very little upside of this while adding
> > extra special cases.
> 
> Zero values in the alignments are defined to mean that DIO is
> unsupported; see statx(2).  It's right to do that here and also set
> STATX_DIOALIGN | STATX_DIO_READ_ALIGN, as that explicitly reports that
> DIO is unsupported.
> 
> Leaving the attribute flags unset would mean not reporting anything at
> all, which could mean DIO either supported or unsupported.
>

I will extend the commit message to include this

> 
> Acked-by: Eric Biggers <ebiggers@kernel.org>

Thanks!

-- 
- Andrey


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

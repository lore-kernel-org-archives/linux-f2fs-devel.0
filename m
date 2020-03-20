Return-Path: <SRS0=ZXqV=5F=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF851C4332E
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Mar 2020 18:00:36 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A172920739;
	Fri, 20 Mar 2020 18:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="CsR/WrIR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="lAhq6RV7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZ9HU316"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A172920739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jFLwi-0003h5-6R; Fri, 20 Mar 2020 18:00:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jFLwh-0003gy-Is
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 20 Mar 2020 18:00:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a2I3dSz8VqRgN5wC68vCR1w44SrDh8uk4wrkjXyMmmY=; b=CsR/WrIRWOEgCblOgDfMvFEnso
 KC75dNhkDHK3G53zCwhrWcj4rWFxJHU6okLCknZYrfRxsESwBp/k/SHMx1M8x+IeFgMEBB4ldYoQ4
 +aMzxcL0dfO4QKOPBK+CmE02xAHWzlqI0pycaT6FB52ke+B/OITSC7Uvj41IEv38GzV4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=a2I3dSz8VqRgN5wC68vCR1w44SrDh8uk4wrkjXyMmmY=; b=lAhq6RV7LiLwtr+azjUy/m2OML
 XE142ET9OqhVatgTpSwbS3ZzcppITDgKOwEm/SqeHRDN46lK6rxR+T1T5BeJL/jiu9+Iaalzg9PzM
 N5HT6dVmpG8CjT6AUupkFki9tldO7Dw/dY8YvZYVC2yNcqQuTMcKc9/nBVq1J2wWG7GY=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jFLwc-00APSa-9D
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 20 Mar 2020 18:00:35 +0000
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 678A120739;
 Fri, 20 Mar 2020 18:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584727219;
 bh=AOHcFFqPmmUrKkBgj3LGw8anyo9Fi+nPIa1g3zqyqMs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NZ9HU316DvAVNcUxlvzbNwg+y2txH2gpkS3rUJxhCWe7t2TNzS4cSz0aP9oXCmCeZ
 lA62gX2HF5PTlSZ1WRtHNFeEZvmAX/Jupq9oBbL1ohyHNdGKoAs/qCozdPyM6IUdHI
 QNBy8s3jas9smKOGMMh5TBeJx1mwdzpN9wtLUJa0=
Date: Fri, 20 Mar 2020 11:00:17 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <20200320180017.GE851@sol.localdomain>
References: <20200320142231.2402-1-willy@infradead.org>
 <20200320142231.2402-13-willy@infradead.org>
 <20200320165828.GB851@sol.localdomain>
 <20200320173040.GB4971@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200320173040.GB4971@bombadil.infradead.org>
X-Headers-End: 1jFLwc-00APSa-9D
Subject: Re: [f2fs-dev] [PATCH v9 12/25] mm: Move end_index check out of
 readahead loop
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
Cc: cluster-devel@redhat.com, linux-mm@kvack.org,
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 William Kucharski <william.kucharski@oracle.com>, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Mar 20, 2020 at 10:30:40AM -0700, Matthew Wilcox wrote:
> On Fri, Mar 20, 2020 at 09:58:28AM -0700, Eric Biggers wrote:
> > On Fri, Mar 20, 2020 at 07:22:18AM -0700, Matthew Wilcox wrote:
> > > +	/* Avoid wrapping to the beginning of the file */
> > > +	if (index + nr_to_read < index)
> > > +		nr_to_read = ULONG_MAX - index + 1;
> > > +	/* Don't read past the page containing the last byte of the file */
> > > +	if (index + nr_to_read >= end_index)
> > > +		nr_to_read = end_index - index + 1;
> > 
> > There seem to be a couple off-by-one errors here.  Shouldn't it be:
> > 
> > 	/* Avoid wrapping to the beginning of the file */
> > 	if (index + nr_to_read < index)
> > 		nr_to_read = ULONG_MAX - index;
> 
> I think it's right.  Imagine that index is ULONG_MAX.  We should read one
> page (the one at ULONG_MAX).  That would be ULONG_MAX - ULONG_MAX + 1.
> 
> > 	/* Don't read past the page containing the last byte of the file */
> > 	if (index + nr_to_read > end_index)
> > 		nr_to_read = end_index - index + 1;
> > 
> > I.e., 'ULONG_MAX - index' rather than 'ULONG_MAX - index + 1', so that
> > 'index + nr_to_read' is then ULONG_MAX rather than overflowed to 0.
> > 
> > Then 'index + nr_to_read > end_index' rather 'index + nr_to_read >= end_index',
> > since otherwise nr_to_read can be increased by 1 rather than decreased or stay
> > the same as expected.
> 
> Ooh, I missed the overflow case here.  It should be:
> 
> +	if (index + nr_to_read - 1 > end_index)
> +		nr_to_read = end_index - index + 1;
> 

But then if someone passes index=0 and nr_to_read=0, this underflows and the
entire file gets read.

The page cache isn't actually supposed to contain a page at index ULONG_MAX,
since MAX_LFS_FILESIZE is at most ((loff_t)ULONG_MAX << PAGE_SHIFT), right?  So
I don't think we need to worry about reading the page with index ULONG_MAX.
I.e. I think it's fine to limit nr_to_read to 'ULONG_MAX - index', if that makes
it easier to avoid an overflow or underflow in the next check.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

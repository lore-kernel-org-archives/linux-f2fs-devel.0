Return-Path: <SRS0=rdq4=3T=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6700C33C9E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 30 Jan 2020 08:00:32 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5EBF2082E;
	Thu, 30 Jan 2020 08:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="HY0i2iJs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="dazf6NTr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bm8CJepr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5EBF2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ix4kZ-0001vJ-Nc; Thu, 30 Jan 2020 08:00:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willy@infradead.org>) id 1ix4kX-0001vA-7c
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Jan 2020 08:00:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XnXHQPHbbFlev6SIF+EFCVeGDG26FYxTO2L/ebYCkAs=; b=HY0i2iJs7+jKrvFS+2AgTixPdF
 /P0KFzbA4a3q7LVaJfNulHx3RHZa7zOkhSR6h4SzYKLsI5wW9u7wINvA2wVspKeIfa+jevP5CPleW
 7Dk/tC6zct2QKgGpXcLyLq58J0YGY+VZ6N+raqDzmQVYY1r1dZfrNO3VDx3TealZITC0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XnXHQPHbbFlev6SIF+EFCVeGDG26FYxTO2L/ebYCkAs=; b=dazf6NTr2xwsygbc2LakPehqUV
 XatUXJ9oBkyOueGVuw3Vruy5NA3zj9BjFde1msUSD7LecegbwDgPu+5xPSGbE/BatXTiiPOe8E2y2
 BPmhLgtjQOst5kSkXWC4kvy3uCnCsasx6lmDPE3qgyqqkw8U4nAH/C5Y0Y+WG+c70Vvc=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1ix4kV-00AMUH-EV
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Jan 2020 08:00:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XnXHQPHbbFlev6SIF+EFCVeGDG26FYxTO2L/ebYCkAs=; b=bm8CJepr+Pj34KELoYqkEhCwX
 fCm7LnxR3yvUvOsU9h+7moHepsw9ZxY6bkv0zxIkXzWmgaOlhZeXRmkU3IHdA31RzYqMF6B3ezEkE
 HZD/42zes2LO55eEMAXR+7dq4wlG047PdjLDu2pKs1B/2GPNh3NrLDcuVusZaSg8RH0zFRGwPcG4D
 U3fiAtVhIvGy4Ikf+Pus5ZSsJqxHtyDXyVK72q1UEpinu8jcZnHaLrnb5SHWYYn5L8ZcDx1iU+q00
 59EPRzfQl88oljwbmQaGuaB+C9h7ksljceO2cJmAxImXrs+f9JGFUmRMf4VqSksHdLlokhYF95CJF
 ep8CWbGiw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1ix4kH-0004zP-OW; Thu, 30 Jan 2020 08:00:13 +0000
Date: Thu, 30 Jan 2020 00:00:13 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Message-ID: <20200130080013.GK6615@bombadil.infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-5-willy@infradead.org>
 <20200129002456.GH18610@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200129002456.GH18610@dread.disaster.area>
X-Headers-End: 1ix4kV-00AMUH-EV
Subject: Re: [f2fs-dev] [PATCH 04/12] mm: Add readahead address space
 operation
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
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jan 29, 2020 at 11:24:56AM +1100, Dave Chinner wrote:
> On Fri, Jan 24, 2020 at 05:35:45PM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > This replaces ->readpages with a saner interface:
> >  - Return the number of pages not read instead of an ignored error code.
> >  - Pages are already in the page cache when ->readahead is called.
> >  - Implementation looks up the pages in the page cache instead of
> >    having them passed in a linked list.
> ....
> > diff --git a/mm/readahead.c b/mm/readahead.c
> > index 5a6676640f20..6d65dae6dad0 100644
> > --- a/mm/readahead.c
> > +++ b/mm/readahead.c
> > @@ -121,7 +121,18 @@ static void read_pages(struct address_space *mapping, struct file *filp,
> >  
> >  	blk_start_plug(&plug);
> >  
> > -	if (mapping->a_ops->readpages) {
> > +	if (mapping->a_ops->readahead) {
> > +		unsigned left = mapping->a_ops->readahead(filp, mapping,
> > +				start, nr_pages);
> > +
> > +		while (left) {
> > +			struct page *page = readahead_page(mapping,
> > +					start + nr_pages - left - 1);
> 
> Off by one? start = 2, nr_pages = 2, left = 1, this looks up the
> page at index 2, which is the one we issued IO on, not the one we
> "left behind" which is at index 3.

Yup.  I originally had:

		while (left--) ...

decided that was too confusing and didn't quite complete that thought.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

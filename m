Return-Path: <SRS0=tJjq=4G=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F220DC34031
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Feb 2020 22:48:41 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBA0822B48;
	Tue, 18 Feb 2020 22:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="JUbiQ1LN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="nOriCaDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA0822B48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j4BfV-0000XR-Be; Tue, 18 Feb 2020 22:48:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <david@fromorbit.com>) id 1j4BfT-0000XK-Ru
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Feb 2020 22:48:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iT5UiGGdEbCzw8iX4J0OTzEDuA+1gDRsed813ZVmjnc=; b=JUbiQ1LNxrruj1sf1oDLz1zcTt
 4rynsMOh08fJHtZAlMJEYROp2no+HlpxdCFHbF4fKtGMH/ANkEuK5l6XMYLTLtXFmuDOme9sy+HMI
 f8cL7nBdnkCMD28jsDfzX8/wNKqVl/C891KGz2TSS6hFusCx/BjY1LrWSiffFSzM1TFs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iT5UiGGdEbCzw8iX4J0OTzEDuA+1gDRsed813ZVmjnc=; b=nOriCaDfcPM/KX+yJ4AOora+J+
 ottQ6Mf50mNj34HeSo62QR09ZOjvES7HMUEbDvuK2XkMFfL/2RgEwcDsg1ojrNufEUMxSOwnzrOSm
 LYiIhAdL9x6EJ1zz9H3s84RhQT++bOI2iFgdzzwl6h1o+16tpFjzTjSOgNzzYsTL1Hvk=;
Received: from mail104.syd.optusnet.com.au ([211.29.132.246])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtp (Exim 4.92.2)
 id 1j4BfQ-007Pv0-19
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 18 Feb 2020 22:48:39 +0000
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au
 [49.179.138.28])
 by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id D144F7E9387;
 Wed, 19 Feb 2020 09:48:29 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1j4BfJ-0003lA-7e; Wed, 19 Feb 2020 09:48:29 +1100
Date: Wed, 19 Feb 2020 09:48:29 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <20200218224829.GU10776@dread.disaster.area>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-5-willy@infradead.org>
 <20200218050824.GJ10776@dread.disaster.area>
 <20200218135736.GP7778@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200218135736.GP7778@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
 a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=alOI8opFAFPe2SRtgw8A:9
 a=xQkswpi2j_EUEYvS:21 a=GSRXKHwoUNCfdhKr:21 a=CjuIK1q_8ugA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Headers-End: 1j4BfQ-007Pv0-19
Subject: Re: [f2fs-dev] [PATCH v6 04/19] mm: Rearrange readahead loop
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

On Tue, Feb 18, 2020 at 05:57:36AM -0800, Matthew Wilcox wrote:
> On Tue, Feb 18, 2020 at 04:08:24PM +1100, Dave Chinner wrote:
> > On Mon, Feb 17, 2020 at 10:45:45AM -0800, Matthew Wilcox wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > Move the declaration of 'page' to inside the loop and move the 'kick
> > > off a fresh batch' code to the end of the function for easier use in
> > > subsequent patches.
> > 
> > Stale? the "kick off" code is moved to the tail of the loop, not the
> > end of the function.
> 
> Braino; I meant to write end of the loop.
> 
> > > @@ -183,14 +183,14 @@ void __do_page_cache_readahead(struct address_space *mapping,
> > >  		page = xa_load(&mapping->i_pages, page_offset);
> > >  		if (page && !xa_is_value(page)) {
> > >  			/*
> > > -			 * Page already present?  Kick off the current batch of
> > > -			 * contiguous pages before continuing with the next
> > > -			 * batch.
> > > +			 * Page already present?  Kick off the current batch
> > > +			 * of contiguous pages before continuing with the
> > > +			 * next batch.  This page may be the one we would
> > > +			 * have intended to mark as Readahead, but we don't
> > > +			 * have a stable reference to this page, and it's
> > > +			 * not worth getting one just for that.
> > >  			 */
> > > -			if (readahead_count(&rac))
> > > -				read_pages(&rac, &page_pool, gfp_mask);
> > > -			rac._nr_pages = 0;
> > > -			continue;
> > > +			goto read;
> > >  		}
> > >  
> > >  		page = __page_cache_alloc(gfp_mask);
> > > @@ -201,6 +201,11 @@ void __do_page_cache_readahead(struct address_space *mapping,
> > >  		if (page_idx == nr_to_read - lookahead_size)
> > >  			SetPageReadahead(page);
> > >  		rac._nr_pages++;
> > > +		continue;
> > > +read:
> > > +		if (readahead_count(&rac))
> > > +			read_pages(&rac, &page_pool, gfp_mask);
> > > +		rac._nr_pages = 0;
> > >  	}
> > 
> > Also, why? This adds a goto from branched code that continues, then
> > adds a continue so the unbranched code doesn't execute the code the
> > goto jumps to. In absence of any explanation, this isn't an
> > improvement and doesn't make any sense...
> 
> I thought I was explaining it ... "for easier use in subsequent patches".

Sorry, my braino there. :) I commented on the problem with the first
part of the sentence, then the rest of the sentence completely
failed to sink in.

-Dave.
-- 
Dave Chinner
david@fromorbit.com


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

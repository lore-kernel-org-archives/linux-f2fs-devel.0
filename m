Return-Path: <SRS0=CXlU=4H=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE88C34022
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Feb 2020 06:40:18 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12968222D9;
	Wed, 19 Feb 2020 06:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="JZAyD0Jq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="klGx1H9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12968222D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j4J1t-0005vo-7U; Wed, 19 Feb 2020 06:40:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <david@fromorbit.com>) id 1j4J1s-0005vg-3j
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Feb 2020 06:40:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xatMJOOjyBdqk824oT38MRhU43KfJLtiqRw6ZkMpY3c=; b=JZAyD0JqcU+swl65/Ghfp4VKfY
 Kpha7uARJv3vit7cskQ1nxVEuTOLRJiObju/GMdo6aQz1MhG+7Dy+XgeLjs2rOqURgbZUwPGuiRbk
 FsyCD0GsI9FPQSE+J88C43E22B0HD1n8zn3xtWzkHyuY+H2DB2Ub2ewgeU7EfTvBZikE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xatMJOOjyBdqk824oT38MRhU43KfJLtiqRw6ZkMpY3c=; b=klGx1H9KhVlC1ogtQBqOABafhA
 /ep4FBeDXiXOOES8SElciiqJ0Hp1yu9ng2w5Pn9xhQCy0VEW+w/Hb0rbCSo7S+6WEaokTAv4lRwCk
 5cKtayfxhPfjtLqIPs99qARtJoWWjvCW+ICGaY8GNq+Wrlk915Vu6S9sPs1vZZkkRY4A=;
Received: from mail105.syd.optusnet.com.au ([211.29.132.249])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtp (Exim 4.92.2)
 id 1j4J1p-00HGVL-Tb
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Feb 2020 06:40:16 +0000
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au
 [49.179.138.28])
 by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 93B223A38C1;
 Wed, 19 Feb 2020 17:40:06 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1j4J1h-0006cP-MZ; Wed, 19 Feb 2020 17:40:05 +1100
Date: Wed, 19 Feb 2020 17:40:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <20200219064005.GL10776@dread.disaster.area>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-31-willy@infradead.org>
 <20200219032900.GE10776@dread.disaster.area>
 <20200219060415.GO24185@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200219060415.GO24185@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
 a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
 a=7-415B0cAAAA:8 a=r7nCFNou5KQKI5VhP1MA:9 a=-52OSV3k6aGjHW0a:21
 a=qFaRso0K34Rwt0Du:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Headers-End: 1j4J1p-00HGVL-Tb
Subject: Re: [f2fs-dev] [PATCH v6 17/19] iomap: Restructure
 iomap_readpages_actor
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

On Tue, Feb 18, 2020 at 10:04:15PM -0800, Matthew Wilcox wrote:
> On Wed, Feb 19, 2020 at 02:29:00PM +1100, Dave Chinner wrote:
> > On Mon, Feb 17, 2020 at 10:46:11AM -0800, Matthew Wilcox wrote:
> > > @@ -418,6 +412,15 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
> > >  		}
> > >  		ret = iomap_readpage_actor(inode, pos + done, length - done,
> > >  				ctx, iomap, srcmap);
> > > +		if (WARN_ON(ret == 0))
> > > +			break;
> > 
> > This error case now leaks ctx->cur_page....
> 
> Yes ... and I see the consequence.  I mean, this is a "shouldn't happen",
> so do we want to put effort into cleanup here ...

Well, the normal thing for XFS is that a production kernel cleans up
and handles the error gracefully with a WARN_ON_ONCE, while a debug
kernel build will chuck a tanty and burn the house down so to make
the developers aware that there is a "should not happen" situation
occurring....

> > > @@ -451,11 +454,7 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
> > >  done:
> > >  	if (ctx.bio)
> > >  		submit_bio(ctx.bio);
> > > -	if (ctx.cur_page) {
> > > -		if (!ctx.cur_page_in_bio)
> > > -			unlock_page(ctx.cur_page);
> > > -		put_page(ctx.cur_page);
> > > -	}
> > > +	BUG_ON(ctx.cur_page);
> > 
> > And so will now trigger both a warn and a bug....
> 
> ... or do we just want to run slap bang into this bug?
> 
> Option 1: Remove the check for 'ret == 0' altogether, as we had it before.
> That puts us into endless loop territory for a failure mode, and it's not
> parallel with iomap_readpage().
> 
> Option 2: Remove the WARN_ON from the check.  Then we just hit the BUG_ON,
> but we don't know why we did it.
> 
> Option 3: Set cur_page to NULL.  We'll hit the WARN_ON, avoid the BUG_ON,
> might end up with a page in the page cache which is never unlocked.

None of these are appealing.

> Option 4: Do the unlock/put page dance before setting the cur_page to NULL.
> We might double-unlock the page.

why would we double unlock the page?

Oh, the readahead cursor doesn't handle the case of partial page
submission, which would result in IO completion unlocking the page.

Ok, that's what the ctx.cur_page_in_bio check is used to detect i.e.
if we've got a page that the readahead cursor points at, and we
haven't actually added it to a bio, then we can leave it to the
read_pages() to unlock and clean up. If it's in a bio, then IO
completion will unlock it and so we only have to drop the submission
reference and move the readahead cursor forwards so read_pages()
doesn't try to unlock this page. i.e:

	/* clean up partial page submission failures */
	if (ctx.cur_page && ctx.cur_page_in_bio) {
		put_page(ctx.cur_page);
		readahead_next(rac);
	}

looks to me like it will handle the case of "ret == 0" in the actor
function just fine.

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

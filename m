Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D18D6CFAC
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jan 2026 23:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sVUf80/1LM1h8ETQKxVa0jHY3HtAFO9BBHH3f7eG/Hs=; b=cjMS/eEPY8pxV/QzPHxXOsITBv
	n962UWQhgWOAczDH+qYgpzhzyc/+DOX2AoOADk9QOdWtRUrsZrujWea79QcwWO0FC5kPeaq32dpHK
	qiivZ8KJc3+F6xXH9vbiWa9xtrqnJdN5D9+K+neSCPn84i7TXjFHM1XkfAx60U1gFHSo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vj44M-0003rW-PJ;
	Thu, 22 Jan 2026 23:26:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1vj44L-0003rP-AB
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jan 2026 23:26:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GwXXNQ8SNbPe7avFy0iFXPcMArPUzkVeRxZw6xq0HW4=; b=VrOyVlfW737Qxgrc8o5SC+bNeP
 8VfuBeKXUvzgKAFbUbWilkmowKiOM2xgX1QPeIUt6wAypTDnOfgwHxGBw+7T743ttwp1grpPF+QXa
 KlfZ0l7c/86A0W2MTRj7Cl3QvC3u0du7S3Zd5q2p+VzcsayEiFMRfoZITh+mgxETrXmA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GwXXNQ8SNbPe7avFy0iFXPcMArPUzkVeRxZw6xq0HW4=; b=PGJ6UMgUYw2aJS/RihZQxEfjGK
 bB6aU51rk5lanOELUMMQSTvxtqNG+Eqf/hbzIEevUdkVAxJJtfcxW1CkSmeMo5VDbmBwgRtDyfIlZ
 +mktrZubUgrau7qtQaQblKQ6DRfmsuZ/t4xId11bUMZIa6huN1hjuf4Eg5CuIwTp7NjE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vj44K-0001bc-Q6 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jan 2026 23:26:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 785DE40AF7;
 Thu, 22 Jan 2026 23:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13697C116C6;
 Thu, 22 Jan 2026 23:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769124378;
 bh=XGFkGzSWYNYNegHCuCLWkagl8o1IXw5VGAe9BlYwAeo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YCTlFsh/PvlHEsFrvzeBnozx61sK5QqaeiMfQ/Wc+Sop7ADqPwRPj93gz+c7Ywx9H
 phe4+Vp6OYAWWGe6mxS5+brmNZKJfC3d7Vbnq/jXrPUWzOBB4T7rV36VoJlKzWAHX+
 y9+fHgwFz/eFYVKvs7pcSTGBYkCGbFjNPsA6DDjo46VsA0esXG4XsE37Szqpe7KF/r
 dDS4hFd1ILM9viLxHowpQIrUCJTa6v2yzo/wpy+X6rzn/1kfdSUklKeJfnFm8Veg5u
 6uSHTF+uCfTCqsto2aZddrU23DQAZMcA4pvH4e+86H8Mp29o7IhPRLq/bmrwxo/1/t
 wkfv3h+j1kuuw==
Date: Thu, 22 Jan 2026 23:26:16 +0000
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <aXKyGIH-ZuvCI6h5@google.com>
References: <20251121014202.1969909-1-jaegeuk@kernel.org>
 <aSALfvLUObUGSx-e@infradead.org> <aSCpzRW8mUhNnjHB@google.com>
 <aXHhFN-feFYFcKYu@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aXHhFN-feFYFcKYu@infradead.org>
X-Headers-End: 1vj44K-0001bc-Q6
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: improve readahead for
 POSIX_FADV_WILLNEED
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 01/22, Christoph Hellwig wrote:
> On Fri, Nov 21, 2025 at 06:05:01PM +0000, Jaegeuk Kim wrote:
> > On 11/20, Christoph Hellwig wrote:
> > > On Fri, Nov 21, 2025 at 01:42:01AM +0000, Jaegeuk Kim wrote:
> > > > This patch boosts readahead for POSIX_FADV_WILLNEED.
> > > 
> > > How?  That's not a good changelog.
> > > 
> > > Also open coding the read-ahead logic is not a good idea.  The only
> > > f2fs-specific bits are the compression check, and the extent precaching,
> > > but you surely should be able to share a read-ahead helper with common
> > > code instead of duplicating the logic.
> > 
> > Ok, let me try to write up and post a generic version of the changes.
> 
> Did this go anywhere?

Here.

https://lore.kernel.org/lkml/20251202013212.964298-1-jaegeuk@kernel.org/


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

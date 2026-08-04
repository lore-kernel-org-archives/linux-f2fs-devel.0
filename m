Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55851C5518F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 17:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rDtY6BsKE4RdtH9HONkTgc4udQyD6yMKZNWJByY6Ooc=; b=SfrPkldUbKxbF+sHza2Iojd9qK
	iGRpS66hdW+lqFIpuy0fV5zIt0Ji1I0I9GrZKold8f4IfjqrcIZa7GVqTf4b54EL10Oc65Vj71BRp
	qIfLSQN+SRI2orAHvUG/Oo9+qV2K3BZC/aovUOgYOADZLGGK/c8PpBv0m16tiPlkpidA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrJIA-00017a-4U;
	Tue, 04 Aug 2026 17:51:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wrJI8-00017S-2E
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 17:51:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I8LRWH1bi3T0NweVTozAAvIupKrxRjTY2/DR6XsfcMQ=; b=gu98IyIjRgUkaLDHcbgVdnb7S3
 Sz+LLgW7ygHuslg85UemLwjfFd4hjAnjMRl2TlUs5UYE8vp/0qgBd/EF8wxtOHx+ivYdnLxRw64E5
 9NayCJS4MkszAa8NaXBpBNE0grlGLTOLfWItp34lW1S1pvTBcH7P90LoXjZXvsLf9m08=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=I8LRWH1bi3T0NweVTozAAvIupKrxRjTY2/DR6XsfcMQ=; b=R7ug2QAo5DSznVOD+3JmLMoU+B
 sBTwUyIb0J99ZsCdkfwfTIJUVexVOPMDmLxlKMhTtlULmhydMzg1wQjR3iY7+tLQ/5GqZnoPkQro9
 7CYyM3i7mWaLkx+WESivkcs0KpexhwJVE2yobwKmE21A0I+YXKDdZdvGs/R1RLkTebn0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrJI8-0001Aa-Br for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 17:51:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with UTF8SMTP id CEF0643F42;
 Tue,  4 Aug 2026 17:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A3AE21F000E9;
 Tue,  4 Aug 2026 17:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785865858;
 bh=I8LRWH1bi3T0NweVTozAAvIupKrxRjTY2/DR6XsfcMQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=m5IdKNugeqjKEi80s7/8HVn0HhRqgSmpAUwVfhF7lEwEt01cIIdZFGH1TPlSgXoG4
 n4Gqj2oxtEXTz/SdBs8zvo5Q0S7BihKBmPf/L/ewhvM9yFMKmAwm+nTWo7MxWldluv
 0LAFKyJWRKKm1NrlfOgQiVNFlXef+4UnlCIaajYZZohCNqojSyM6WTwfwq8EqvdM/8
 1DZ175597j8AGHtL9/Rl02fg6UNrXCNtk13Y8p9fxj2wBuUOERImKgJsSAvUTDv+h7
 F53YaYAe+mQjnTFzlrj4LtabzalCuj7ORZluhc3ywBi56EnBS3qOFyv85Nf2xkPple
 rbMDYQxY3k1Ew==
Date: Tue, 4 Aug 2026 10:50:58 -0700
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260804175058.GH3556460@frogsfrogsfrogs>
References: <20260803200820.393203-1-aalbersh@kernel.org>
 <20260803200820.393203-12-aalbersh@kernel.org>
 <20260804174347.GC14046@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260804174347.GC14046@lst.de>
X-Headers-End: 1wrJI8-0001Aa-Br
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Aug 04, 2026 at 07:43:47PM +0200, Christoph Hellwig wrote:
> On Mon, Aug 03, 2026 at 10:08:01PM +0200, Andrey Albershteyn wrote:
> > Sashiko.dev reported that while fsverity files falls back to the
> > buffered IO for Direct I/O, they should not report non-zero values in
> > dio_mem_align and dio_offset_align, meaning it's not supported.
> 
> This doesn't make much sense to me.  If we didn't want to report
> we'd also want to not set STATX_DIOALIGN | STATX_DIO_READ_ALIGN.
> But in the end there is very little upside of this while adding
> extra special cases.

directio is supported; the implementation merely falls back to reading
through the page cache.  Unless you're saying that xfs shouldn't
shouldn't set FMODE_CAN_ODIRECT for fsverity files?  But that also
doesn't sound right.

Personally I think sashaniko is full of it and this whole patch should
be dropped.

--D


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

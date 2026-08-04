Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97546C55184
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 18:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jrd/2D4M3WaTZwFZ6wg7z4zlduP2dyA5MxlvDhyxUEs=; b=ESMWmEeQXAfDJso9UZluzeu0E/
	xxFXf7Yp1o3dqtltN6nViJOgjvkqBbhWZmR1l3067v6haqcMyeuZW8HmK230DIqY6WTTRm1v7iWOg
	dZy+C99OUS+Auq3DeN82Z843bS1LX67YM/chlHnHUdeEozghLOS2oKRVWGiMDOreWXZI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrJp5-0001JS-3u;
	Tue, 04 Aug 2026 18:25:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wrJp3-0001JD-7D
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 18:25:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ABzXFS1cHdOS7LhNVaYwD3Z82Do0sMylapiPW/GnJdo=; b=HKLCqLjpVgTwJk5iuSlXHkHcEm
 FuFhJMqLb9U3NRE47pmYMc7VwZDNOjhCAwb14PSFtCfdPDFNDiUwl3PJgJgvXoXohJkefbThzznlh
 PMUpAySyF0IjzcuouhNM0JT9IyFqJaZQdbfquyodOYIgPDD/gH6bOcJ+EER1IwCxMz8k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ABzXFS1cHdOS7LhNVaYwD3Z82Do0sMylapiPW/GnJdo=; b=mzBY8QQOgDIQkknf7o/oQZUss8
 UUbB9iT9YuYk5pB5cUwg9w9NY6QB1Deb6NkfBM2Khjo5gnyKkNpgSA4b/JS00xCUWCKTVy3vDsCeY
 z9F0PPYHauUjyxZZc/BSILMiS8ZJYqtIAI1THg8Tu0A+0OK1nPipfLDrIW+BX8U1ZPiw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrJp2-0000yk-6C for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 18:25:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 49C454179A;
 Tue,  4 Aug 2026 18:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0DC1F000E9;
 Tue,  4 Aug 2026 18:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785867895;
 bh=ABzXFS1cHdOS7LhNVaYwD3Z82Do0sMylapiPW/GnJdo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=e3G4Q9Q3CSdHX6kBynKoFfnLeUWV2Kd0bDryv2PEUvwl95G15JEK/5Yp8egrYuprx
 dmHi6DfgfBEEn93ILJz0C8AXFd5QxE5/Z/6uqhF942ktUDNpPaRm9Ji8e9istL+8Mb
 GMwlfmnSyqqYhTt0hN84H989qQIUAc1Mxvy7YcIhYaMSymx3XWEkQEZJwoILMTk+Dn
 dqRz+wkMgQyIUVencHoEQKxP3/yPbhsssdqb36a5hsKJUj2wX+sfhsFbp9mx0i+6SJ
 Qzqqi2Rk4iQI5wqTRGy2DnQeuKb3BtE/WiKMw68lf05ZJn3qj32fuf1PU7b3LnuzF5
 CQbY+szG+4JJw==
Date: Tue, 4 Aug 2026 18:24:53 +0000
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260804182453.GA2904385@google.com>
References: <20260803200820.393203-1-aalbersh@kernel.org>
 <20260803200820.393203-12-aalbersh@kernel.org>
 <20260804174347.GC14046@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260804174347.GC14046@lst.de>
X-Headers-End: 1wrJp2-0000yk-6C
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, Andrey Albershteyn <aalbersh@kernel.org>,
 djwong@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
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

Zero values in the alignments are defined to mean that DIO is
unsupported; see statx(2).  It's right to do that here and also set
STATX_DIOALIGN | STATX_DIO_READ_ALIGN, as that explicitly reports that
DIO is unsupported.

Leaving the attribute flags unset would mean not reporting anything at
all, which could mean DIO either supported or unsupported.

Acked-by: Eric Biggers <ebiggers@kernel.org>

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

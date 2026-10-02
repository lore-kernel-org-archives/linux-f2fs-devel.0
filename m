Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082FECA5FDD
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  2 Oct 2026 23:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2/5g/kQaaC8bkbj3EeDosgeJqXbskeIm037S06GB9KU=; b=l33RZlXFEIrCH3myo59is2mNZP
	xXN9XAECJ0Yxz6pYwCPKfchoTNnDK1n+9SwOhPvQeA+z5VXKrgtJFeX1z2t8kRtRzmtsbEJJL7ybN
	lyvYVbg58y181PLcsTrTeOkQB0g6hvqBJWkx+xUEY5Wzhu3A7Ie2TcyxgqdQGxx1wKco=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCmhP-0004rp-9B;
	Fri, 02 Oct 2026 23:29:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1xCmhO-0004rj-EI
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 23:29:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9DCAvEBt+9vx1zK/ZDVHfLqQ3aCPVbKhtlr64cyEutM=; b=Zu4Sx/i4Te4+RA/ypbuc5sAPFr
 3fpBEhiuS1OqOK1nNw6kbU2VoLOL0ZCoNFixsr55eSJEEgteCF/i6JA37iqo74iHmdkrSjvcf98vb
 x+O3pj8MXPRUVdw84Oa1RzyW87dRZDU17WWkIfZozI13jHhZQJ6gLRKKYBHPG8wSKXEk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9DCAvEBt+9vx1zK/ZDVHfLqQ3aCPVbKhtlr64cyEutM=; b=Qvuaka6GVEUBzXZtD7Ex4nEgm9
 G42LkTnVpgNASAHtp64J/7k/GEP23sxLuhrXQylQM688Lq7VE6HdYjlJL1KmUyw9AHOWOofiIraiF
 gDYPGyjBOj2d2NKQ1m/a98plXiGlfm39N074ui+W+GsK+jTdYC7rOMfyXKIkosdR1zKw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xCmhO-0004j3-FZ for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 23:29:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2E39E43DDB;
 Fri,  2 Oct 2026 23:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96871F000FF;
 Fri,  2 Oct 2026 23:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790983789;
 bh=9DCAvEBt+9vx1zK/ZDVHfLqQ3aCPVbKhtlr64cyEutM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=MUlYLozifUr2EaRMqWwVpFFfAD7TRXCyxFN7IGaYRA1KcMOOYPkNaX025vNna41yb
 3v7wW95xvSNmy7EyuEOBqwUj8Xcvm2xX2ZZgmEcicZqZXt2LgEpzO1vlUEY7nl6v+h
 OLXsJHgVH+uNR1vHztzj8vILzXnCG3u4dm942Drr4ZEsa/quODy+fXQOYKuFJT7afQ
 wbWdjnSM/HUsHLq0Sjc69+TbXBqxrejyy4PW+8B8WVRhRaSCH2tC7ik6noCuyoBR5t
 vifNyhegZZF4PyURnmI6KWuJOJ8Sqkv4d6VYdC03fF1CI9CWtizklcUwafBpZlYsUf
 rF3f1Ozyv7Ajg==
Date: Fri, 2 Oct 2026 16:29:34 -0700
To: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
Message-ID: <20261002232934.GB15366@quark>
References: <20261002114338.12073-1-nsvatoslav515@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261002114338.12073-1-nsvatoslav515@gmail.com>
X-Headers-End: 1xCmhO-0004j3-FZ
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: convert pagecache_read() to use
 folios
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Oct 02, 2026 at 02:43:37PM +0300, Svyatoslav Nikolenko wrote:
> Replace page-based APIs with folio equivalents in pagecache_read()
> to migrate fs/f2fs/verity.c away from struct page.
> 
> Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>

This will conflict with
https://lore.kernel.org/fsverity/20261002223705.2175542-5-aalbersh@kernel.org

I'm checking if that one will go into 7.4.  If so, this one won't be
needed.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

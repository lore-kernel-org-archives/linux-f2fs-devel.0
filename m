Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5486CD5BBF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 25 May 2026 05:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HH+WDA0dus5fbNcG4iI8B4C/5zsYnKvTSqi5FF0pBHQ=; b=h2cZoqGULcrYzRraT1cNbuXImE
	JeY3cTEd/KJT7jjEe1hnn89GkGM0KlWx8m973xJCYFk24jJUMqhW/tygtp2E4xviml8rafvrMbUoL
	ZDkAArmxJ3zGd7f1gr/bVlK4y/JqF8Uu2RroF5WS2MH06ZO66XF5M11zl7N2mNLFnggM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wRNxr-0001EM-Sj;
	Mon, 25 May 2026 05:34:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+728b97dfb722ff21c2bb+8310+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wRNxQ-0001Dt-LJ for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 May 2026 05:34:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JI2Zr6lMZzUwZhHfb31tRyecuT+FmnHjjuc47PlOF88=; b=SrYBORpcoiRLFJFZrBGAcATbbq
 L5wEK77oL487F50cex87/H+AgCGj+ADv9qRtcxgP0X85QuMvFfYaFb0U0GNTdrsd0Qpg4VAanHlZb
 fPp6mCqOL97HX2zZlw+d4gisDkdmVPtJYpB86ehAA3jgYs06776HfhHXbq2Bb0TOYdZM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JI2Zr6lMZzUwZhHfb31tRyecuT+FmnHjjuc47PlOF88=; b=HX3dftXTrmptReOHUZwLLPzlsy
 UhsVizp0ztttOVbGaXOFZD97dddL/UbVUYBY/aUPkp4LlhGXCQHHSk2DWZOmad103ddFEi+QpVytM
 uHmE8XzgtrAfGRpB7S2S0Kgf0j5Yl6YzupYuYaGenr3Q8H9ryOQzBCcjda1uQt61iVRA=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRNxO-0000k2-PA for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 May 2026 05:34:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JI2Zr6lMZzUwZhHfb31tRyecuT+FmnHjjuc47PlOF88=; b=fbl7TUFKkiazs7kdxhPNZcZYtr
 UoSs6GmpWA4sd06xY0mSmOJbz1vTEv0NX/in/duJG0tl7QLnFyjlGUNxwr7I0TWbZUC+A4s9djYdU
 4bhcVb7ocFo2e1fhGL4xiWcqzMti7C4Mb0ixnz6UJM6Y63h5ng5Uz/dP1ozLEUkkx38vBNm6aa+7j
 gD9BXH6jklrKy4duOsz5t3vPHgHry/+IC9DIIZRqldDVethOXzNRpRy5XYaveSU4JU4HQR1uEqbdF
 3FObmy1NIUnEwGbzE0qkkHl70qcM9kbu0TNXQ4He5AkG+OM4yrslhu738ntt5f7h43S58pFLVF2n2
 bTmAfl+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wRNxD-0000000GKaP-0cbs;
 Mon, 25 May 2026 05:34:19 +0000
Date: Sun, 24 May 2026 22:34:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <ahPfWx04WCGYLCka@infradead.org>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com> <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag9D6_7dttbDGHZ6@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ag9D6_7dttbDGHZ6@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wRNxO-0000k2-PA
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
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
Cc: Theodore Tso <tytso@mit.edu>, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 Akilesh Kailash <akailash@google.com>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, May 21, 2026 at 06:42:03PM +0100, Matthew Wilcox wrote:
> On Thu, May 21, 2026 at 11:57:48AM -0400, Theodore Tso wrote:
> > So let me get this straight.  This is a magic xattr interface which is
> > not even persisted in the file system, but instead sets a 32-bit
> > bitmask in the struct inode which disappears once the inode gets
> > flushed from the inode stack.  And it uses a generic xattr name,
> > "user.fadvise".
> > 
> > There's no way in *hell* any other file system is likely to adopt such
> > a broken interface, so why didn't you just use an ioctl to set this
> > magic f2fs-specific flag?
> 
> I mean, yes, this API is horrendous.  But it's just another example of
> f2fs thinking it's somehow special and not just enabling large folios
> like other filesystems do.  This hurts everyone, not just people who use
> f2fs.

Yes.  And assuming we'd have a legit use to unconditionally use smaller
folios for given files we'd really need to control it in the MM.  Even
if it ends up being a Android-only hack.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

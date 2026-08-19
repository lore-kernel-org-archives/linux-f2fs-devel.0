Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F23C5DF6D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Aug 2026 05:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V+SuTZWdeA94CP6nr1wyTkHsNhCieyWzOlq8xT7xOQM=; b=R7EDc76oeqv/YotWHVdlBetAUl
	hyJtXPClkOexiPZRGCdxmNOnf0T25nHmJO98D0lOFBREd48xTSJ8/EwLSPjBtOOr/LbB2NUGu/K7H
	wmUjAMfaJTxiZ7MSCMKBnzEbRZZ8iNNY517m58kK7YWwcYvL8C/Ixp/96fvBbNavfPA4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwZBA-0004Cf-Oh;
	Wed, 19 Aug 2026 05:49:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wwZB9-0004CQ-Mg
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 05:49:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BqQFGh6at0P1KMA6+TIyYRFt9G+i66qmqF4I+cIAolk=; b=E+RoUbkI8fcDccryMIdMoZpzJd
 SAaObOj0/IaTYIklzBxvzUsncIGRKM1pxa2ml5/Y79kQdBc3Jo013+SJbInBwCP9mqr2IN/ZSFHIV
 C5AyuQN/10bq18bI3RD7JYmp06zVSHVuiMgeddvsWVyW3OoG8RYt3s9TayrGqe27saEc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BqQFGh6at0P1KMA6+TIyYRFt9G+i66qmqF4I+cIAolk=; b=iUAo0b3D32JlTMTwaQnUEBKeQ3
 iKJBHRslx8YwxphFgUjgpctRmntm08jwewNFoSIRqjUPoKdhzUgDHY4zsdzyJx9AHHr1kjjx57SaG
 9/v+76W+/4NRmPT/69PPvHAjW3Urr8BO6lWb9ZG1PIKqylna3KX7hZTnPQ+B5q2No6WQ=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwZBC-0004mC-HU for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 05:49:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3FA9068CFE; Wed, 19 Aug 2026 07:49:25 +0200 (CEST)
Date: Wed, 19 Aug 2026 07:49:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260819054925.GA32764@lst.de>
References: <20260814092448.1818082-1-aalbersh@kernel.org>
 <20260817070240.GA17371@lst.de>
 <aoMZaqbKxmp9lhKs@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aoMZaqbKxmp9lhKs@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wwZBC-0004mC-HU
Subject: Re: [f2fs-dev] [PATCH v15 00/25] fs-verity support for XFS with
 post EOF merkle tree
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
Cc: fsverity@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
 linux-ext4@vger.kernel.org, djwong@kernel.org,
 Carlos Maiolino <cem@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>,
 linux-xfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Aug 17, 2026 at 05:37:13PM +0200, Andrey Albershteyn wrote:
> > So let's hash
> > out how we want to handle this for the 7.4-rc merge window after the
> > dust for the current merges settles.
> 
> 7.3-rc?

I hope to have a version for review/comments out as soon as all
relevant trees are pulled by Linus.  Right now only the block tree
is still missing.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

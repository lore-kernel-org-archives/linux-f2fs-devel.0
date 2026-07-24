Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A72C531F9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 23:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c6N6xDk/HRMA4j+FMUEOKkJ6bPxioO5EfPGBX2MTKwY=; b=DBJjGAiC9QfOpOOzuIouuuhKbj
	fyXYWmGIfRheZ0qvbHNxzLXzpbAvckdNq1R0acSmMEgYe5IgEqOw0LyKKwPyqrl1RDDYzM6qHxIif
	5q48BuWeMhEt64ZXp5T7defKy7tNOfyj3aLMb4a4jpVGcF0AlBgSNryDWgAzflEzhcvc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnPaP-0008VH-9h;
	Fri, 24 Jul 2026 23:45:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wnPaN-0008V9-Tt
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 23:45:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UButzxL7Kw/j5kopPBpah4WDYkmBhSrmLzL/921+7Ng=; b=KfuA/GSbYCbxOfdy/Md6ahc+aF
 1pDmZpXtIj0i69yKlBMn+VSBhadzEYLXSeDBmZHbQgTwPIU5p5+9FkGM3UkOcC+DgHLKfKXG3f/dN
 FCg2zzytmw//DI4N8UigG4c9koL3Rd4fHnsfC1pn0ZNV5wojLIOuQk+s3Wtu2IIKqYCU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UButzxL7Kw/j5kopPBpah4WDYkmBhSrmLzL/921+7Ng=; b=Oe7zG652VIU0jKp4kO9O8gYrjv
 Dv/45+SMlojEamjDPPSazyRyGsfoJIuX/bll2/jZD7YXteHI32aK8j/coTC+sm0QvhmqAtaNUQg24
 ff+FtS7uPEyDgPAEp04PV1qSS0UE2LgENCi8ME+WnHM1NFZHmr9PDNxexypToz3LMHrM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnPaO-0007QP-4P for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 23:45:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 724C360A60;
 Fri, 24 Jul 2026 23:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53B01F000E9;
 Fri, 24 Jul 2026 23:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784936742;
 bh=UButzxL7Kw/j5kopPBpah4WDYkmBhSrmLzL/921+7Ng=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nm7MZYo9+tnTIlCeT+kz73KmCi3UyfhyR8CfNACCQlOic6dpLpdkLGe1Qm3lgu6ZW
 QrDtWKBRfpWwvRUQxzekj/1Jh50mBNyhveWcEtk00jeQTMnJgp16mUwMGI6GpSRszy
 z2GtEJTJllfyh5xb8aHxTHgwP4qej6KhoHAE+RdwyooRJQSSNiY9Ry3G7p3i8Q7cKJ
 0b91gJ6QeJSGvUa4OJZ1pQPrldqAb1MNi76N01EwAg5wbxD51W1tPHkoD640Pmw8Ij
 ETpvlh6FR7maGjn7oDpZ6pV0XnnC25YH0KmjgRApUoKES04uNKppnq7Cd6WWtX8J+R
 TPvRzJ0yoJJ2g==
Date: Fri, 24 Jul 2026 16:43:49 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260724234349.GC1901@sol>
References: <20260721184346.416657-1-aalbersh@kernel.org>
 <20260721184346.416657-9-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260721184346.416657-9-aalbersh@kernel.org>
X-Headers-End: 1wnPaO-0007QP-4P
Subject: Re: [f2fs-dev] [PATCH v13 08/23] fsverity: hoist statx reporting of
 fs-verity flag
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
Cc: fsverity@lists.linux.dev, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jul 21, 2026 at 08:40:45PM +0200, Andrey Albershteyn wrote:
> All filesystems supporting fsverity report this status by checking inode
> flag. Also, BTRFS was missing stat->attributes_mask, which is fixed now.
> 
> Fixes: 146054090b08 ("btrfs: initial fsverity support")
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/btrfs/inode.c | 3 ---
>  fs/ext4/inode.c  | 5 +----
>  fs/f2fs/file.c   | 5 +----
>  fs/stat.c        | 6 +++++-
>  4 files changed, 7 insertions(+), 12 deletions(-)

Acked-by: Eric Biggers <ebiggers@kernel.org>

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

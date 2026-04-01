Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098591112244
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Apr 2026 23:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r65PkeAkiVSwOjCtmMWaxeKu+vltu0edYkFry4LTROo=; b=WL8FTPs6OIwyEaFKYbws5Xh8iX
	fgjvuBMAQQXWyAdJ0k0yppLqxbjqxJ7XVpzn/luyeX7eoJxS60jOA+oNGbdzEcqEhBPaW9yaCyQUL
	14wFdCqspJq/eJLfxNWf6CP0y08Ni1pPiJIDY5imKRZS0gtr+R1NzaaAJ4xz76Cze8xM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w85Fg-00067K-6f;
	Wed, 01 Apr 2026 23:45:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1w85FH-00066w-9R
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Apr 2026 23:45:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M4ymidRqv9MfyK6EduM1i6A+RdpLxJNsmcm2ZO3+YWM=; b=hkh+BKLm3G3UAix6T3v3lkZLgm
 pkeKUaxHnEac6O7fDAAtOX5ysOxbKlrUwvyx+9UW84edigfbNB9XVtP0hV7+TLtjIZnepGStiRWAX
 SBA+pWJNjJ3knlcyOO8BsKo3WwlXttVjKY+JJ5tIoEaSY7tN1vm3TdscaeB3BqvEm+UE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M4ymidRqv9MfyK6EduM1i6A+RdpLxJNsmcm2ZO3+YWM=; b=GFRdRcW7oRVtuGXBX0EkhsubQy
 krAqNgkoTdv4NTOAyUfn3IvckoauexT3eOntVKLgdkIiLFGCbz0mJHe2Nrp/9FhSyOymnVkXJm+Ds
 z22imKowJKm9FSYZQBsJHtvkl0Y9ZTt7gneWL1Uu4iq5SSDZG0H1C7MJgMUaGZ4mImhQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w85FG-0008Ct-Rh for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Apr 2026 23:45:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8EAFE600CB;
 Wed,  1 Apr 2026 23:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DD3C4CEF7;
 Wed,  1 Apr 2026 23:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775087099;
 bh=I3xgUwZ2fScTOSKu5gwFFScGgHMI2afVQxSZDC/mXks=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kLTTuWYjGkfeV2FsJ7DX/P+c0a9k/HMpIiBn0q0Ya39n328rSNCwdilnVV8I4EvH/
 MNl2/Cm7tlfnJbbX6m2CQKX47RpBqz/zbe1U76f/HBCqhsiBTSUrqSdZhKLQQ88nEP
 GfCnBWR1LjIhUW/RfWd+yNwtwwe6ZL0U76pWLtHfZvGEqpywJHzlu2/Qi/bNEKl9uS
 NUC7IzAlAMFGGqLjvFOTtULL1lUQ/l6DeOynk4NylDpT4dl6lkuxiC9awuGV6MHIXK
 8+KtBWeqR4Bpu+iicWHk0h6WgL6gfAS6TMkHzsjhOq3FPPqWzZIzQDTKqklnfF1Xe4
 vBzLmiZ/NMdGw==
Date: Wed, 1 Apr 2026 16:44:57 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260401234457.GB14247@quark>
References: <20260331212827.2631020-1-aalbersh@kernel.org>
 <20260331212827.2631020-6-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260331212827.2631020-6-aalbersh@kernel.org>
X-Headers-End: 1w85FG-0008Ct-Rh
Subject: Re: [f2fs-dev] [PATCH v6 05/22] fsverity: hoist pagecache_read from
 f2fs/ext4 to fsverity
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

On Tue, Mar 31, 2026 at 11:28:06PM +0200, Andrey Albershteyn wrote:
> This is the same function to read from pageache. XFS will also need
> this, so move this to core fsverity.
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

Acked-by: Eric Biggers <ebiggers@kernel.org>

Would be worth mentioning that the ext4 and f2fs copies of this function
had diverged slightly, though.  This patch takes ext4's implementation
of doing it folio-by-folio, which seems like the right choice.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

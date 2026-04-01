Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B4710FCAEA
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Apr 2026 22:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gHcddAB1fDXUrkVeMZzE+amF1VuTTFWFEEgLEnmsP1c=; b=QNM/vDvm4VJ6Tte9lIIK8GkIVX
	EInCoIwToXZMnzYi9/WHe2n+enZC0q+trQbj1XPtMUEjUmFZ79TgkbGQ4QXwhuHZ4RlyQpzKyNx6H
	AcRCjBVSwBR6+DauNamVqruWeRUrl7x1xfvbhzE7E1viOF/TJddZUhTDwIOfjpmzh974=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w83eK-0001VP-5Q;
	Wed, 01 Apr 2026 22:02:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1w83eJ-0001VJ-3x
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Apr 2026 22:02:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6Nk+nzEvE8Lbp47gBX8ekto2tSuUHH2Zg7bpzr2JaZY=; b=lBrQRxewPfDtLP1X98u3c9FY+G
 Hg7xgeJ22jRoLZmHNDYFVXUpNT8oKJ/CaHUjQ/ZZw7ZGhuv0W7K2R6Hlg7yBI8BLPD7oWHp1lvVBd
 mXhATnWUHy1tis0EAsOMmBuhYP3QrMCyl28LiABIFBU/55sk9m53SjkLVqFAPAby8aio=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6Nk+nzEvE8Lbp47gBX8ekto2tSuUHH2Zg7bpzr2JaZY=; b=MnvzbMPwSKLmU8PwNNYNw++LVV
 ujkXYYzyxuk87GoR9E7+MGtq7x/Icz5Imrr7/pr7FGtUSj6LOoqL2G3l2faxxj9jGgRkB1nQpDGpD
 cYXQ+Pa8IqPkqYeAJMsGPP++SMVT1fzjgqhUAXdY11fYgiK0GVcmADHgElKxKgDefU74=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w83eI-0002AT-LH for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Apr 2026 22:02:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 145AE4070E;
 Wed,  1 Apr 2026 22:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C417C4CEF7;
 Wed,  1 Apr 2026 22:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775080963;
 bh=XLe7iwOJXHsWYPpv5bKbhLQ02plXgKrNwG0uXVLyzcU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lv3WUjD5WCLSg7eVifiAgrFgfAdm8yUbb47Bzb+d3FXc476Hp55Aj+/MrhYGuemzn
 2TwtfnzU+nBNNHzir/JRbRqq7b/473/tN1dk1rNc4tzw1HVIXTbBVlZzdhYD/kOs/R
 ndAtx8tw4TcCo23N75bwh9ynZ2Wdr8QtHA5o5AxbWmSpLW4WoiCGOXioDlgEm01gCS
 MEl7SXfy8+qib4he4f01aW68NkUSQGUxgDUNGcJ9NBrPlBaZluupNrfzLHn0K66Y8r
 rOl6E4oFzqGegIkTEPvnicsld4HcK02IV+pLKXoK1Wn6B0BUANnot3sU50dbNmtRPK
 0RPQ3EJ2+Caeg==
Date: Wed, 1 Apr 2026 15:02:41 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260401220241.GG2466@quark>
References: <20260331212827.2631020-1-aalbersh@kernel.org>
 <20260331212827.2631020-3-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260331212827.2631020-3-aalbersh@kernel.org>
X-Headers-End: 1w83eI-0002AT-LH
Subject: Re: [f2fs-dev] [PATCH v6 02/22] fsverity: expose
 ensure_fsverity_info()
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

On Tue, Mar 31, 2026 at 11:28:03PM +0200, Andrey Albershteyn wrote:
> This function will be used by XFS's scrub to force fsverity activation,
> therefore, to read fsverity context.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> ---

Acked-by: Eric Biggers <ebiggers@kernel.org>

> +/**
> + * fsverity_ensure_verity_info() - create verity info if it's not in memory yet
> + * @inode: the inode for which verity info should be created
> + *
> + * Ensure this inode has verity info attached to it. Read fsverity descriptor
> + * and creates verity based on that. Inodes opened outside of
> + * file_operations->open will not have any verity info attached. This
> + * info is required for any fsverity related operations.
> + *
> + * Return: 0 on success, -errno on failure
> + */
> +int fsverity_ensure_verity_info(struct inode *inode);

As Christoph mentioned, fs/verity/ uses the convention of the kerneldoc
for functions being above the function definition.

I think the comment could also be clearer:

> create verity info if it's not in memory yet

Maybe "cache verity info if it's not already cached", to avoid potential
confusion with enabling fsverity on the file.

> Ensure this inode has verity info attached to it.

Maybe add: "It's assumed the inode already has fsverity enabled."

> Inodes opened outside of file_operations->open will not have any
> verity info attached. This info is required for any fsverity
> related operations.

The first sentence could be misinterpreted as saying that this function
won't do anything in that case.  The second sentence isn't clear what
counts as "any fsverity related operation".  Also "opened" doesn't seem
like the right word to use when talking about a filesystem-internal read
that occurs without a file descriptor having been opened.

Maybe replace with:

* This needs to be called at least once before any of the inode's data
* can be verified (and thus read at all) or the inode's fsverity digest
* retrieved.  fsverity_file_open() calls this already, which handles
* normal file accesses.  If a filesystem does any internal (i.e. not
* associated with a file descriptor) reads of the file's data or
* fsverity digest, it must call this explicitly before doing so.

By the way, should there be a patch that converts
ovl_ensure_verity_loaded() to use this?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

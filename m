Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7B31112244
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  1 Apr 2026 23:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+kf7LhZOxiQb5S+RJaB8aoZsPtwFNe6ekCinhKN+HCs=; b=jm0zTqKClAwpcf96NT2M153coL
	jq3wYh93qwFaed47UjDhrX2sI8dk0kiz8go8A4TbYGY+GwnA1ZltUXvGPuiHVBJtTvR1NfugPT0OL
	NDy3ip2HODL6YpI4ZTK0BL4JiSNEGg5D4UBsRmsbShvZzuXYOsq+qkv1f2sZOgFTO4e0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w85RM-0001TK-7f;
	Wed, 01 Apr 2026 23:57:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1w85R8-0001S1-IZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Apr 2026 23:57:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gt+490hTDLu75UHm9ZEuCUr2zVIhMS3KHy6Mg+qVCZg=; b=jT92j5VskdH7bZhcPavh9Xfn4p
 TpYOQzlQ8nbH4jayW0fskyP6MHiSDQWRnIsdSW52S9kOsfUyJkErzCzBdx5eo+Vp8ln86qE5huVu3
 Bve1Zi+bmE+idZQ9mBYucT/8wrOECOVzQoJsxSYWhWED0zznYZhI82kIc6ro2oxMAqdQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gt+490hTDLu75UHm9ZEuCUr2zVIhMS3KHy6Mg+qVCZg=; b=XNmMc4eRz/uXyoMGS1hXMD24vh
 mS8fLr3gGsPZnxeEdQ7ZZtF3pWr0/Oqw+tJKhz5d2T2IvmISmDc2v7jzDoGoOIt638sd1o+0eMrrW
 SpOTHf93l8y7PD7R8/cuqh8b6Sj6mYJdyzOU8MwP5JAN0DWUBfHPvC/eE8Y62FMI8zM0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w85R8-0000E5-Td for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 01 Apr 2026 23:57:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0AE69600CB;
 Wed,  1 Apr 2026 23:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E119C4CEF7;
 Wed,  1 Apr 2026 23:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775087835;
 bh=tcQn0jNvskFSJW+K9iuub+kF7CbhB6AAKIoY7X78kfg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pmqH/gYS7H3A8WIi5YaQwSPGuloLcc9oof281lzvAWGN4iW/sx8PxnpcmLa0fkTwI
 VLuQCSdS+pad4iKkwf6iYNFDE3CubyeXY+Gg9/AM262caq/JvUaUw9j3K8YSzBXyO3
 /8B8BvgqIyeJ3QXT26IHd05FmQsg/BwIrsJXNwDoiYKa/Xn45P1xdC1LR1QKuve4fe
 O0rVwIHQmzCtvy1QZm33yuuaFlHzDjwoQWgGejb3a8A84Lx1VmzrRtNWZ3YQ39eBYG
 HYB8qVoDf61xKIhY8HVfbWP+sT3x02HLL0iH5yOeRFZWBdyKrOjTQTwiuyIWlU9A7Q
 3zO85+iKzq84A==
Date: Wed, 1 Apr 2026 16:57:13 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260401235713.GC14247@quark>
References: <20260331212827.2631020-1-aalbersh@kernel.org>
 <20260331212827.2631020-16-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260331212827.2631020-16-aalbersh@kernel.org>
X-Headers-End: 1w85R8-0000E5-Td
Subject: Re: [f2fs-dev] [PATCH v6 15/22] xfs: add fs-verity support
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

On Tue, Mar 31, 2026 at 11:28:16PM +0200, Andrey Albershteyn wrote:
> +	/*
> +	 * If this is a block full of hashes of zeroed blocks, don't bother
> +	 * storing the block. We can synthesize them later.
> +	 *
> +	 * However, do this only in case Merkle tree block == fs block size.
> +	 * Iomap synthesizes these blocks based on holes in the merkle tree. We
> +	 * won't be able to tell if something need to be synthesizes for the
> +	 * range in the fs block. For example, for 4k filesystem block
> +	 *
> +	 *	[ 1k | zero hashes | zero hashes | 1k ]
> +	 *
> +	 * Iomap won't know about these empty blocks.
> +	 */
> +	for (i = 0, p = buf; i < size; i += digest_size, p += digest_size)
> +		if (memcmp(p, zero_digest, digest_size))
> +			break;
> +	if (i == size && size == ip->i_mount->m_sb.sb_blocksize)
> +		return 0;

Might be too subtle, but this could be done more efficiently with just
two calls to memcmp():

	if (size == ip->i_mount->m_sb.sb_blocksize &&
	    /* first digest is zero_digest */
	    memcmp(buf, zero_digest, digest_size) == 0 &&
	    /* every digest is same as previous, thus all are zero_digest */
	    memcmp(buf + digest_size, buf, size - digest_size) == 0)
		return 0;

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

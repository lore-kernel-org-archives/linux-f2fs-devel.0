Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9776B606CC5C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BUsM+1i6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=H8zRiaYw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jAxEBKKG;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ue9J5/vX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4xAAuTvpe4VxtNOkN1MvEjbnqBQzEYzemhdWIFDsTb8=; b=BUsM+1i6gjC5WKr0eU+NfI/OWq
	lxXsl5MEJVuksFu/MQ7NP2Az89fBSuQ2yD9XMAxwPr4OX6/Zf3Tv+W0KujLrpj18g9VX6iktqoMHZ
	EY/VfjJP1U5JsyEcyOpNmK2VWC/Aqk8YAsPCZcY4ySlwHYW8mp+WQnkfH4CrMmgE4vu0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xU93h-000000000YC-0Ttk;
	Thu, 19 Nov 2026 20:48:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <brauner@kernel.org>) id 1xU93g-000000000Y4-0W2n
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 20:48:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3PGVJVSc8QkEj1hdnStWiMpyEZMIVB/RSu3VQkMSD4Q=; b=H8zRiaYwNnZwQN7t9a70cyv7Q8
 dwZOjux3RUFHl7XRk1N6Jl4wUlv/8CH0f3SeRV1jA2PYll/Cwd8xJI1m0ouORNEnO7T65j6kU2f3u
 DPjR4YLRqPDP1MKKVlwIhe+ksnQ7V6+VUFYy+CD/SjHxbQyutbUYD5TN7FSa6zTCQo0E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3PGVJVSc8QkEj1hdnStWiMpyEZMIVB/RSu3VQkMSD4Q=; b=jAxEBKKGyX+Ak83fTm4QsXeyHI
 QJCRYFUaUiPGDZdlV2dClDekQCXwJbRRRdNtpfls9sZ60/Zs5BPflXQkxUAj/erN2GdHW0+dMlZtc
 +Xo4eQ/UNmUPhQpj5otskoT3J51WUq8kSDXgc3whad0VPQZMF/8qtPBtHfoyJlQQ6MME=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xU93e-000000003iW-2mOf
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 20:48:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ABCA2609F5;
 Thu, 19 Nov 2026 20:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5862C1F000CF;
 Thu, 19 Nov 2026 20:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795121312;
 bh=3PGVJVSc8QkEj1hdnStWiMpyEZMIVB/RSu3VQkMSD4Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Ue9J5/vXQQKgXeGGR/gDKOdLIvkPt/OHBv/xbkrYdBe65rGDof+xnYjDqlFvqyqQV
 WTbiGm1jwXFq2goSCG+63YU564jbcVpEBNEmScsT4QFSJLA/xI1v8/xsoWqAW2f1Ul
 SSVRPr2dUv57zfJ2/9acK9mOwLLa5IYT21C8vqN0sSoybGDiMczqGgpVA1x2ScNPvR
 SwWELDPV/KKxRb1t95LVaGxquYOYMrfFU97lDXPBU8ZIkB06H6EscpbeR2xjQHhO+G
 EVtsDIFt5g8DJJmL063y3QX3nR44hpO1z/oLunHmPHWXkAYut8GVWPBGAVsr8yFtPi
 pVmjC2n2lsCcA==
Date: Thu, 19 Nov 2026 21:48:27 +0100
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20261119-gefunden-beteiligen-epidemie-5a23ff160ef4@brauner>
References: <20261105115532.613467-1-aalbersh@kernel.org>
 <20261105115532.613467-3-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261105115532.613467-3-aalbersh@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xU93e-000000003iW-2mOf
Subject: Re: [f2fs-dev] [PATCH v2 2/5] fsverity: add I_VERITY_BUILDING inode
 state flag
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Christian Brauner via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, tytso@mit.edu,
 linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com,
 jaegeuk@kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 12:55:27PM +0100, Andrey Albershteyn wrote:
> Every filesystem that supports fs-verity keeps a private runtime inode
> flag meaning Merkle tree is currently being built *_VERITY_IN_PROGRESS.
> They all serve the same two purposes: reject a concurrent enable with
> -EBUSY and let the write paths recognize the special writes done while
> the tree is under construction.
> 
> Hoist this flag into the VFS as a new inode state flag,
> I_VERITY_BUILDING, and manage its lifetime in the generic fs-verity
> enable path. The flag is set after ->begin_enable_verity() succeeds and
> cleared after ->end_enable_verity() returns (both on the success and the
> rollback paths). Add the concurrent-enable guard.
> 
> A new helper, fsverity_is_building(), is provided for filesystems to
> query the flag. No filesystem uses it yet; the per-fs flags are
> converted in following patches.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/verity/enable.c       | 22 +++++++++++++++++++---
>  include/linux/fs.h       |  6 ++++++
>  include/linux/fsverity.h | 21 +++++++++++++++++++++
>  3 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/verity/enable.c b/fs/verity/enable.c
> index fe8493280b77..65d3571c62b5 100644
> --- a/fs/verity/enable.c
> +++ b/fs/verity/enable.c
> @@ -229,13 +229,23 @@ static int enable_verity(struct file *filp,
>  
>  	/*
>  	 * Start enabling verity on this file, serialized by the inode lock.
> -	 * Fail if verity is already enabled or is already being enabled.
> +	 * Fail if verity is already enabled or is already being enabled. Set
> +	 * I_VERITY_BUILDING inode runtime flag which will be cleared when
> +	 * enablement succeeded or rolled back.
>  	 */
>  	inode_lock(inode);
> -	if (IS_VERITY(inode))
> +	if (IS_VERITY(inode)) {
>  		err = -EEXIST;
> -	else
> +	} else if (inode_state_read_once(inode) & I_VERITY_BUILDING) {
> +		err = -EBUSY;
> +	} else {
>  		err = vops->begin_enable_verity(filp);
> +		if (!err) {
> +			spin_lock(&inode->i_lock);
> +			inode_state_set(inode, I_VERITY_BUILDING);
> +			spin_unlock(&inode->i_lock);
> +		}
> +	}
>  	inode_unlock(inode);
>  	if (err)
>  		goto out;
> @@ -291,6 +301,9 @@ static int enable_verity(struct file *filp,
>  	 */
>  	inode_lock(inode);
>  	err = vops->end_enable_verity(filp, desc, desc_size, params.tree_size);
> +	spin_lock(&inode->i_lock);
> +	inode_state_clear(inode, I_VERITY_BUILDING);
> +	spin_unlock(&inode->i_lock);
>  	inode_unlock(inode);
>  	if (err) {
>  		fsverity_err(inode, "%ps() failed with err %d",
> @@ -317,6 +330,9 @@ static int enable_verity(struct file *filp,
>  rollback:
>  	inode_lock(inode);
>  	(void)vops->end_enable_verity(filp, NULL, 0, params.tree_size);
> +	spin_lock(&inode->i_lock);
> +	inode_state_clear(inode, I_VERITY_BUILDING);
> +	spin_unlock(&inode->i_lock);
>  	inode_unlock(inode);
>  	goto out;
>  }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 99caef43ff3c..7c90ce09f797 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -707,6 +707,11 @@ is_uncached_acl(struct posix_acl *acl)
>   * I_LRU_ISOLATING	Inode is pinned being isolated from LRU without holding
>   *			i_count.
>   *
> + * I_VERITY_BUILDING	fs-verity is being enabled on the inode: the Merkle
> + *			tree is under construction.  The file is effectively
> + *			read-only to userspace; the only writes happening are
> + *			for the fs-verity metadata.
> + *
>   * Q: What is the difference between I_WILL_FREE and I_FREEING?
>   *
>   * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
> @@ -741,6 +746,7 @@ enum inode_state_flags_enum {
>  	I_SYNC_QUEUED		= (1U << 17),
>  	I_PINNING_NETFS_WB	= (1U << 18),
>  	I_METADATA_WRITEBACK	= (1U << 19),
> +	I_VERITY_BUILDING	= (1U << 20),
>  };
>  
>  #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index 61fe96ccdff6..c72edec57e30 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -164,6 +164,22 @@ static inline bool fsverity_active(const struct inode *inode)
>  	return false;
>  }
>  
> +/**
> + * fsverity_is_building() - is fs-verity being enabled on the inode
> + * @inode: inode to check
> + *
> + * This checks whether the inode's Merkle tree is currently being built.
> + * While this is the case the file is read-only to userspace and the only writes
> + * allowed are for the fs-verity metadata. This becomes false when fsverity
> + * metadata is fully created and written to disk or building failed.
> + *
> + * Return: true if fs-verity is being enabled on the inode
> + */
> +static inline bool fsverity_is_building(const struct inode *inode)
> +{
> +	return inode_state_read_once((struct inode *)inode) & I_VERITY_BUILDING;

Isn't the fix to make inode_state_read_once() take a const struct inode *?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

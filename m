Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807CED7237B
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 25 Jan 2026 01:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GSKgbIzeTCbUSXTtNjAjpFR6U7Pdsl4Md5fQBQKH8pA=; b=R1uhL3kQBBeGutXOeGSb2HNaEV
	A4TJ0KWyYY2jBYuRCbCZ9/vBS+Ms08iYwp/bs7QNgSUw6SQ/uiUm2evVfqwuibHtnAfydFx3cgFK/
	usmi7naprTlYAz0DE7Fd9bQJA1YvIlBMspAPCnuXyIdPFwPpGoBCDuPHswvEvknDhXHc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vjoyj-0005qe-RX;
	Sun, 25 Jan 2026 01:31:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1vjoyi-0005qY-G0
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 25 Jan 2026 01:31:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XkKKLr2Is0oHBZrzX00fF2hho8QPBhz2PjM8HNA7w5c=; b=FXFHUFKrUnln4ikoF3M4+icaGV
 JKNCAjESLALjb9pI7wNatA8jxayAcZ6hIHMN3GWxovezk8iEpFAbe1AAP10Oxe+Aq1z+dVi6Gf6ty
 iGw1NIHRufI65YHavAoM4FkJXYK6Kv093jWKB56r79WiindgVD4b+V9tmGC9CdEnGCWw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XkKKLr2Is0oHBZrzX00fF2hho8QPBhz2PjM8HNA7w5c=; b=CgJxt5UBFR0gk2gN/cPSljDQxW
 FO8KebxdJDqnS4LoVm1mgTipsRDdycM74NYiULfMbmWz4SpJDe7gg+KRbp8Yy6WilYk1q/171Ue0R
 e0feKoSKvSYAH7ayRFKcHJJ/N3jyEsSKaV24wy6QNzFSi1lpotIM+SufDlVg3yWim6K8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vjoyh-0000NC-S2 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 25 Jan 2026 01:31:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 521D960018;
 Sun, 25 Jan 2026 01:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90025C116D0;
 Sun, 25 Jan 2026 01:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769304696;
 bh=3iMKlt4ekuSyqFUkFLSPSHU1p/JvwSOUPzMPH5DNdH4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BKsh/FlR6k8/j7LqfmKgDMZe6pyDi94yewRpX63qWUZ405K9Y1iXqRMDhCmaI8JNW
 hHjTClwIXwbDp8z4r1k1uHw6sTpY0oCeLQkgN9JucQDykp8xJ8SkgkW4aFuyzez/bF
 pHA6UOYHAzwE30ttiS5Vl0xr8iadmRDtFaXm3KYpl9k5aL28HRSjC1cmnwx4rLC3lE
 DDio4J9GWT7QVSVP6TFCuJKwp9PT+VdFLaqngoQE5yTZ9H3B+kq20Q9W1NCt+NIj0l
 H6cDKFS22aVMpnT3yn0/wHjPrsRpwn1FMXp2UxJC9HOES4E3sLH87EP9i4Ywpe2Ach
 wSECnCY11if1Q==
Date: Sat, 24 Jan 2026 17:31:04 -0800
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260125013104.GA2255@sol>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-12-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260122082214.452153-12-hch@lst.de>
X-Headers-End: 1vjoyh-0000NC-S2
Subject: Re: [f2fs-dev] [PATCH 11/11] fsverity: use a hashtable to find the
 fsverity_info
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
Cc: fsverity@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Andrey Albershteyn <aalbersh@redhat.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 David Sterba <dsterba@suse.com>, Jan Kara <jack@suse.cz>,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jan 22, 2026 at 09:22:07AM +0100, Christoph Hellwig wrote:
> +int fsverity_set_info(struct fsverity_info *vi)
>  {
> -	/*
> -	 * Multiple tasks may race to set the inode's verity info pointer, so
> -	 * use cmpxchg_release().  This pairs with the smp_load_acquire() in
> -	 * fsverity_get_info().  I.e., publish the pointer with a RELEASE
> -	 * barrier so that other tasks can ACQUIRE it.
> -	 */
> -	if (cmpxchg_release(fsverity_info_addr(inode), NULL, vi) != NULL) {
> -		/* Lost the race, so free the verity info we allocated. */
> -		fsverity_free_info(vi);
> -		/*
> -		 * Afterwards, the caller may access the inode's verity info
> -		 * directly, so make sure to ACQUIRE the winning verity info.
> -		 */
> -		(void)fsverity_get_info(inode);
> -	}
> +	return rhashtable_lookup_insert_fast(&fsverity_info_hash,
> +			&vi->rhash_head, fsverity_info_hash_params);
>  }
>  
> -void fsverity_free_info(struct fsverity_info *vi)
> +struct fsverity_info *__fsverity_get_info(const struct inode *inode)
>  {
> -	if (!vi)
> -		return;
> -	kfree(vi->tree_params.hashstate);
> -	kvfree(vi->hash_block_verified);
> -	kmem_cache_free(fsverity_info_cachep, vi);
> +	return rhashtable_lookup_fast(&fsverity_info_hash, &inode,
> +			fsverity_info_hash_params);
[...]
> +	/*
> +	 * Multiple tasks may race to set the inode's verity info, in which case
> +	 * we might find an existing fsverity_info in the hash table.
> +	 */
> +	found = rhashtable_lookup_get_insert_fast(&fsverity_info_hash,
> +			&vi->rhash_head, fsverity_info_hash_params);
> +	if (found) {
> +		fsverity_free_info(vi);
> +		if (IS_ERR(found))
> +			err = PTR_ERR(found);
> +	}

Is there any explanation for why it's safe to use the *_fast variants of
these functions?

>   * fsverity_active() - do reads from the inode need to go through fs-verity?
>   * @inode: inode to check
>   *
> - * This checks whether the inode's verity info has been set.
> - *
> - * Filesystems call this from ->readahead() to check whether the pages need to
> - * be verified or not.  Don't use IS_VERITY() for this purpose; it's subject to
> - * a race condition where the file is being read concurrently with
> - * FS_IOC_ENABLE_VERITY completing.  (S_VERITY is set before the verity info.)
> + * This checks whether the inode's verity info has been set, and reads need
> + * to verify the verity information.
>   *
>   * Return: true if reads need to go through fs-verity, otherwise false
>   */
>  static inline bool fsverity_active(const struct inode *inode)
>  {
> -	return fsverity_get_info(inode) != NULL;
> +	/*
> +	 * The memory barrier pairs with the try_cmpxchg in set_mask_bits used
> +	 * to set the S_VERITY bit in i_flags.
> +	 */
> +	smp_mb();
> +	return IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode);
> +}

This looks incorrect.  The memory barrier is needed after reading the
flag, not before.  (See how smp_load_acquire() works.)

Also, it's needed only for verity inodes.

Maybe do:

	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode)) {
		/*
                 * This pairs with the try_cmpxchg in set_mask_bits()
                 * used to set the S_VERITY bit in i_flags.
		 */
		smp_mb();
		return true;
	}
	return false;

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DF9D35668
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Jan 2026 03:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1BSJ5kakNB+5zl1yw7dU2l+6YIStUpAxY7tF6KcIfFE=; b=Sh3qpuaf9bTZmQOWhGcfb0XqfW
	fg1zZ/wgBrDFQ2joOEcdPPYvJnl6k1uXe87YFVX4aXO03moDZDda/UTbEpgbkXWY+9+/kiNyRxqig
	SpkjSuQiYuXILh2tYe1gHGgruPpIqWXCP+C9Uxcoe6J/1rNDVF1xKAqQ+GkEnzzmrLEg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vkwEp-00022P-LK;
	Wed, 28 Jan 2026 03:29:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1vkwEn-00022I-Ti
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Jan 2026 03:29:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RyrjgD/dP/K2+ryscF5nyrnIYs5lzXPwCI/h7RCjqfI=; b=lv+X2kXMiSRGeIpR+ELnOSVhSx
 R3zzG1DHXmcDS/T9vhLYKvKRx4ZgxvRn8B3t5mlJ65JLWBL0ddPh1oLTdh/vhiibhyVrCCf4nQzsd
 OFWZMtufggEXDyOPLu5xchpIqGaDxheMmnEK6Vwh7RSdh9W7b/RZzmqXXC6CpgaeClRs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RyrjgD/dP/K2+ryscF5nyrnIYs5lzXPwCI/h7RCjqfI=; b=e8wxMRI+cRzFFODi9bPTuC2acO
 AIVfWB7IFTrGhEHaokI27qQ3RQIfQXRSI5oQmS1nr2AWNhj4qovdQ5fTsCQxJMdNN4y2uiY8tEpDZ
 itB3wFwh6x1M/r0zwMMiRY2N6ZEe5QV/AX95yQj1ahdsDOAyxP5cMdVYrCcY9UV6dwxw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vkwEn-0000Wi-Bf for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Jan 2026 03:29:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9E61D60007;
 Wed, 28 Jan 2026 03:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E81C4CEF1;
 Wed, 28 Jan 2026 03:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769570930;
 bh=M66VvmyKffB7Z0mgvoF1z/uND8SQzYs4dDIbYqFJeaw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZsazHlGTI4JJelUSnWi1LzMyGszwGA9wTVyrjgSQpYx1q2Ekl5T9hLZT4mhuitl2N
 Yia1KeKDb+mkwNd2bdvb0Q3tUbBJrq0x6xi74nf8m7kgpTv9c2umel5Paw3Uj+6DqJ
 +zotcBTjbXQgYfzfmmeH7N0fULDmWZDA8rF6giYX6Wg8kc8I4K7221n6PAHR1TZ+v2
 8AxChkyBMiAvAtZkrdPLwf4FuXafAMcuROFFuTIZe7ykfBSBdA5dJBd/ryAWl38det
 1oA1z022UejlktPWncECiKhbfYMgIsJZLbdUfPK7KUNaQlIVAxXkl5ATvEVpi5gHc9
 HwvfhJkcFhDvg==
Date: Tue, 27 Jan 2026 19:28:17 -0800
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260128032817.GB2718@sol>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-17-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260126045212.1381843-17-hch@lst.de>
X-Headers-End: 1vkwEn-0000Wi-Bf
Subject: Re: [f2fs-dev] [PATCH 16/16] fsverity: use a hashtable to find the
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
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jan 26, 2026 at 05:51:02AM +0100, Christoph Hellwig wrote:
> @@ -296,18 +243,39 @@ static inline bool fsverity_verify_page(struct fsverity_info *vi,
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

Nit: the point is to verify the file's data, not to verify "the verity
information".

>   *
>   * Return: true if reads need to go through fs-verity, otherwise false
>   */
> -static inline bool fsverity_active(const struct inode *inode)
> +static __always_inline bool fsverity_active(const struct inode *inode)
> +{
> +	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode)) {
> +		/*
> +		 * This pairs with the try_cmpxchg in set_mask_bits()
> +		 * used to set the S_VERITY bit in i_flags.
> +		 */
> +		smp_mb();
> +		return true;
> +	}
> +
> +	return false;
> +}

Is there a reason for this function in particular to be __always_inline?
fsverity_get_info() is just inline.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

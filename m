Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18968D35668
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Jan 2026 03:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iDEraEytxl8unwzrgH3t6hRPXrNVWOafYsNVAb4lQq0=; b=bPqBBVpailePVIT2hWL4brtERz
	vhzP2q2QjDT1/X8WpzBmtbnijfxucHkDGWN7HiCxEPtLIHqpw1bvypIou6CDUUbm9tDoopHUOxouR
	HM4Elj8OzIgnSLbHPNyoREmUN53By5IO+5xdPMsYbo20frbnpT/dhC0u+DOA4zeCOXFM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vkwL7-0002Cx-Mn;
	Wed, 28 Jan 2026 03:35:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1vkwL6-0002Cn-Mg
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Jan 2026 03:35:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fC1UeH7rU1Ae666+sKel9bIHhJtXh2k+OWNbHHQK+Cc=; b=kW+IPOdTO57jaSVUNPLLXca3Rn
 FefoA83tkIm30+oLNyruxYEMyicrqSL+0Vr5oHE9YzyeXPMQ79WDnYliYtBZcI/FEjOenUrLJFNbz
 sDFoyNJVZtyIq43R5acwH5gRmuvw6n6Ufz2NwZymKXsGjOvoxd/y74ZtTRLRTFX7U8zg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fC1UeH7rU1Ae666+sKel9bIHhJtXh2k+OWNbHHQK+Cc=; b=nNjRZS/ukwawlG3psHgfUsU7H3
 FIbJQLDJ/rDzjVDuBs7mp/6UfWr48SJ9L7WsxOBkUCXy5Yhh/mxmZAjMQPI9y67YlFloeNoepL2mn
 0+oTzziA+0hD6bhClvsVU0gA9ygUS9aATSo26TOcz3Ln9EUpIS76QNvG8vnHiUdITo8U=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vkwL6-0000k3-7F for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Jan 2026 03:35:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 93A97227A8E; Wed, 28 Jan 2026 04:35:19 +0100 (CET)
Date: Wed, 28 Jan 2026 04:35:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20260128033519.GB30830@lst.de>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-17-hch@lst.de> <20260128032817.GB2718@sol>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260128032817.GB2718@sol>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1vkwL6-0000k3-7F
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
Cc: fsverity@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Andrey Albershteyn <aalbersh@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jan 27, 2026 at 07:28:17PM -0800, Eric Biggers wrote:
> > - * a race condition where the file is being read concurrently with
> > - * FS_IOC_ENABLE_VERITY completing.  (S_VERITY is set before the verity info.)
> > + * This checks whether the inode's verity info has been set, and reads need
> > + * to verify the verity information.
> 
> Nit: the point is to verify the file's data, not to verify "the verity
> information".

Ok.

> > -static inline bool fsverity_active(const struct inode *inode)
> > +static __always_inline bool fsverity_active(const struct inode *inode)
> > +{
> > +	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode)) {
> > +		/*
> > +		 * This pairs with the try_cmpxchg in set_mask_bits()
> > +		 * used to set the S_VERITY bit in i_flags.
> > +		 */
> > +		smp_mb();
> > +		return true;
> > +	}
> > +
> > +	return false;
> > +}
> 
> Is there a reason for this function in particular to be __always_inline?
> fsverity_get_info() is just inline.

Without the __always_inline some gcc versions on sparc fail to inline it,
and cause a link failure due to a reference to fsverity_readahead in
f2fs_mpage_readpages for non-verity builds.  (reported by the buildbot)

> 
> - Eric
---end quoted text---


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

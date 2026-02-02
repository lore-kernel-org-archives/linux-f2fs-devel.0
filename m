Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16B2E7DEF3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Feb 2026 15:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EWSosjh0eYsPEWGoQQWSEZLnCqahXzWKANs3ZyRaI3w=; b=QYFIEGTHx2SAvd7GtMSVkgl2c/
	L94fIKrHmOLY+iLWipodBMOa7VfEtxdDc7Q8SzyddQhKhEFaF6hrhzCnjVV+gmp1b6h0W+DLkee9H
	0PYHMTrpMsliKd18gLXhWmyKmT+Jj4jR0rodGWE6xk83H8Zn7sslg3Ov0PDuujCE7TWQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vmvb0-00032C-JW;
	Mon, 02 Feb 2026 15:12:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1vmvao-00031c-0Y
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Feb 2026 15:11:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=29jy1DWONXoy2B6xjNCVE28WgCP/0GEBN/PkS8AOnVg=; b=czLa15rfiMBmg7rEeD6SfcSzfM
 IgQyCohwGeQVkzLEyeSKP90k9euDaMmeVP6YplFeri3x9qsJixaCFHvRDmtqQ4qh91touvTOJ0OtT
 uf2D3fY97nAFSFwVM1BOgBUCYtabfVI2o5pbINIZvPAM/yjMU2xOZCF8nivU+NgDv39Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=29jy1DWONXoy2B6xjNCVE28WgCP/0GEBN/PkS8AOnVg=; b=PeUxyQd8nbsPpQWUOvu9z8Q8f0
 fkQIUNl8pKU8WBMsholJxLDYxvxTTZ3LNtadUzVEOrAoj1Q9W/JsYcYH76i+yvsxhooqaOG398y1f
 uiG8HFOziuE5S0nqua8tGtAsPODX+vHtVYk71+lgVSyH3HDq+cZA0EgmBK+uF/dD6ZiM=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vmvan-0008Nv-B3 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Feb 2026 15:11:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=29jy1DWONXoy2B6xjNCVE28WgCP/0GEBN/PkS8AOnVg=; b=BDtlxC7H+13PZmg79XlT4cSMua
 xCmWldl386DVv7YKhloM8ay70jGq0ky18Petto6satpvMsOL7fevIgvAqiZ+m+T6dTk9OSYyjC9B1
 dgk5DWbW5WtnJ5dXJqJtbG8v1U3xFLHjpHoDe9S11x2Hx3rNbI7g0hkbr2HHCIxDzAbUzzAv6dbgP
 6rP862nQMv4gnxs7ZGhGVAFYzSMXeOynEkfnl+8Ge3pLQoZw9MEPAuPqTtnZ33oYU7uTa/WHu11eu
 NkI4dVGUFndZcaqlAzsnvzeNwkeanApgqsDci6lZ3Cx+VX0m0V0A/2I/YzUijvV5CJd1qIVP+qJOm
 VWpZWm+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1vmvab-0000000Gf51-3qX6;
 Mon, 02 Feb 2026 15:11:45 +0000
Date: Mon, 2 Feb 2026 15:11:45 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <aYC-set6OAK9F9GE@casper.infradead.org>
References: <20260202060754.270269-1-hch@lst.de>
 <20260202060754.270269-3-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260202060754.270269-3-hch@lst.de>
X-Headers-End: 1vmvan-0008Nv-B3
Subject: Re: [f2fs-dev] [PATCH 02/11] readahead: push invalidate_lock out of
 page_cache_ra_unbounded
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
 Jan Kara <jack@suse.cz>, Andrey Albershteyn <aalbersh@redhat.com>,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, David Sterba <dsterba@suse.com>,
 Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Feb 02, 2026 at 07:06:31AM +0100, Christoph Hellwig wrote:
> +++ b/fs/f2fs/file.c
> @@ -4418,7 +4418,9 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
>  	pgoff_t redirty_idx = page_idx;
>  	int page_len = 0, ret = 0;
>  
> +	filemap_invalidate_lock_shared(mapping);
>  	page_cache_ra_unbounded(&ractl, len, 0);
> +	filemap_invalidate_unlock_shared(mapping);

Why is f2fs calling page_cache_ra_unbounded() here?  The documentation
literally says not to call it:

 * This function is for filesystems to call when they want to start
 * readahead beyond a file's stated i_size.  This is almost certainly
 * not the function you want to call.  Use page_cache_async_readahead()
 * or page_cache_sync_readahead() instead.

(in this case, f2fs doesn't have a folio, so page_cache_async_ra() is
probably the right function to call).  But what's the point in writing
documentation when people don't read it?

> @@ -228,9 +229,10 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>  	 */
>  	unsigned int nofs = memalloc_nofs_save();
>  
> +	lockdep_assert_held_read(&mapping->invalidate_lock);

Hm, why are we asserting that it's not write-locked?  For the
purposes of this function, I'd think we want to just
lockdep_assert_held()?

In the tree I'm looking at, there are also calls to
page_cache_ra_unbounded() in fs/ext4/verity.c and fs/f2fs/verity.c
which probably need the lock taken too?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

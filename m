Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BBCD19518
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Jan 2026 20:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sv5oO97MQ+N1jJMJ7TO7UnmS2iXacRcQM/D4kP5Ruj4=; b=dO5TCFd4pgpy2HiZPTsCT9qAur
	o7S50dB8jqM26zmfdQA0ko92DBf1vd2XNwW5KjwNgEBY81ciSCHV7PFxFEPCdzZnGE0NjIhHJdGFg
	QlfmMdUNGrF+NC5/n5bDJIfR/RAwLjmsBnc8GwTr7x6X1nUnwkNgbox4JhBt5q5lbyLk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vkSwf-0006Up-AW;
	Mon, 26 Jan 2026 20:12:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1vkSwe-0006Uh-4n
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 20:12:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K3a2LuJyM8A34y7ZMBWL2sHWQ4VubhNlxvSQAErPJ1o=; b=mNejbOhroA42Corp2+7PwHedhI
 FKSBhXe/wi/CwD0QP2t4F4Hm2RH2MEVCZfzBhsYEnM5jdMcOcI/G/4svIyK8RuzDeCECW4flU0ca3
 gZpqXkMVEq1kASIFX7sdkjmhvGMA0ydPdW4SWwRPKpj3GMhWPanEG3xY6KMzB3Ge5puw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=K3a2LuJyM8A34y7ZMBWL2sHWQ4VubhNlxvSQAErPJ1o=; b=UdfSajWDLhPU1DYlsNyScc/8ua
 5gzfI/Ln2Uf/RFi3AwO/nIK58otidrrxEPdOT93/3gIwwdLplmXD2tswTctFxabHJLJu+YSALQ6TU
 yxfTUxtAvF4uKwBWSGr+phIzXi77tAdfoOZ29tGekH+GpbozrNDAgm/IOyjUCJanifM0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vkSwd-0008Nv-Js for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Jan 2026 20:12:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C791D60121;
 Mon, 26 Jan 2026 20:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26AEC116C6;
 Mon, 26 Jan 2026 20:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769458328;
 bh=NBe+OxYRigsrCScWNRGhoFuPEsSz3lykHJTIWDbyMDI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B3K3AwRdtBqGRu/L0NVC2m/GP0oeFUwZGfM5GvznVm9SC4gLQ0Q/wUEhnJgCtVJ6/
 3hBgOYdjlX4u9PUZ0AVnNlNqsADYsiji5c7ZCYbDF3dPITcbpj0MWR24shiGQ+aZyN
 qhBUxH2vAzOy0Q+hW8/87TrJC5oOxviszzzyQi+o7HiwPKy0ODSW/eeG+xVqNQNFPG
 aCd3Tr+fuP0vTljmBoLEVDvqhaqRvXutNBbYDiGg3XmuUxeCLfYatg3u21MkYa6tET
 4+2gllNik8k0IpeNxNVqiGa88nvSll2D2FKnPiS0Mz94gEdfhKUxrVNYxjgAXP6E/N
 Wg+2yKtJ8gj+A==
Date: Mon, 26 Jan 2026 12:12:06 -0800
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20260126201206.GA30838@quark>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-12-hch@lst.de> <20260125013104.GA2255@sol>
 <aXaPph6Yi-hzf0J-@casper.infradead.org>
 <20260126044432.GE30803@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260126044432.GE30803@lst.de>
X-Headers-End: 1vkSwd-0008Nv-Js
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
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jan 26, 2026 at 05:44:32AM +0100, Christoph Hellwig wrote:
> On Sun, Jan 25, 2026 at 09:48:22PM +0000, Matthew Wilcox wrote:
> > Is there a reason not to do as DAX did:
> 
> > +#ifdef CONFIG_FS_VERITY
> >  #define S_VERITY       (1 << 16) /* Verity file (using fs/verity/) */
> > +#else
> > +#define S_VERITY       0         /* Make all the verity checks disappear */
> > +#endif
> >  #define S_KERNEL_FILE  (1 << 17) /* File is in use by the kernel (eg. fs/cachefiles) */
> >  #define S_ANON_INODE   (1 << 19) /* Inode is an anonymous inode */
> > 
> > 
> > and then we can drop the CONFIG_FS_VERITY check here and in (at leaast)
> > three other places
> 
> I looked into this, but wasn't entirely sure about all callers.  Also
> in at least some places we might need the barrier in fsverity_active,
> so my plan was to see how many of the checks should simply be converted
> to fsverity_active in a follow on and how much is left after that first.

When CONFIG_FS_VERITY=n, there can still be inodes that have fsverity
enabled, since they might have already been present on the filesystem.
The S_VERITY flag and the corresponding IS_VERITY() macro are being used
to identify such inodes and handle them appropriately.  

Consider fsverity_file_open() for example:

static inline int fsverity_file_open(struct inode *inode, struct file *filp)
{
	if (IS_VERITY(inode))
		return __fsverity_file_open(inode, filp);
	return 0;
}

When CONFIG_FS_VERITY=n, __fsverity_file_open() resolves to the stub:

static inline int __fsverity_file_open(struct inode *inode, struct file *filp)
{
	return -EOPNOTSUPP;
}

So the result is that on a kernel that doesn't have fsverity support
enabled, trying to open an fsverity file fails with EOPNOTSUPP.

But this relies on IS_VERITY() still working correctly.

Similar code that relies on IS_VERITY() working correctly exists in
other places as well, for example in the implementation of statx().

So IS_VERITY() can't be changed to always return false when
CONFIG_FS_VERITY=n, unless we identified all the callers like these and
updated them to check the underlying filesystem-specific flag instead.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

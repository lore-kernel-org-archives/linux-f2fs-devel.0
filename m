Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92959C5B572
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/H7L+tVQaigymBkxUyq4V17AIYpYN8NglgbG16xTURs=; b=HL9gRC40eqg2PWqWMzL1G3Kr1D
	oLc/v3O0Ft9sl8rO1XlC6d/CeY9P7M4edmDZYU8d7o+fhuGpXuocX3i8OKiS6og1RHofRibEx80dD
	Ww2oq8cczj7UAgn/DVylBtb8QKIvuWmS/7WX1JrhAoOuQb9LeGzQwf/82sXjBpGoGnUA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wtqpw-00005h-V9;
	Tue, 11 Aug 2026 18:04:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wtqpv-00005b-SR
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 18:04:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CCXYUWfaQmVmTc4INn+t522+Y+UjSzJVsGmbRsWsMQE=; b=j4a7/RActPm5Zr1OYIjM8b3wa7
 H37f1tbhBmsd74NKt2QlQ2KnI9BrlzCKwwM5EuAlU9FEWcBz6Mot6Xq/8G/WuYjPap1844LEr+ZFP
 FdqxmKrNEV8FVCp9byJCSBWdhfC/ricwLDNx0H7XYvfDkD59r2WzzA7FKINV5MUcC4hg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CCXYUWfaQmVmTc4INn+t522+Y+UjSzJVsGmbRsWsMQE=; b=eK/fKeG/WS9AeGK1MUju5bC7fU
 2wrSa8pNze2qpBa+D153yBplTibBJ4SE1rmsWJIzDs0xNAWuDld4V9mXU3h8u58FwYqG9r9DpnuyA
 7G3eobQfIUi+t8l3+QvkIokFzjetlSEAO5slKYtm6MKKFmRd0lX0iXPIAIEaBOC1mXaw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wtqpp-0003DF-Pl for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 18:04:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2691F600AD;
 Tue, 11 Aug 2026 18:04:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8D91F000E9;
 Tue, 11 Aug 2026 18:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786471455;
 bh=CCXYUWfaQmVmTc4INn+t522+Y+UjSzJVsGmbRsWsMQE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ews4KBL/NG6I/XZFa+YJuqD0O1o5vmAY20ZvXzDnNOIRkvLOHdWW4RNZc51t+Ew1d
 RAI4431LXFOyhWiGc9gTmgjV5F+1JxZzlLCM7ZmWLFpvdOwXjDft01aP917AGnLtf9
 0hGeyCo+1YzXtKJxC9fibxEcbKCk2Cy1zou8j3tjRgn2/QWWSGjbBOY0z4uDEyEGug
 cWzq/Ow2uPzS0phA4ToFbCBqmvQnTlaLiCepreHEDediHD4GAHe1WBNwU5XQm0kn3y
 sDBCoTBR9c3HZUeipE9maCyUrtqL4YgTD4tkiW5LucjIAR0fD1CnlkArUrshUpA4a5
 kvKQx1kvqItfA==
Date: Tue, 11 Aug 2026 18:04:13 +0000
To: linux-fscrypt@vger.kernel.org
Message-ID: <20260811180413.GA2895176@google.com>
References: <20260713023708.9245-1-ebiggers@kernel.org>
 <20260720174323.GA1865@quark>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260720174323.GA1865@quark>
X-Headers-End: 1wtqpp-0003DF-Pl
Subject: Re: [f2fs-dev] [PATCH v3 00/17] fscrypt: Standardize on blk-crypto
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
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
 Zhang Yi <yi.zhang@huawei.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, Baokun Li <libaokun@linux.alibaba.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jul 20, 2026 at 10:43:23AM -0700, Eric Biggers wrote:
> On Sun, Jul 12, 2026 at 10:36:51PM -0400, Eric Biggers wrote:
> > Eric Biggers (17):
> >   blk-crypto: Simplify check for fallback support
> >   blk-crypto: Fold __blk_crypto_cfg_supported() into its caller
> >   blk-crypto: Allow control over whether hardware is used
> >   fscrypt: Fully disallow IV_INO_LBLK_32 with s_blocksize != PAGE_SIZE
> >   fscrypt: Always use blk-crypto for contents on block-based filesystems
> >   Documentation: fscrypt: Update docs for inlinecrypt
> >   ext4: Remove fs-layer file contents en/decryption code
> >   ext4: Make ext4_bio_write_folio() return void
> >   ext4: Further de-generalize the bio postprocessing code
> >   f2fs: Remove fs-layer file contents en/decryption code
> >   fs/buffer: Remove fs-layer decryption code
> >   fscrypt: Replace calls to fscrypt_inode_uses_inline_crypto()
> >   fscrypt: Remove fscrypt_dio_supported()
> >   fscrypt: Remove fs-layer zeroout code
> >   fscrypt: Remove unused functions and workqueue
> >   fscrypt: Merge bio.c and inline_crypt.c into block.c
> >   fscrypt: Add safety checks to non-block-based en/decryption
> 
> Applied to https://git.kernel.org/pub/scm/fs/fscrypt/linux.git/log/?h=for-next
> 
> But I'd still like acks on the ext4 and f2fs patches.

Ted and Jaegeuk, any chance for Acks on the ext4 and f2fs patches?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

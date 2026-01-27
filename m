Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F3BD2594B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 27 Jan 2026 06:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EeGAIihhtaciJZohrs5RtH0sj6U0k7+rS3z5DDvzpIk=; b=RjYiCBJH/PCc0bhr+D16x5OC87
	8z6x8v7cqHJiexx+jR5ed2GEFvDT3Zo5DU/BFN/Et7OVcqZntweecJFTP9VJsRTWAYCX3R0AjcSvR
	UKwMvUlCYPcKEwyAIQJ5+kZcrMCQ8wPFJ+Naf2DwNnh2icF8GXHgwVSDbJc+DmgS6Qr0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vkchN-0008Hx-4g;
	Tue, 27 Jan 2026 06:37:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1vkchL-0008Hq-VV
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Jan 2026 06:37:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RXlfCSlJzGvfIg8Gdaf3mgdKFp6VMz09p1+ww9F4aw8=; b=UkPahRPOjw/GHueWxGg8IHY19G
 /WponriZbFRt39+T1HmywCzqmPZFmEPVwPrfTIYp/GN5g/k9TMla3w9/wwFMSTGpO0hqXj5Osnm1/
 pSIHrXw1omRDWixKnr4L8yEYKlv0DlHGf0aZ1nVSGlU7z9cE0lEQV5Ir8t1ElIgaF4YM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RXlfCSlJzGvfIg8Gdaf3mgdKFp6VMz09p1+ww9F4aw8=; b=ZeRCwy8PFjlD7Tlsp75suaPXwj
 EYu6R/VMGvm7jiKlD6kl55G/GFC19WgHAguf33pdwgxTjIUk5jIqsICG+J2vVVvH5kHLNrs6p1jLy
 dziodq65foWK5NcB4Hlbf9NXXfZPqkrW8BP8iUhPc9HKsYL7zz2uEM+lJB7JFUfEN0oI=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vkchL-0002a9-Et for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Jan 2026 06:37:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D4169227AAE; Tue, 27 Jan 2026 07:36:58 +0100 (CET)
Date: Tue, 27 Jan 2026 07:36:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20260127063658.GA25894@lst.de>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-8-hch@lst.de> <20260126191102.GO5910@frogsfrogsfrogs>
 <20260126205301.GD30838@quark> <20260127060039.GA25321@lst.de>
 <20260127062055.GA90735@sol>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260127062055.GA90735@sol>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1vkchL-0002a9-Et
Subject: Re: [f2fs-dev] [PATCH 07/16] fsverity: don't issue readahead for
 non-ENOENT errors from __filemap_get_folio
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
 Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
 Andrey Albershteyn <aalbersh@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jan 26, 2026 at 10:20:55PM -0800, Eric Biggers wrote:
> > That's new to me, and I can't find anything in the documentation or
> > implementation suggesting that.  Your example code above also does
> > this as does plenty of code in the kernel elsewhere.
> 
> Not sure why this is controversial.

It wasn't controversial until you came up with that claim.

> The documentation for PTR_ERR() is
> clear that it's for error pointers:

Yes, but anything that stores an ERR_PTR is an error pointer.  There
never has been any explicit requirement to first call IS_ERR.

One very common pattern is to extract it first an then check
for errors like:

	error = PTR_ERR(ptr);
	if (IS_ERR(ptr)))
		goto handler_error;

one could come up with arguments that this is special, because error
is not used until after the branch.  But there's plenty of other code
like:

        type = alg_get_type(sa->salg_type);
        if (PTR_ERR(type) == -ENOENT) {
                request_module("algif-%s", sa->salg_type);
                type = alg_get_type(sa->salg_type);
        }

        if (IS_ERR(type))
                return PTR_ERR(type);

>  * PTR_ERR - Extract the error code from an error pointer.
>  * @ptr: An error pointer.
>  * Return: The error code within @ptr.
>  */
> static inline long __must_check PTR_ERR(__force const void *ptr)
> {
>         return (long) ptr;
> }
> 
> Yes, it's really just a cast, and 'PTR_ERR(folio) == -ENOENT' actually
> still works when folio isn't necessarily an error pointer.  But normally
> it would be written as a pointer comparison as I suggested.

You suggestion is using PTR_ERR before checking, to quote from the
previous mail:

> Or as a diff from this series:
>
> -	if (PTR_ERR(folio) == -ENOENT ||
> -	    !(IS_ERR(folio) && !folio_test_uptodate(folio))) {
> +	if (folio == ERR_PTR(-ENOENT) ||
> +         (!IS_ERR(folio) && !folio_test_uptodate(folio))) {



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

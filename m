Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C850AC5B572
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A5yJKLAN7VZ+FTrpKGZuaD53Divo3jcZl+1A1UaPnmU=; b=ddeKzPVg92FbTZwtZfw86E73Az
	1rLelG7Ook192XE5MscH1LFclcr+6vj0NJlG7tI/14Uslwh+EHZz0Z+GEEXPHFmqGwA5TRAW16NTa
	HCql/RzW42f4WUWZAT5VK3WUw6jATAeyQ51ybTzFy4T8Wr5bmEouPz7RhpfWp5qWBuQc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wvrTl-0002tp-O9;
	Mon, 17 Aug 2026 07:09:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wvrTk-0002ti-Ue
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 07:09:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Zm3t1c38cTEBfRxH+JVqhbmIs69TTmzYXUlUTC4lm7U=; b=T0TrhKn2BmaVzdjldU8fWiiufn
 +CwH6ryDRfKBX4XQNFUQ5YgwY4kYlF4dDArVGnJFTVSwtOvwjiAs96e0ZsLy0lY3AC9IWpUcRleK9
 rA+2V8CHWCR9r7VoHqZubxSPLJ7uQZqAxyk1SMNgEv990VkzLAEdIniVkkHSxN50jONI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Zm3t1c38cTEBfRxH+JVqhbmIs69TTmzYXUlUTC4lm7U=; b=BJqEoW/DmPeKD1w3SzqCmaAdgV
 WkfZSz/RvPQQvjtm0RmNMNttgoYIM2LtRL5yUV1Mi4Ct5PJ1UxrzRHhFrnlsHV8Q7wzWbXvjzkwhD
 z7lnAY4rFtOFZI7aWltyvam7q29gpKc5q38JLF0wyEgLstJT3hhjYiTj2bKhFGhV6E9c=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wvrTl-00046M-FU for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 07:09:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DEC2F68CFE; Mon, 17 Aug 2026 09:09:39 +0200 (CEST)
Date: Mon, 17 Aug 2026 09:09:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260817070939.GB17371@lst.de>
References: <20260814092448.1818082-1-aalbersh@kernel.org>
 <20260814092448.1818082-19-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260814092448.1818082-19-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wvrTl-00046M-FU
Subject: Re: [f2fs-dev] [PATCH v15 18/25] xfs: make xfs_free_eofblocks()
 work with fsverity inodes
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
Cc: fsverity@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
 linux-ext4@vger.kernel.org, djwong@kernel.org,
 Carlos Maiolino <cem@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>,
 linux-xfs@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Aug 14, 2026 at 11:24:35AM +0200, Andrey Albershteyn wrote:
> xfs_free_eofblocks() removes any preallocations and unwritten extents
> beyond EOF.

This reads a bit confusing.  I simple removes all extents past EOF
unless the XFS_DIFLAG_PREALLOC or XFS_DIFLAG_APPEND flags are set.

> Add XFS_BMAPI_UNWRITTEN and change xfs_bunmapi_range to remove only
> unwritten extents sitting beyond EOF and set it for fsverity inodes.

Maybe split that from the use of this flag for fsverity?

> -	while (unmap_len > 0) {
> -		ASSERT((*tpp)->t_highest_agno == NULLAGNUMBER);
> -		error = __xfs_bunmapi(*tpp, ip, startoff, &unmap_len, flags,
> -				XFS_ITRUNC_MAX_EXTENTS);
> +	while (startoff < endoff) {
> +		nimaps = 1;
> +
> +		error = xfs_bmapi_read(ip, startoff, endoff - startoff + 1,
> +				&imap, &nimaps, read_flags);
>  		if (error)
>  			goto out;

This gets us extra lookups in the iext tree, which is a bit annoying.
I'd pass the new flag down to __xfs_bunmapi and skip non-unwritten
extents there.  That should also be less code and less churn than
trying to do that in the caller.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

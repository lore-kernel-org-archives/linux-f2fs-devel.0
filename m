Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1E7C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 Jul 2022 17:06:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oEw6F-0003jH-NA; Fri, 22 Jul 2022 17:06:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <tytso@mit.edu>) id 1oEw60-0003ih-LT
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jul 2022 17:05:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x5NY6/np9zWA3SHR+ZSZe4eQA0yfCvzZw1QpBj5Mtco=; b=c38rHqq4Pm1NB1yAlqnarAvGqQ
 t5sxm5uzLs7Oxod2n2ImQWV0NQgKGWyyr7pbOkjRtuYTMY3J650/kIdUZYIO70TGbB/hXuoxPBV93
 39SncXkgMcksBBsljCElI0057FhPY+2cT2rewovgaESIftzFxcgyeECbcaxFGfc62ZPQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=x5NY6/np9zWA3SHR+ZSZe4eQA0yfCvzZw1QpBj5Mtco=; b=JKs31oI59Dp4jqqCIRLDGfRywt
 RrZ9VZgTyKzfcA/+SO+a5rTGYqiCp8PiHqMkA1qz7A1fgmcsw2VQjppdEGINg734u/EDdc8ZrEy0A
 DdY3Jh/ekPLfAEI3FrnfQbOXyxS9vYP8x0hx3FeEjvUXZyZC7SkFZKpmlGnHtBTYuDNo=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oEw5v-0002g9-MR
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jul 2022 17:05:48 +0000
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net
 [173.48.118.63]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26MH5WOt022921
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 Jul 2022 13:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
 t=1658509534; bh=x5NY6/np9zWA3SHR+ZSZe4eQA0yfCvzZw1QpBj5Mtco=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=WAfkNlrXDf4aPxN7fFzehBI53ZqxFDXLOQTBMm9tlVxCimVyVcRdLp72BQwtNN8hq
 xnW7Cn8hAM7rBFQQoLd1JFmBNn1vV3bbmg6dvHuIqgvNRBTHWardQVG3KR44na1iUy
 Q5VNv0fFa36STPRhqqf5ChNgiaqZf+HeO6KmofCzQDjYEQGTAl9qIYCi1+CKGeMz83
 RLVWHW6SaKbQNBKNU8uM738coRNHusUs5825IxfbNZqH96qYWSQROkFt+Xv0wed+E/
 dvJv92G3yoPkPUTGnPPcR5fMowU+n0Lk23UxHZjySPIMB3xtC+vrIgDeExEtHVwMS7
 E35MQaRXt7ayg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
 id 785D015C3EF7; Fri, 22 Jul 2022 13:05:32 -0400 (EDT)
Date: Fri, 22 Jul 2022 13:05:32 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <YtrY3A/nC023v+/V@mit.edu>
References: <20220722071228.146690-1-ebiggers@kernel.org>
 <20220722071228.146690-5-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220722071228.146690-5-ebiggers@kernel.org>
X-Headers-End: 1oEw5v-0002g9-MR
Subject: Re: [f2fs-dev] [PATCH v4 4/9] ext4: support STATX_DIOALIGN
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
Cc: linux-block@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jul 22, 2022 at 12:12:23AM -0700, Eric Biggers wrote:
> -static bool ext4_dio_supported(struct kiocb *iocb, struct iov_iter *iter)
> +/*
> + * Returns %true if the given DIO request should be attempted with DIO, or
> + * %false if it should fall back to buffered I/O.
> + *
> + * DIO isn't well specified; when it's unsupported (either due to the request
> + * being misaligned, or due to the file not supporting DIO at all), filesystems
> + * either fall back to buffered I/O or return EINVAL.  For files that don't use
> + * any special features like encryption or verity, ext4 has traditionally
> + * returned EINVAL for misaligned DIO.  iomap_dio_rw() uses this convention too.
> + * In this case, we should attempt the DIO, *not* fall back to buffered I/O.
> + *
> + * In contrast, in cases where DIO is unsupported due to ext4 features, ext4
> + * traditionally falls back to buffered I/O.
> + *
> + * This function implements the traditional ext4 behavior in all these cases.

Heh.  I had been under the impression that misaligned I/O fell back to
buffered I/O for ext4, since that's what a lot of historical Unix
systems did.  Obviously, it's not something I've tested since "you
should never do that".

There's actually some interesting discussion about what Linux *should*
be doing in the futre in this discussion:

https://patchwork.ozlabs.org/project/linux-ext4/patch/1461472078-20104-1-git-send-email-tytso@mit.edu/

Including the following from Christoph Hellwig:

https://patchwork.ozlabs.org/project/linux-ext4/patch/1461472078-20104-1-git-send-email-tytso@mit.edu/#1335016

> I've been doing an audit of our direct I/O implementations, and most
> of them does some form of transparent fallback, including some that
> only pretend to support O_DIRECT, but do anything special for it at all,
> while at the same time we go through greast efforts to check a file
> system actualy supports direct I/O, leading to nasty no-op ->direct_IO
> implementations as we even got that abstraction wrong.
> 
> At this point I wonder if we should simply treat O_DIRECT as a hint
> and always allow it, and just let the file system optimize for it
> (skip buffering, require alignment, relaxed Posix atomicy requirements)
> if it is set.

The thread also mentioned XFS_IOC_DIOINFO and how We Really Should
have something with equivalent functionality to the VFS --- six years
ago.  :-)


Anyway, this change to ext4 looks good.

Acked-by: Theodore Ts'o <tytso@mit.edu>

							- Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

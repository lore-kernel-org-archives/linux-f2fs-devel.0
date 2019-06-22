Return-Path: <SRS0=xiwZ=UV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0741C43613
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 22 Jun 2019 22:11:31 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE76620862;
	Sat, 22 Jun 2019 22:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Rr0/qlKa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="GWiKdkmx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNHle0+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE76620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1heoEK-0005PD-KC; Sat, 22 Jun 2019 22:11:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1heoEH-0005Ou-14
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 22 Jun 2019 22:11:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gku+NVmLAJr/j6o8Kb9mzcRjV29f2nqOeCsznkQXRNg=; b=Rr0/qlKaEO3PunyuQeTZ6uhk4P
 WXcn7fzhlGLEaKrQ6z0gT+/nWKteSvZC+9uLObTta/4erDCLMXtWRGrJGi5WW4/ASO599sOfa8diL
 TUbl3vGqumAioz5Zy04nJYRPyXZw5iTlOzqrCTTm0qGQd6zD/tDWWRXrT1WFWJbqfW/g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gku+NVmLAJr/j6o8Kb9mzcRjV29f2nqOeCsznkQXRNg=; b=GWiKdkmx/UrHhYYRxZ9VBc7fao
 rQHC/sBY7kTSwkHyzmt9T6gr+oZiZljcBznlGZoNMEJ0cLaVg2hyNqS/nuv4xfYSOTHlO7H6VD/OC
 w78GgZ6uOmY06+DFn/cglvWNFcV2FdPhA5OijbYpNrDI/K4OiTPeFcZgldeSRkVVGa60=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1heoEI-005Ogr-3Z
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 22 Jun 2019 22:11:27 +0000
Received: from localhost (unknown [104.132.1.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7079920862;
 Sat, 22 Jun 2019 22:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1561241480;
 bh=RhKMeMVHiPEptXFqpCXa+Yxdifzh7xBgyuqv4J4b2G8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZNHle0+nFQ+YABTJ0EewWqhzFIEDrQQKGgPyTa437VxsZ+ev7Dt2lfyeOnTevuxOF
 cLcxNoYSUcYErop9bvz47E/Fw8+RQ4ofp/zxefRR0BIaOLQBgl9ojhF4kG4BVbq3sJ
 xL5b3zqMTXnSziOcuWCjE8m71PvNr+31Y/aVGvzc=
Date: Sat, 22 Jun 2019 15:11:19 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20190622221119.GB19686@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190620205043.64350-1-ebiggers@kernel.org>
 <20190620205043.64350-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190620205043.64350-3-ebiggers@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
X-Headers-End: 1heoEI-005Ogr-3Z
Subject: Re: [f2fs-dev] [PATCH v5 02/16] fs-verity: add MAINTAINERS file
 entry
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
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>,
 "Darrick J . Wong" <darrick.wong@oracle.com>, linux-api@vger.kernel.org,
 Dave Chinner <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-ext4@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Victor Hsieh <victorhsieh@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 06/20, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> fs-verity will be jointly maintained by Eric Biggers and Theodore Ts'o.
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>

Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>

> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  MAINTAINERS | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6954776a37e70..655065116f9228 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6505,6 +6505,18 @@ S:	Maintained
>  F:	fs/notify/
>  F:	include/linux/fsnotify*.h
>  
> +FSVERITY: READ-ONLY FILE-BASED AUTHENTICITY PROTECTION
> +M:	Eric Biggers <ebiggers@kernel.org>
> +M:	Theodore Y. Ts'o <tytso@mit.edu>
> +L:	linux-fscrypt@vger.kernel.org
> +Q:	https://patchwork.kernel.org/project/linux-fscrypt/list/
> +T:	git git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git fsverity
> +S:	Supported
> +F:	fs/verity/
> +F:	include/linux/fsverity.h
> +F:	include/uapi/linux/fsverity.h
> +F:	Documentation/filesystems/fsverity.rst
> +
>  FUJITSU LAPTOP EXTRAS
>  M:	Jonathan Woithe <jwoithe@just42.net>
>  L:	platform-driver-x86@vger.kernel.org
> -- 
> 2.22.0.410.gd8fdbe21b5-goog


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

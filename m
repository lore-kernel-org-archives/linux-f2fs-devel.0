Return-Path: <SRS0=AzvF=E5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC46C63697
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2020 18:50:18 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 752C920657;
	Mon, 23 Nov 2020 18:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="lhcYfrCi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="TXC+0FJr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGcuQcTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752C920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1khGul-0000Nw-Jy; Mon, 23 Nov 2020 18:50:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1khGrf-0000GO-QL
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Nov 2020 18:47:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+Aw/smx76BeMn2XlDUhBnNXpwqGa4M3OBbFE1pWtmSg=; b=lhcYfrCiBsgCRIPy4dRFv/8NjQ
 g65QxtQ7uoCGhCw7QVdqnNWKZXzGvIwaLyEGt5sSIBsfM4jFWecUGRMry9q7yay42E2akhiN1bpjj
 mvmzSd1YBIO3feUaacOCtSBy8wtcz9Rh3Nt2OhCfauYHARnVTRUc+MbELt+Y/uv96M1g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+Aw/smx76BeMn2XlDUhBnNXpwqGa4M3OBbFE1pWtmSg=; b=TXC+0FJrgcJRd0syB+LZufLBAx
 ZNkQm3YXEMimeZyg3zx8UGyWEugvz9ct78VxFgOL2LUhxwCevQ3E+5MjZN0F1dT1jM92VRSjEig8Y
 7WWe+IA/TqAockdYP2USnZcUMRmqmb1OZaD5J3m+UCJwF9DmFhtvLde64NnnVovKqY3o=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1khGrb-000umI-D8
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Nov 2020 18:47:03 +0000
Received: from gmail.com (unknown [104.132.1.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C38FC20724;
 Mon, 23 Nov 2020 18:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606157209;
 bh=UtIMi0SFKxzigdnldRadgfBJUTnGFAzotVHREA3Z6uw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dGcuQcTXADPhCET2VVTwHQyHkkr8W7LYUFuKrcwcc/TIrRydZoBZWQ3IMxMUMf/qw
 fsQhVP6M9bBnOj4a7w7rkzz9NSK0cSB12Ep/iBNfd8cXGrQw2xyP5GahT8j/NnMP/4
 uHqqCVKRFUWaPKfI/J3eZtFpjCajeQWVAo1SBo+g=
Date: Mon, 23 Nov 2020 10:46:47 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Daeho Jeong <daeho43@gmail.com>
Message-ID: <20201123184647.GA3694916@gmail.com>
References: <20201123031751.36811-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201123031751.36811-1-daeho43@gmail.com>
X-Headers-End: 1khGrb-000umI-D8
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: add compress_mode mount option
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Nov 23, 2020 at 12:17:50PM +0900, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We will add a new "compress_mode" mount option to control file
> compression mode. This supports "fs-based" and "user-based".
> In "fs-based" mode (default), f2fs does automatic compression on
> the compression enabled files. In "user-based" mode, f2fs disables
> the automaic compression and gives the user discretion of choosing
> the target file and the timing. It means the user can do manual
> compression/decompression on the compression enabled files using ioctls.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  Documentation/filesystems/f2fs.rst |  7 +++++++
>  fs/f2fs/data.c                     | 10 +++++-----
>  fs/f2fs/f2fs.h                     | 30 ++++++++++++++++++++++++++++++
>  fs/f2fs/segment.c                  |  2 +-
>  fs/f2fs/super.c                    | 23 +++++++++++++++++++++++
>  5 files changed, 66 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index b8ee761c9922..0679c53d5012 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -260,6 +260,13 @@ compress_extension=%s	 Support adding specified extension, so that f2fs can enab
>  			 For other files, we can still enable compression via ioctl.
>  			 Note that, there is one reserved special extension '*', it
>  			 can be set to enable compression for all files.
> +compress_mode=%s	 Control file compression mode. This supports "fs-based" and
> +			 "user-based". In "fs-based" mode (default), f2fs does
> +			 automatic compression on the compression enabled files.
> +			 In "user-based" mode, f2fs disables the automaic compression
> +			 and gives the user discretion of choosing the target file and
> +			 the timing. The user can do manual compression/decompression
> +			 on the compression enabled files using ioctls.

Please clarify in the documentation what it means for compression-enabled files
to not be compressed.  It is not obvious.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

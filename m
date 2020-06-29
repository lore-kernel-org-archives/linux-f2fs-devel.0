Return-Path: <SRS0=zfsZ=AK=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991C1C433E2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jun 2020 18:53:43 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73689206A5;
	Mon, 29 Jun 2020 18:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="bCOp3dSI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="UNUAu7hn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKjmzYSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73689206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jpyuV-00037W-4W; Mon, 29 Jun 2020 18:53:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jpyuS-00037M-Ll
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jun 2020 18:53:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jQJf8LHmMUXt50NU+avX3dMtH4TRcIqcMmjj5D6zJRo=; b=bCOp3dSIF7vlDl6rI2BORbEd9L
 KbArNuhVHROEZtmbtNDKZTSyriqvPXhs/+348swnWXUXLjYOADOKh0rPbBRyz1j3Nf8S5VlWAKGPG
 H1XyWvcoLK7PyPELzYLJbWGlKoAMR4dWTCYNFXilBH/BlzgsqAHh6/Y+vRpTpbdKUM3Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jQJf8LHmMUXt50NU+avX3dMtH4TRcIqcMmjj5D6zJRo=; b=UNUAu7hnwEvL9N1GR6wrVkc+3R
 mqb3hIxrTS2ASfFqS1/ecAWV8X3gxNAsN0oUKovdgyVarVaTIEsmXWIzUt8Ie7XmFYG+5orhE+Gh6
 VRq/Ncl+R3gvaguZ4awOP7k3rDC9EEeKxcfj6X3tH1hHfQvFTVQN6BT9Us2aZw3esst4=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jpyuM-002Jcz-L7
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 29 Jun 2020 18:53:40 +0000
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D1E37204EC;
 Mon, 29 Jun 2020 18:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593456802;
 bh=W1gAL231GdpfTzeSawMbnT+/vhlibbLVm5O4BlAr+To=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gKjmzYSiQ96d+bPzFXbNs1Z1D7M6nBioD7k2Kk8wAD8D1sdT0KwrP+7dRymuowCMk
 W1GS85/L4li6HodUiqTV1+eyHgI6f+hLnjoWdVc8se4XffmDaW3gEVcjeX4I5DiRhT
 ryu6Fs1b9zJdpFPcejncKZrU0eIuvxpXWkQEFnC8=
Date: Mon, 29 Jun 2020 11:53:20 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20200629185320.GH20492@sol.localdomain>
References: <20200629120405.701023-1-satyat@google.com>
 <20200629120405.701023-4-satyat@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200629120405.701023-4-satyat@google.com>
X-Headers-End: 1jpyuM-002Jcz-L7
Subject: Re: [f2fs-dev] [PATCH v2 3/4] f2fs: add inline encryption support
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
Cc: linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jun 29, 2020 at 12:04:04PM +0000, Satya Tangirala via Linux-f2fs-devel wrote:
> Wire up f2fs to support inline encryption via the helper functions which
> fs/crypto/ now provides.  This includes:
> 
> - Adding a mount option 'inlinecrypt' which enables inline encryption
>   on encrypted files where it can be used.
> 
> - Setting the bio_crypt_ctx on bios that will be submitted to an
>   inline-encrypted file.
> 
> - Not adding logically discontiguous data to bios that will be submitted
>   to an inline-encrypted file.
> 
> - Not doing filesystem-layer crypto on inline-encrypted files.
> 
> This patch includes a fix for a race during IPU by
> Sahitya Tummala <stummala@codeaurora.org>
> 
> Co-developed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>
> Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Eric Biggers <ebiggers@google.com>

> ---
>  Documentation/filesystems/f2fs.rst |  7 +++
>  fs/f2fs/compress.c                 |  2 +-
>  fs/f2fs/data.c                     | 78 +++++++++++++++++++++++++-----
>  fs/f2fs/super.c                    | 35 ++++++++++++++
>  4 files changed, 108 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 099d45ac8d8f..8b4fac44f4e1 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -258,6 +258,13 @@ compress_extension=%s  Support adding specified extension, so that f2fs can enab
>                         on compression extension list and enable compression on
>                         these file by default rather than to enable it via ioctl.
>                         For other files, we can still enable compression via ioctl.
> +inlinecrypt
> +                       When possible, encrypt/decrypt the contents of encrypted
> +                       files using the blk-crypto framework rather than
> +                       filesystem-layer encryption. This allows the use of
> +                       inline encryption hardware. The on-disk format is
> +                       unaffected. For more details, see
> +                       Documentation/block/inline-encryption.rst.
>  ====================== ============================================================

Last time I suggested adding "When possible, ", and it got added here but not in
the ext4 patch.  It should go in both.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

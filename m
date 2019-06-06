Return-Path: <SRS0=oA2u=UF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D3AC04AB5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Jun 2019 22:45:36 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3412620868;
	Thu,  6 Jun 2019 22:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="iklHNwhh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ZzDT0IIM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjEhdUBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3412620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hZ18Z-0000DS-Mm; Thu, 06 Jun 2019 22:45:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hZ18Y-0000DF-IK
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 06 Jun 2019 22:45:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=60ZvyIPF+iPnvub6c7mLgTNNTXfYDKZbh+I6uumXK40=; b=iklHNwhh2i/9uei8hyHuvuYv6i
 A798x08uUZ3vy+oPJJRHCVDXLs5A1tGjM6HqTUmxrFRdljXCnaHJatJegYgarLtZg8xmCUWen52Qw
 0iEokg4ipoG3EB6Xo0dXO/dxll11luYSiuqObSSxqm4a34+Nm2DQicdNWve41J1oOK8A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=60ZvyIPF+iPnvub6c7mLgTNNTXfYDKZbh+I6uumXK40=; b=ZzDT0IIM9R1QPGyydDZ5dpWJMl
 vfrXmPuIzL8Dto+ge44QHGv5HE3vPOj7UvKTNtD9TNOcI8+oAQjuGXo7MPBFNQt+7XKIpduM7wyDG
 /+EQ0Ir0qbmTwIl/uBm77IBBA97ShJx/9R4Y7flqpT07SYFi67QSDtoVH/GdvYEwSeGA=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hZ18X-00FBVy-Hi
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 06 Jun 2019 22:45:34 +0000
Received: from gmail.com (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 66C1D20868;
 Thu,  6 Jun 2019 22:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1559861127;
 bh=IpeP4llY6H8KG7+vBFY5WZTqeGaAD5HxVZl5eZNKYbc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EjEhdUByVca2KOEz9p6NHR2DzDlvCiSfwrexPZ54Ql+CrCOEMFlgSCRsBsssPLMPl
 bff+yIbFliFhncDBeyopUAVMVuUiq8mYp9QVZZX2Vp899XXpO+bK6s/dnzReJXP77D
 ILdIA0wDj5XPOIjoU8HT4qu9g7iBgEi7CLt0SLLA=
Date: Thu, 6 Jun 2019 15:45:25 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Wang Shilong <wangshilong1991@gmail.com>
Message-ID: <20190606224525.GB84833@gmail.com>
References: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1hZ18X-00FBVy-Hi
Subject: Re: [f2fs-dev] [PATCH 1/2] ext4: only set project inherit bit for
 directory
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
Cc: Andreas Dilger <adilger@dilger.ca>, linux-ext4@vger.kernel.org,
 Wang Shilong <wshilong@ddn.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Message-ID: <20190606224525.Qod5eO5BCg4HVWA4XU7GeBIL2bDXKHisxZv1NlskFQs@z>

On Thu, Jun 06, 2019 at 01:32:24PM +0900, Wang Shilong wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> It doesn't make any sense to have project inherit bits
> for regular files, even though this won't cause any
> problem, but it is better fix this.
> 
> Cc: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> ---
>  fs/ext4/ext4.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 1cb67859e051..ceb74093e138 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -421,7 +421,8 @@ struct flex_groups {
>  			   EXT4_PROJINHERIT_FL | EXT4_CASEFOLD_FL)
>  
>  /* Flags that are appropriate for regular files (all but dir-specific ones). */
> -#define EXT4_REG_FLMASK (~(EXT4_DIRSYNC_FL | EXT4_TOPDIR_FL | EXT4_CASEFOLD_FL))
> +#define EXT4_REG_FLMASK (~(EXT4_DIRSYNC_FL | EXT4_TOPDIR_FL | EXT4_CASEFOLD_FL |\
> +			   EXT4_PROJINHERIT_FL))
>  
>  /* Flags that are appropriate for non-directories/regular files. */
>  #define EXT4_OTHER_FLMASK (EXT4_NODUMP_FL | EXT4_NOATIME_FL)
> -- 
> 2.21.0

Won't this break 'chattr' on files that already have this flag set?
FS_IOC_GETFLAGS will return this flag, so 'chattr' will pass it back to
FS_IOC_SETFLAGS which will return EOPNOTSUPP due to this:

	if (ext4_mask_flags(inode->i_mode, flags) != flags)
		return -EOPNOTSUPP;

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

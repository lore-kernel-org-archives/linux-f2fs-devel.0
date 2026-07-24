Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D5BC531C9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2026 23:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+dGEMMmqWjzKFvmwBW+jURN56pR2PQ3ZxdKn4MJraAA=; b=bzOaCpkMZEYFp/DKTRlxIaHZ7F
	35RVuBwr3W+93EuYxoaBsvHlvZppJVxKTL+coIe5s+499dS8j6OmGOLPzXCX7RRhaWWdRzMWzryig
	l+8CAKiJhQWJGCVSW/txR8AxKEwALJMqSX4nTIM+uB75818lyzGo361Mz6JolXoipt6k=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wnPlj-0004CV-A1;
	Fri, 24 Jul 2026 23:57:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wnPlh-0004CN-Jn
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 23:57:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C0S2kswV9X4RK00vTenlq33sqHknnXJ8l36Z+cCOrHw=; b=OGNRWAXXCdRl3seCu04T2U4Pe6
 378x6/BqHM1bzVcsNvRbDdBWZ17d+vDvTDKXwz/inbaTXfjkZ2JsEE35ZAm0D5SG9d/HMZRO111Uh
 pS73SFM0rPaEByJv0qB1j3xIQdYy7zzJSkKrdGkEyh/YBFEEOhfvMQkBBgmMkJ5cXVMk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=C0S2kswV9X4RK00vTenlq33sqHknnXJ8l36Z+cCOrHw=; b=m8EXKd4+EhJIIIg8JlLCiq3wv9
 M5Rzj+zd02/BmJp49Yhu3j+C4dA/hDgjlGZBUPw1Bze+rHeSOFDlPoc31o1m/bnve23VR24VM18XN
 KWMGmLTpzCOUK96i6amL+DTlOVUJI29oBNsWp1JclyROBBNwGnlN9JXzS+th+uAFGXJk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnPle-0007eV-Ms for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 23:57:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DB178600AD;
 Fri, 24 Jul 2026 23:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E051F00A3A;
 Fri, 24 Jul 2026 23:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784937440;
 bh=C0S2kswV9X4RK00vTenlq33sqHknnXJ8l36Z+cCOrHw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bCyKY8CIpwOcIVw1Calx1/kJVRmpUX/mI5E/uRHL73C3zvnjGYkeZAaOuSttdlCJn
 vGtG9tlRK+OIfFnqFI30F55IEOvHX0mgkuGh/wwwos2GzDQgwses019ZV3RUUdxsWg
 vBwn5mCKUZahVt1K7KzLqBzaMxBevZWGgpvu4KdBwGF491YQbaELDtUN9nKwF3acGk
 np25i8NMPwSxnVvBjkV9iCbyJ1sJbAMxAssmBpAbdD5PKAWXnxHrSi/t4KU6OdGrqD
 OJIhZlZR+SapJdQ1a3vASLffq20YPOFz7MqlThxqSOvv6cMuxn51B9VnSaY+qaJyjn
 Fd1j+SiJ9Uf/w==
Date: Fri, 24 Jul 2026 16:55:28 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260724235528.GD1901@sol>
References: <20260721184346.416657-1-aalbersh@kernel.org>
 <20260721184346.416657-7-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260721184346.416657-7-aalbersh@kernel.org>
X-Headers-End: 1wnPle-0007eV-Ms
Subject: Re: [f2fs-dev] [PATCH v13 06/23] fsverity: don't allow setting DAX
 file attribute on fsverity files
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
Cc: fsverity@lists.linux.dev, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jul 21, 2026 at 08:40:43PM +0200, Andrey Albershteyn wrote:
> When fsverity is enabled on the file, with FS_IOC_ENABLE_VERITY ioctl(),
> it checks if file has DAX enabled and fails if that's true. However, the
> opposite case is not checked.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/file_attr.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index bfb00d256dd5..5424ec4e3949 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -246,6 +246,11 @@ static int fileattr_set_prepare(struct inode *inode,
>  	if (fa->fsx_cowextsize == 0)
>  		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
>  
> +	/* Can not enable DAX on fsverity file */
> +	if ((old_ma->fsx_xflags & FS_XFLAG_VERITY) &&
> +			fa->fsx_xflags & FS_XFLAG_DAX)
> +		return -EINVAL;
> +

As mentioned elsewhere, this is actually already checked in ext4, and
the commit message should mention this.

Also, I notice this function already checks conditions on when the DAX
flag can be enabled:

        /*                                                                       
         * It is only valid to set the DAX flag on regular files and             
         * directories on filesystems.                                           
         */                                                                      
        if ((fa->fsx_xflags & FS_XFLAG_DAX) &&                                   
            !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))                 
                return -EINVAL;                                                  

Could we combine those into something like the following so the DAX
enablement conditions are in one place?

        if (fa->fsx_xflags & FS_XFLAG_DAX) {                                     
                if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))          
                        return -EINVAL;                                          
                if (old_ma->fsx_xflags & FS_XFLAG_VERITY)                        
                        return -EINVAL;                                          
        }                                                                        

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

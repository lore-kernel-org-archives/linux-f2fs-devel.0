Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4811FC433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 29 Nov 2022 16:52:03 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p03pw-00021V-RR;
	Tue, 29 Nov 2022 16:52:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1p03pv-00021P-D5
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Nov 2022 16:51:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=45hGUgPtfnIqpFuvLdN4IM0IpzAYQDfsiDIvYZX7UkM=; b=ZGfGtznChkFPCNkAS1LoTbvVEl
 dlIun+5LSB7YFeq2qMvaNGTWEuKSO5USvX4bd5ID0CBonb1iBT6wGzdUrRIi8jIVSlH95rngxDCpY
 asKYVbNP27aH09K8VzL4/snq5J6gTQkf9U+yWtRkrV2TSccA/1Z3hgCp7HIVSH6iNHBE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=45hGUgPtfnIqpFuvLdN4IM0IpzAYQDfsiDIvYZX7UkM=; b=jyFjlzFg38ZyIC6wInSAXZyD/A
 BYLeLFpaEVPvLVTIBMtzJK0e6wuLGA5mPwhOehPA9eRheo/sYM5mw1G2M2c08bXxGHOXiRPyaKz1r
 0XI2qfpsO+YFRwigvusTAH5lN4uEfcPkbrQdcfsjfegY56h+0EvJxEyoUuX/O0EKsSFA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p03pu-000R5H-Md for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 29 Nov 2022 16:51:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4CFB7617F5;
 Tue, 29 Nov 2022 16:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE57C433D6;
 Tue, 29 Nov 2022 16:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669740712;
 bh=OG0V3fJSaB1O9++bS4I6UHOavsS9t5ZDRoz79lFsjvU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=torJRXCD1FRGCNmuNCB64ibAevmnJMruXAp0l+uvJn7GZCal9GT34z+/VhPsn9B80
 CzWRb+0qL3byvr4SBcP/oa3dgkn1b5pVtzy/94jSGBF1qssm1xKpeREPaO/v7+3uS4
 levEqH5xq+cRSLQyXEU9Nb9pvFDvtN8z5AITKLbXR+fFRZJMDvxweu2ESS51cxwBTe
 rNffgeJGxFht9/ZAwqkgBSlv9NZgtUwwg2PvUjHC3g9HmbWboE1UbOkLN+5BG8TkZd
 Clvw4YtE0Wv7AJLyZQpU8us8KhDIOLjM0CZUSD5W3LKV5JgUm3Ion3lWbJHx+XTjEy
 HxpDIX9KLWj4Q==
Date: Tue, 29 Nov 2022 08:51:51 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <Y4Y4p2wpB0SOaXmz@google.com>
References: <20221129073559.203528-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221129073559.203528-1-ebiggers@kernel.org>
X-Headers-End: 1p03pu-000R5H-Md
Subject: Re: [f2fs-dev] [xfstests-bld PATCH] test_appliance: add
 f2fs/compress config
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
Cc: Theodore Ts'o <tytso@mit.edu>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 11/28, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add a f2fs/compress configuration which causes all files to be
> automatically compressed, similar to how f2fs/encrypt causes all files
> to be automatically encrypted.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>

Thanks, :)

> ---
>  test-appliance/files/root/fs/f2fs/cfg/all.list | 1 +
>  test-appliance/files/root/fs/f2fs/cfg/compress | 5 +++++
>  2 files changed, 6 insertions(+)
>  create mode 100644 test-appliance/files/root/fs/f2fs/cfg/compress
> 
> diff --git a/test-appliance/files/root/fs/f2fs/cfg/all.list b/test-appliance/files/root/fs/f2fs/cfg/all.list
> index bc796ff..90a7a36 100644
> --- a/test-appliance/files/root/fs/f2fs/cfg/all.list
> +++ b/test-appliance/files/root/fs/f2fs/cfg/all.list
> @@ -1,2 +1,3 @@
>  default
>  encrypt
> +compress
> diff --git a/test-appliance/files/root/fs/f2fs/cfg/compress b/test-appliance/files/root/fs/f2fs/cfg/compress
> new file mode 100644
> index 0000000..6f2b954
> --- /dev/null
> +++ b/test-appliance/files/root/fs/f2fs/cfg/compress
> @@ -0,0 +1,5 @@
> +SIZE=small
> +export MKFS_OPTIONS="-O compression,extra_attr"
> +export F2FS_MOUNT_OPTIONS="compress_extension=*"
> +REQUIRE_FEATURE=compression
> +TESTNAME="F2FS compression"
> -- 
> 2.38.1
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

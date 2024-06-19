Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB23C27C4F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Jun 2024 01:30:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sJk9N-0001pR-5g;
	Wed, 19 Jun 2024 01:30:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sJk9M-0001pK-39
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Jun 2024 01:30:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9G4NWrnDuBsQn+z9dDskkjB7DvU9avqUC9yseL8BbC8=; b=lnv+68ceDE2crAZSJiv8PxtshC
 W7LM2nrvT5xFqPCDykBKnkmvNGVbSvkOJvw/gez4QVQyBy3SjI8Fgy2a5pSO9s1tgo2YX6z7dIxb4
 c3gEEq0sJ+3Jd5YXC9MbDtoFPZiANIWEoIiCCTlaZCeTFb32RiDbvOuxymyZZ/uNyBvQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9G4NWrnDuBsQn+z9dDskkjB7DvU9avqUC9yseL8BbC8=; b=Atmb5lefurKnMZ5dlPc+nmK0Ar
 X7/w0K3jZ4cr6ZDPFIVaWamnoISyQV6D8JZFhDPkEnhWboWH6qqPIaH3aLe2+cAWdhzYEswgz7KDV
 Fr90F6HXHc/ypzQD4sPnWAqHT/M/BXiWCRFA7p/18UriBZc8JN3XEx2Sqe4pJoCfHqmU=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sJk9N-00042H-32 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Jun 2024 01:30:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 9CD47CE1D23;
 Wed, 19 Jun 2024 01:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C09AC3277B;
 Wed, 19 Jun 2024 01:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718760604;
 bh=chJtEK+eNScDN7oyX0r/g3HGw25ZnD2qPZgwIVzUpFs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Wuw4AEIhHwQTFz+6Twdfc1BR5081wAhizAbI/o3JTWHAyu015jQv2cz76L16BVxt8
 CCQ2/j0D0yEcy8XeQBiImaxsleM4yFItP2lu1ejCpPYxq6r/pxVw2SeJKLe31gxAi1
 +lOkEkLU5NQ9A5cu1dKRyPjP3JkYGlr/jFQJyaOTSLEm0coHHNXDHVTcTNMSdvmMlv
 SjsQvNCjT2NTOI71C0RbrUyUoNgfxD95O9LEVBMd9AVuHjOBAq+sSoLq2eeK4LMFsJ
 8B5UlQiJwYOOUdXIYEYBMQtpariSP7c+INiW1/5Un0v0MSo+B5AGfdgzyk/XGtT4pY
 BwpxFrHHOiiPA==
Message-ID: <f36fe619-da24-4b8f-ae3c-75064658e264@kernel.org>
Date: Wed, 19 Jun 2024 09:30:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daniel Rosenberg <drosen@google.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240619012509.1885974-1-drosen@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240619012509.1885974-1-drosen@google.com>
X-Headers-End: 1sJk9N-00042H-32
Subject: Re: [f2fs-dev] [PATCH] dump.f2fs: Add help description for -rfyPo
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@android.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/6/19 9:25, Daniel Rosenberg wrote:
> These were described in man pages, but not within the help message.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

Can you please check below patch?

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/commit/?h=dev-test&id=c07b0954506a159f68358edddc09be0a4d810e61

Thanks,

> ---
>   fsck/main.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/fsck/main.c b/fsck/main.c
> index 6edc902..901fa7a 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -97,6 +97,11 @@ void dump_usage()
>   	MSG(0, "  -S sparse_mode\n");
>   	MSG(0, "  -a [SSA dump segno from #1~#2 (decimal), for all 0~-1]\n");
>   	MSG(0, "  -b blk_addr (in 4KB)\n");
> +	MSG(0, "  -r Recursively dump from the root inode\n");
> +	MSG(0, "  -f Do not prompt before dumping\n");
> +	MSG(0, "  -y Alias for -f\n");
> +	MSG(0, "  -P Preserve mode/Owner/Group for dumped inode\n");
> +	MSG(0, "  -o <path>  Dump inodes to the given path\n");
>   	MSG(0, "  -V print the version number and exit\n");
>   
>   	exit(1);
> 
> base-commit: c1a97862b05d8a736ad8719939395c61bd71c982


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

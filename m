Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AD2C761AF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Apr 2023 02:52:06 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pjtFk-0007rr-H7;
	Wed, 05 Apr 2023 02:52:05 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pjtFj-0007rl-Iz
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 02:52:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mOQG9soLH77ckt/ITHKnosmsRaxgvw/wVF+QPUDh5k4=; b=mBpn573rSJ16zZ/2N8cQJgbqqy
 c/U3HQghB+89dvxBl/2KTaTIEM+euecZSJRbJjWjQ0aMcTi61X+V9YMs513DY/wUvNAMmmeKKGWBU
 6+GkpgwRAmXuzylUtmU6FvD1ZoawN1I5Q89TbYpEW01yccAdaPiwCPB3b2yxPPqozXBk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mOQG9soLH77ckt/ITHKnosmsRaxgvw/wVF+QPUDh5k4=; b=WBv+w2waZQpGAANIYYM+YXMKfX
 Y5VuVBk6X6PFCEh+HCB8d7SrBw1SY/NwTEacFl/f1VEAiqfSGPI++CyYsXmldm6qC2cdGlvDYsDb+
 LMcr5i6aj1tO+COd3pMGLtFrKFPeijg4mE64T8qqNjiZVChfbGH8tygI2tkUimT4Igwg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pjtFj-00FcwS-V5 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 02:52:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 80D7960C3B;
 Wed,  5 Apr 2023 02:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1957DC433EF;
 Wed,  5 Apr 2023 02:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680663117;
 bh=1fWeJBdYiBKbc3l99oUMDbBH7uYf9rS5M3WkIzgGIGw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KmJ67J2KKMHo6NlKpq988i4aesqcBIiO0vVXFFxrNDf03IH7JKCNPWRKVOE1vMYbE
 6Rn3o0CsycQqUoebDo6oCYfNviz7+v0J5qNjqvE8rF+zMNuxw3iN9NQJPuG6Yc5bzf
 oD3SsMjCTvBHltjrmCeqww9GH9rrZlhqEqWNJHO/xy9osfiCnmcL2ElY5uuCw/NSsk
 lkd6vJRSlJPXmzDt2i/3pXuGelXOycarQJVGAXO7ftVSZBQBs6s4bwebYbk9eisxCx
 1yMIhX8JLVd/pvYHkuYYij7yYE8eu3bMyEoSCxANQiQLnzeCrz6rmV7ZDwopFWH141
 vaZv2C5kiuQCg==
Message-ID: <b5f99276-29cd-ca61-abc2-a927d992f40a@kernel.org>
Date: Wed, 5 Apr 2023 10:51:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230330165648.33907-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230330165648.33907-1-frank.li@vivo.com>
X-Headers-End: 1pjtFj-00FcwS-V5
Subject: Re: [f2fs-dev] [RESEND] f2fs: set default compress option only when
 sb_has_compression
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/3/31 0:56, Yangtao Li wrote:
> If the compress feature is not enabled, there is no need to set
> compress-related parameters.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Patch looks fine, but it's better to fix similar issues in one
patch.

e.g.
f2fs: add compression feature check for all compress mount opt

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> ---
>   fs/f2fs/super.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 768be1c76a47..b5828a67f7c1 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2073,10 +2073,12 @@ static void default_options(struct f2fs_sb_info *sbi)
>   	F2FS_OPTION(sbi).fsync_mode = FSYNC_MODE_POSIX;
>   	F2FS_OPTION(sbi).s_resuid = make_kuid(&init_user_ns, F2FS_DEF_RESUID);
>   	F2FS_OPTION(sbi).s_resgid = make_kgid(&init_user_ns, F2FS_DEF_RESGID);
> -	F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZ4;
> -	F2FS_OPTION(sbi).compress_log_size = MIN_COMPRESS_LOG_SIZE;
> -	F2FS_OPTION(sbi).compress_ext_cnt = 0;
> -	F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
> +	if (f2fs_sb_has_compression(sbi)) {
> +		F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZ4;
> +		F2FS_OPTION(sbi).compress_log_size = MIN_COMPRESS_LOG_SIZE;
> +		F2FS_OPTION(sbi).compress_ext_cnt = 0;
> +		F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
> +	}
>   	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
>   	F2FS_OPTION(sbi).memory_mode = MEMORY_MODE_NORMAL;
>   


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F47C77B7A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  2 Jun 2023 09:44:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q51Kd-0002lL-HF;
	Fri, 02 Jun 2023 09:44:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q51Kc-0002lF-JV
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Jun 2023 09:44:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eBzdastk4u8C3Sq3kCvqexb2Oyf5EX9jz+iO65Btlz0=; b=bqKhtRX6P+J/UIyYFiuanuSJIy
 KRTihOp8t6ZwketuYgdcUYSBo1MtE4D7flmtPHHpdZx6EH0Twh6pkVPwwP5/uelxtTngHVj/teoH/
 FZIdKbGhx6pAh7FjToCZF32sxARPJvq0UiptGEkBbrB85ptETVxokxl5fQYwjYm2MJ8I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eBzdastk4u8C3Sq3kCvqexb2Oyf5EX9jz+iO65Btlz0=; b=PMq4wqggXnH6ppRwCSZtgjrkFU
 Bs77ae9IlX7j8MCMxLVCtreyNXDT1vRqaYPUSO4oAdqndzp5OPxzrugGdt7fFw2sD6flpjgTa4H4V
 WGtkXkWiEZrUP2tc83DE0cKQqePy7sjYRjjSYiRv6/yICKGjFjAJf8CVDv+2pk07JCgg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q51Kc-00089U-Ey for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Jun 2023 09:44:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 144B160C1F;
 Fri,  2 Jun 2023 09:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAD6C433D2;
 Fri,  2 Jun 2023 09:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685699060;
 bh=0y9eWDGXSBQy6Oyvh0HUtH6cc6K4fP/cZiehJc0UCxM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Kt7cYnBYJFXJ+VSdH9sebY/SqXG3nRCo8I7J1VNR13fPp/47mnZO2CCIc0CpXz053
 jpUh1SYK2QAFBGAISxxxdtkAjQQMWvrjrdxFpwMbjKECzmYpZ9liVyhtL26h0xdSMt
 lwi/FwsvArh32YyFJSig3BzhMA42NEAzRyic2CbfiOgnQLBM9qyhMdp/gFwhfeYgWJ
 KM36itFxTP+HdBkk71agcRLi6w+H3Xp0OKC1aSTvcgqmB3e3zrE1uyFyQFyJx9NAQs
 hi/ujS2jMniBwmtIsvW8BHm/W5QNST1UY8oAWjs/Kfddx+emkyAYfSP4RpTU5Oen8H
 zUbmk8teKhRqA==
Message-ID: <06a2e4dc-fb28-24cf-0a41-3c281a9b2848@kernel.org>
Date: Fri, 2 Jun 2023 17:44:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Maxim Korotkov <korotkov.maxim.s@gmail.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230531072238.370186-1-korotkov.maxim.s@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230531072238.370186-1-korotkov.maxim.s@gmail.com>
X-Headers-End: 1q51Kc-00089U-Ey
Subject: Re: [f2fs-dev] [PATCH] fsck.f2fs: fix memleak in f2fs_create()
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
Cc: Maxim Korotkov <maskorotkov@rasu.ru>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/5/31 15:22, Maxim Korotkov wrote:
> In error handling cases, exiting a function without releasing memory
> Added tags to clean up resources and return error code
> Found by RASU JSC
> Signed-off-by: Maxim Korotkov <maskorotkov@rasu.ru>
> ---
>   fsck/dir.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fsck/dir.c b/fsck/dir.c
> index 4a3eb6e..c3508bf 100644
> --- a/fsck/dir.c
> +++ b/fsck/dir.c
> @@ -704,7 +704,7 @@ int f2fs_create(struct f2fs_sb_info *sbi, struct dentry *de)
>   	ret = convert_inline_dentry(sbi, parent, ni.blk_addr);
>   	if (ret) {
>   		MSG(0, "Convert inline dentry for pino=%x failed.\n", de->pino);
> -		return -1;
> +		goto err_free_parent_dir;

How about:

	ret = -1
	goto free_parent_dir;

>   	}
>   
>   	ret = f2fs_find_entry(sbi, parent, de);
> @@ -728,7 +728,7 @@ int f2fs_create(struct f2fs_sb_info *sbi, struct dentry *de)
>   		if (hardlink_ni.blk_addr == NULL_ADDR) {
>   			MSG(1, "No original inode for hard link to_ino=%x\n",
>   				found_hardlink->to_ino);
> -			return -1;
> +			goto err_free_child_dir;
	ret = -1
	goto free_child_dir;

>   		}
>   
>   		/* Use previously-recorded inode */
> @@ -805,6 +805,11 @@ free_child_dir:
>   free_parent_dir:
>   	free(parent);
>   	return 0;

	return ret;

Thanks,

> +err_free_child_dir:
> +	free(child);
> +err_free_parent_dir:
> +	free(parent);
> +	return -1;	
>   }
>   
>   int f2fs_mkdir(struct f2fs_sb_info *sbi, struct dentry *de)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

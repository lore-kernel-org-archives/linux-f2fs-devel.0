Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643C3C76188
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Apr 2023 01:16:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pjVHx-0005Rq-JY;
	Tue, 04 Apr 2023 01:16:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pjVHv-0005Qv-JR
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 01:16:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L153HcRuruhlSlcGPUpRvHvvIoON7VuuLV9JPdOMJgE=; b=CEpOVGXCydZ5yXWP2GW1WM0q2/
 4HBE70+cw1UVI4L0EGqbup9E3oGYraqIWK99utvvq6lmifJS+2+6ehSzUWSb8CEQupTCiP/8cYcHL
 PrkvfjiKiCoJs8t+ED5bonw+8AnU3VUZxU2SdIhJi9mIq1fGQzVCQBqULFnNI2dKZs/c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=L153HcRuruhlSlcGPUpRvHvvIoON7VuuLV9JPdOMJgE=; b=fH/vrpOsWNsnBWiCPBLrFvwK78
 cLr0y2Pi1favxVjSATZTpYMOIxG/jRJgvmJOn/+RgjOu7lTYOJtbuxu0rZ1dq3ATTomLnyJQfN73B
 yWRWBjLjGNzxwRByOZtTpsgZsDU9QxnKZ/OU1vIHiOHHPhVL/65cvl2cxEW7xx0zE1ZU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pjVHs-0007mG-Ia for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 01:16:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0830F61627;
 Tue,  4 Apr 2023 01:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B40C433D2;
 Tue,  4 Apr 2023 01:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680570993;
 bh=ImnzqcPQJHnWnlK8ylnOnQS3YAQ3sNcQ92eD3xoDbq8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Sjx6yjbtf6SN1EgfbkCuvIp60VLjP0+4e2Lu4AEVPzlWM4u0GjdN+S/xuwnUS+8sX
 919EQa5LUhSsM/z9XnX3Nc9OWTyVY7ShNHLZnGINtH1iRmssTA8UdyaUFMQ8ZY7ege
 /28ieBV/+RMFuKXuUf0PA2g4ZBSb9UYrLzppi/XAbwWszXFMK3ZFkpGxQSxy/aQ/Y+
 CzqroVEsQ3p3CRbc+ZnLvdC/BeXWwLv839Su+fuh8+knCeKw3MOFwbiEXBSvJEQaAO
 Ckyw7s5iSVQalPjngaCtsTVFIfCsZhPFf+Qzmwl1SO9USBOGWZd/F3+XWU9XHubRLd
 DYBX7jZHDsjaA==
Message-ID: <5b766d0c-fae7-885a-0dc9-a16d90540260@kernel.org>
Date: Tue, 4 Apr 2023 09:16:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20230330162811.18923-1-frank.li@vivo.com>
 <20230403133359.6649-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230403133359.6649-1-frank.li@vivo.com>
X-Headers-End: 1pjVHs-0007mG-Ia
Subject: Re: [f2fs-dev] [RESEND] f2fs: add sanity compress level check for
 compressed file
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
Cc: jaegeuk@kernel.org, terrelln@fb.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/4/3 21:33, Yangtao Li wrote:
> Hi Chao,
> 
>> Why not zstd_max_clevel()?
> 
> zstd_max_clevel() is only defined when CONFIG_F2FS_FS_ZSTD is enabled,
> using zstd_max_clevel() will result in compile errors otherwise.
> 
> If using the following code,
> 
> ----------------------------------------------------------------------------
>          switch (ri->i_compress_algorithm) {
>          case COMPRESS_LZO:
>          case COMPRESS_LZORLE:
>                  if (compress_level)
>                          goto err;
>                  break;
>          case COMPRESS_LZ4:
>                  if ((compress_level && compress_level < LZ4HC_MIN_CLEVEL) ||
>                                  compress_level > LZ4HC_MAX_CLEVEL)
>                          goto err;
>                  break;
> #ifdef CONFIG_F2FS_FS_ZSTD
>          case COMPRESS_ZSTD:

Hi Yangtao,

How about:

#ifdef CONFIG_F2FS_FS_ZSTD
	if (!compress_level || compress_level > zstd_max_clevel())
		goto err;
#endif
	break;

>                  if (!compress_level || compress_level > zstd_max_clevel())
>                          goto err;
>                  break;
> #endif
>          default:
>                  goto err;
>          }
> ----------------------------------------------------------------------------
> 
> then we will get this result:
> 
> 	F2FS-fs (loop0): sanity_check_compress_inode: inode (ino=4) has
> 			unsupported compress level: 0, run fsck to fix
> 
> Another way is to use the following code, which ignores the check for
> level when CONFIG_F2FS_FS_ZSTD is not enabled.
> 
> ----------------------------------------------------------------------------
>          switch (ri->i_compress_algorithm) {
>          case COMPRESS_LZO:
>          case COMPRESS_LZORLE:
>                  if (compress_level)
>                          goto err;
>                  break;
>          case COMPRESS_LZ4:
>                  if ((compress_level && compress_level < LZ4HC_MIN_CLEVEL) ||
>                                  compress_level > LZ4HC_MAX_CLEVEL)
>                          goto err;
>                  break;
>          case COMPRESS_ZSTD:
> #ifdef CONFIG_F2FS_FS_ZSTD
>                  if (!compress_level || compress_level > zstd_max_clevel())
>                          goto err;
>                  break;
> #else
>                  return true;
> #endif
>          default:
>                  goto err;
>          }
> ----------------------------------------------------------------------------
> 
> Perhaps exporting ZSTD_MAX_CLEVEL is a better choice?
> 
> Thx,
> Yangtao


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

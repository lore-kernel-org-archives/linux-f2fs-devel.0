Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0817FECAAA1
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Oct 2022 13:31:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oo2yl-0006XW-Gl;
	Thu, 27 Oct 2022 13:31:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oo2yj-0006XQ-RD
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Oct 2022 13:31:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wEpySnLW/MvRBgp5LE3fVQs4KPlJQQ1HndXIlHoJn6Q=; b=lOxn8MAn5G/NI7JsPOoDQSy1iv
 lV7X/e1LXoyQuQ1fROvzCF4PNZa0t0vn95oeuUFGRx5Z9h6gecDgXca6M1387vXFSrm7MvngTviF1
 YLpId3wqS+kVzwFu3bQSECSZIhdIR2uZRa0uEjijdKMuskUznmoK/Y0OEo79F/KIR4Rg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wEpySnLW/MvRBgp5LE3fVQs4KPlJQQ1HndXIlHoJn6Q=; b=JvpjHN34ka7s7OEUIn7/p7xGlG
 0gan9MyQPY7jgs0DbsOSsXSlm8S22WdeG1EndfXA+QbaK/2/uomFGWPtn0ISFmL0HmVyioUisRdAQ
 8XZkczHXgr5FYub8oD7R92mE5953MZO0wH82Bqfxwia/KPPy4L8SAsuTqVM1rfq3bQFc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oo2yd-001zJy-Kj for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Oct 2022 13:31:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6DC39622FB;
 Thu, 27 Oct 2022 13:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68757C433C1;
 Thu, 27 Oct 2022 13:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666877468;
 bh=nYDbxu1bhOneACR7AmCTTyuASVG29Q2OMg11MLfO52o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WPkFQFaXci1RVAACJDfVHY3yKsUP+t6tRQnDQRNaNw76u/C8uX5gwAlHUM4cTAaXk
 D2glN7dj1PEv3xnMbMQTiKrOEvAZz/L1AFEUmFpapoFSdchpYuRYBN8zADwmpHII+3
 pOgTehG+K/EVkejcznDUvS6o89A19dDwCpAAOMImIhvOhpzMXoqldjxCMSTuE0Z4cg
 m8lRaIhc3/GlDvNTZ/mHJsRg2OR1wCobzVBEHeuEFgsIEqYr23dzEslgRb8jhDYs6t
 s/nI6GzWkRFzUopiFH9bnxjEDQcb45y2mpW1p+ELP2DRcCZAVZb+qyS9NvL4xdXpKh
 Iw1bfWqdIPUwg==
Message-ID: <ab2f3576-bedd-8c27-5549-f9ff5462aee3@kernel.org>
Date: Thu, 27 Oct 2022 21:31:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20221027120807.6337-1-frank.li@vivo.com>
 <20221027120807.6337-3-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221027120807.6337-3-frank.li@vivo.com>
X-Headers-End: 1oo2yd-001zJy-Kj
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: fix to f2fs_handle_critical_error
 when errors=remount-ro
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

On 2022/10/27 20:08, Yangtao Li wrote:
> When a fatal error occurs in the file system and it is
> remounted to ro mode, the flush thread needs to be stopped.
> 
> Fixes: d81ab30e85a5 ("f2fs: support errors=remount-ro|continue|panic mountoption")

Do you mind letting me merge these two patches into original patch?
since original patch is still in dev branch, rather than mainline.

I guess it needs to stop ckpt thread as well...

Thanks,

> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/super.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index fc220b5c5599..3a1238a82dc9 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4017,6 +4017,7 @@ void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
>   
>   	f2fs_stop_gc_thread(sbi);
>   	f2fs_stop_discard_thread(sbi);
> +	f2fs_stop_flush_thread(sbi);
>   }
>   
>   static void f2fs_record_error_work(struct work_struct *work)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

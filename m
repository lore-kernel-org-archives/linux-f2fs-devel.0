Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0E9C7EE2A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  2 Jun 2023 08:52:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q50WG-0003mU-Rb;
	Fri, 02 Jun 2023 08:52:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q50WF-0003mO-E3
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Jun 2023 08:52:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SArMl7Zl2dVRGwT5Hjc7TnA+8LaypSig0ji9nMQf7JU=; b=LdQnTfmkc5l2IRQBE4x9veizci
 TezE26ZDmn7rZve2N3yTB5j8Bz9P+AE1bB4Pkdx5cVEqSnrqdX+Siu4TxYKUEXdOMkm1IRCREGAY3
 tjtBcUK2gwUY6FWMMwQUacYwe6VDgHgtiUEhug3nLhd41RVgdNX/OKLTBYDCvfHDW4tU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SArMl7Zl2dVRGwT5Hjc7TnA+8LaypSig0ji9nMQf7JU=; b=cGGAi4zoFiikqn/9LhGRyn5oSg
 v0wdpwobSvkXDhoxvOXlRnyOf69pL101/WUwGQ/zr0uTOny3SOtZBVgN1CpS0xp2c8KIruO7qAIrm
 MeC7Xi8xRa5rS1tfaD5NTCSINDwYR3XTIS4O+jhHDCBYN+QzAZ03StnLaqm3ojyLNsNE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q50WC-00976O-CC for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Jun 2023 08:52:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BB39A6150C;
 Fri,  2 Jun 2023 08:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A63C4339B;
 Fri,  2 Jun 2023 08:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685695934;
 bh=UUGsYsnqEu8jbU1zwSqU8HEf+QxK5Ufh42Kq2cX812M=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=KHqzk+sGr6rUNDHQKL0DvRCMons0WUTQ4bg2zqUGrUTJWyrkb+ExeDnEamMtinDgk
 KMrmZDDa48EpyFwsDhgH6qRPu9OMhzyZAdqyTggANdLHSGVm838PMB2/heDuYc3ZiE
 Xg5ES/bRhMVgdTlHIwRc+2oKlOTuMwGIJlunlIiYhPxKH1ddOxQqkdlyFBsiotfCij
 YDiMCL0qE7eaJmdAQUt73fvWmsYTDPDtqft0MrH44AhMBTzIRcIP0C2F4FGR/XBwLv
 dIl1GW6PStqSIsCaOH5QafPgNTovlREC5wwfGmkEFa6FCD0PSTxAHGmG5QeM61g8Kd
 NqkyTTKqaVLTw==
Message-ID: <f301845f-c358-4632-1df5-5944d7483072@kernel.org>
Date: Fri, 2 Jun 2023 16:52:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: beomsu7.kim@samsung.com, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Yonggil Song <yonggil.song@samsung.com>, Seokhwan Kim
 <sukka.kim@samsung.com>, Daejun Park <daejun7.park@samsung.com>,
 Seonghun Kim <seonghun-sui.kim@samsung.com>
References: <CGME20230602044830epcms2p141ec782e866c2adc5a3142516f051b87@epcms2p1>
 <20230602044830epcms2p141ec782e866c2adc5a3142516f051b87@epcms2p1>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230602044830epcms2p141ec782e866c2adc5a3142516f051b87@epcms2p1>
X-Headers-End: 1q50WC-00976O-CC
Subject: Re: [f2fs-dev] [PATCH] f2fs: including waf data in f2fs status
 information
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/6/2 12:48, beomsu kim wrote:
> When evaluating in f2fs, it takes much time to obtain waf data.
> This patch helps to obtain waf data without calcluation.
> 
> Signed-off-by: Beomsu Kim <beomsu7.kim@samsung.com>
> ---
>   fs/f2fs/iostat.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/fs/f2fs/iostat.c b/fs/f2fs/iostat.c
> index 3d5bfb1ad585..6eab11b0610d 100644
> --- a/fs/f2fs/iostat.c
> +++ b/fs/f2fs/iostat.c
> @@ -34,10 +34,22 @@ int __maybe_unused iostat_info_seq_show(struct seq_file *seq, void *offset)
>   {
>          struct super_block *sb = seq->private;
>          struct f2fs_sb_info *sbi = F2FS_SB(sb);
> +       int j;
> +       unsigned long long waf = 0;
> +       unsigned long long data_written_to_storage = 0;
> +       unsigned long long data_written_by_user = 0;
>   
>          if (!sbi->iostat_enable)
>                  return 0;
>   
> +       for (j = FS_DATA_IO; j <= FS_CP_META_IO; j++)

FS_CDATA_IO is redundant?

> +               data_written_to_storage += sbi->iostat_bytes[j];
> +       for (j = FS_DATA_IO; j <= FS_CDATA_IO; j++)

Just needs to include APP_WRITE_IO and APP_MAPPED_IO?

Thanks,

> +               data_written_by_user += sbi->iostat_bytes[j];
> +
> +       if (data_written_by_user > 0)
> +               waf = data_written_to_storage * 100 / data_written_by_user;
> +
>          seq_printf(seq, "time:          %-16llu\n", ktime_get_real_seconds());
>          seq_printf(seq, "\t\t\t%-16s %-16s %-16s\n",
>                                  "io_bytes", "count", "avg_bytes");
> @@ -81,6 +93,10 @@ int __maybe_unused iostat_info_seq_show(struct seq_file *seq, void *offset)
>          IOSTAT_INFO_SHOW("fs discard", FS_DISCARD_IO);
>          IOSTAT_INFO_SHOW("fs flush", FS_FLUSH_IO);
>   
> +       /* print waf */
> +       seq_puts(seq, "[WAF]\n");
> +       seq_printf(seq, "fs waf:                %llu.%02llu\n", waf / 100, waf % 100);
> +
>          return 0;
>   }
>   


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

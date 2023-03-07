Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B540C678D5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Mar 2023 15:17:02 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pZZ3k-0002z0-Id;
	Tue, 07 Mar 2023 15:16:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pZZ3j-0002yt-W7
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Mar 2023 15:16:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ETfr7jvsay4QGArLjeOv4Eh8UCgfVzc/cNOApzBu9sI=; b=TLRWuZ08iSIg7ExWUa3xVivM6N
 0tK4/9PGBqB4pukhO95FHZPNtM+1RDH+SHTBqszyStUGz4BdMEFm5DpZt+P8mtSApeMEBfo257v35
 7v76Jhou/WwMfYn2ylpn73HzOOymEimsZhCwGhhuPIdRAeuPu+sBKEuNOat1gOgmyx5E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ETfr7jvsay4QGArLjeOv4Eh8UCgfVzc/cNOApzBu9sI=; b=dTRoa+GCBQHisQNj8SULoQ95Q+
 YqWa+T7DUOwER1jMV2NcxNXuw15mNq1i75UpRnBhzoxKqETInuYF/xfcB1PDUdHr4uBjyltMosAvk
 y+5nGhsLLEfzPA29Dnd6cXqOem/FbUtYkR1yQd7AlzWbFENgS0TGVbuHn6bNR6+jbUOU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pZZ3i-002Ilw-Oj for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Mar 2023 15:16:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7A18161265;
 Tue,  7 Mar 2023 15:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4593C4339B;
 Tue,  7 Mar 2023 15:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1678202212;
 bh=r5UlYGnLJQR3K3EgnBj+BtpeV/TXq8sAAb2GWHNtr1s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MwQm30pP8tYFJXLYp9KJTB+wjdOpFUU8NAz9yJ2Oz4247tPiD5B2Jh1ttiI7UZozl
 UzrqeUUEPP2wmVMPAjU51BATX/Zk4/7YVWHet3j19SAgPJR38OMfwcUem1uF/W6mXN
 Z50s5CIq4+NL8xiOToWMAbluGM/DeQewr9AuQCKb160MZviZZoOETn1WOyNV3FtzeP
 Hfk5Is+qpC1qRIcpMefcx/9A5CSt//+1gPc/h/BF2hwckck5bhl0/0GFbjY9doOujl
 D+eXIq+uX59l7vmEj5iK2WqJbnLsxYggRZx9BA/i8hr7CGKit5d4itxsHfoDj6j4wz
 0OwtNp3uCG4JQ==
Message-ID: <1eafcd1d-50e9-e515-fd84-fca25139304e@kernel.org>
Date: Tue, 7 Mar 2023 23:16:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20230216140935.20447-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230216140935.20447-1-frank.li@vivo.com>
X-Headers-End: 1pZZ3i-002Ilw-Oj
Subject: Re: [f2fs-dev] [PATCH v2,
 RESEND] f2fs: export compress_percent and compress_watermark entries
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

On 2023/2/16 22:09, Yangtao Li wrote:
> This patch export below sysfs entries for better control cached
> compress page count.
> 
> /sys/fs/f2fs/<disk>/compress_watermark
> /sys/fs/f2fs/<disk>/compress_percent
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21C9C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Nov 2022 14:27:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oyDCH-0003iV-6U;
	Thu, 24 Nov 2022 14:27:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oyDCF-0003iF-Th
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Nov 2022 14:27:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2ajU8wIUL5WZrrKilrbwaXvL9AGqmcyNMj/UHdQvdhM=; b=hAOplxN4GmJ01SIdvI50AulPF8
 Sd70wlFW7WL34DyIMyJ8AdO5cybUCUcb2nfn38vH4tX2IpFFL83hZR0KtJxUdZMRnF6dYNv5Xr4HK
 80KwJjkyV/7UJ+ns05BKiLr04ZEA7oCEx6cIv6czAMoChI/Dq8bsOMUPqAUTXA/QFka8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2ajU8wIUL5WZrrKilrbwaXvL9AGqmcyNMj/UHdQvdhM=; b=ZhKJavRR1UhRr3nN5fN8amhc5F
 t5MxVNxvPCjKrv17OsYRzzCtL+c7GD7mxGKJPMRnT38wsKazGenfXSu32PMTtifJ8VcedHzOusgK2
 jgCZ8uYR6K1r22eDO6rQA3RAWPGxsZlSska28B/Lbb0r3qSiOfzdORu1SITS2/OlAXPU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oyDCF-004peO-AY for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Nov 2022 14:27:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DEFB662162;
 Thu, 24 Nov 2022 14:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39214C433B5;
 Thu, 24 Nov 2022 14:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669300037;
 bh=NwnLbZ+fYIFT1sQNHNWPNuDrG0lF0nQj3aZpm7ljHUs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MkY1vANKSNMc9/l6jC5yLRxz0sBj3WTo6WPTv9hQLEPkuKFgHuXzfeBw9W2Rx25c3
 Ye6cDWlfsj9DuKU8wlrcGXiVC4wsX904paUzDJLWUtnmvB4iWDNUa1mq6nsVybe0qB
 hndf3p6S8AaZ/18vc/8Zz+ikrQginnRiNiEr4J4ALfIzX9VypS2yK1XMIG8driR4UJ
 OgPsXlUpa1IfttFM/Abgxg9FXVzn21aDdzGmarOEjGZPVeFWAFyBgjFRue6uIL0ieu
 yXnXnV8uGTueuwcWcnLCGlItCsumIhE1aQjkM1d8L0NpCx+B+Z3S6RPhK8BI+kg/yN
 cH4eVAkwsjAag==
Message-ID: <121c8fec-6194-b9de-5019-205c448e9f62@kernel.org>
Date: Thu, 24 Nov 2022 22:27:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, Sheng Yong <shengyong@oppo.com>
References: <f508dea8-5dc3-e29e-0d8b-4d64735817ac@kernel.org>
 <20221115160155.1037163-1-shengyong@oppo.com> <Y3QaDU2n34nmPaiD@google.com>
 <Y36UqrnKcOq5dLrn@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Y36UqrnKcOq5dLrn@google.com>
X-Headers-End: 1oyDCF-004peO-AY
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: fix to enable compress for newly
 created file if extension matches
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

On 2022/11/24 5:46, Jaegeuk Kim wrote:
> If compress_extension is set, and a newly created file matches the
> extension, the file could be marked as compression file. However,
> if inline_data is also enabled, there is no chance to check its
> extension since f2fs_should_compress() always returns false.
> 
> This patch moves set_compress_inode(), which do extension check, in
> f2fs_should_compress() to check extensions before setting inline
> data flag.
> 
> Fixes: 7165841d578e ("f2fs: fix to check inline_data during compressed inode conversion")
> Signed-off-by: Sheng Yong <shengyong@oppo.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

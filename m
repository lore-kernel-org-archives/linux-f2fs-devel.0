Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26C1D0E6D1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 21 Oct 2024 09:05:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t2oLv-00025y-IG;
	Mon, 21 Oct 2024 09:05:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t2oLt-00025X-Ie
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Oct 2024 09:05:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dX/dESU/+hROXJIMlEf5RxXQvZG0RfC5zlVA8jXjeC4=; b=OS8wRe18i7J3b5i6fJYaMKqIEB
 JOizTsXNeh0QbJMZp07L+XfQPySAFnYmbuozYJmU+FjD/rFwGzlUH1acYOakSxfjb9uGRTiHdaHPD
 ZCHwfyRFvEFyGnrhSK0dG2IOlTY4Df7T+iwq/77FLM+eSiy+/lkfQeMK9TP9/oKFrD5U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dX/dESU/+hROXJIMlEf5RxXQvZG0RfC5zlVA8jXjeC4=; b=Lh/ReUSNFwkhf4kzwpSf4qpLsP
 dKJAfo3H08zMryUqNcMY5qkCCwGv3jUlycQg0XImDhr4CTUIjCPS2josmlooIKHeHJl8McvFlb2lX
 +KuO/HsiKWQsF9hA69h/o6Hw0Hc5jreVXj12BlW1j2CyCe8p8kzGXnBbXj6aiWwdd66c=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t2oLt-0003mb-N4 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Oct 2024 09:05:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C65EC5C58B6;
 Mon, 21 Oct 2024 09:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC72C4CEC3;
 Mon, 21 Oct 2024 09:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729501514;
 bh=U0XCZwW2pc6q4EXiiGWtDURI1Ew4V3wwkpW0XeXtwhw=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=O8sde/YVzg77X8UJo7Cyw/S/OhIHVCZvplX1medByQIL1VzegoPx1+f6QH/iAeGPD
 qh+thcCscxCGndlYtoViuhtEk2dzkiW8fwK7AiZwQikfF8T6eHS1j1+KTqSVSxAFPf
 HJjKP08ddFIQFG554kQOAc+jrffUHFTlRg4DhjowOqt8nmD2tg+qIjCOZjnIi3qJqP
 pPL/4ervhQWspxfDxtKgL0Qi6q4VpVdDKZ/FSC4QNBMo808v4r8t54RTOoqNMvLpM3
 Zc03a2JFW2NAKWceYvKK+vSwT2/E2pqN0IkJHwBCE2vRNq9h3NT4FJ6pCD0Lnu+i6P
 UkQZgEz0ZnPZQ==
Message-ID: <b91d43c6-8065-4b40-b622-8df1824515ea@kernel.org>
Date: Mon, 21 Oct 2024 17:05:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <yangyongpeng1@oppo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20241021044801.1358850-1-yangyongpeng1@oppo.com>
Content-Language: en-US
In-Reply-To: <20241021044801.1358850-1-yangyongpeng1@oppo.com>
X-Headers-End: 1t2oLt-0003mb-N4
Subject: Re: [f2fs-dev] [PATCH] f2fs: check curseg->inited before
 write_sum_page in change_curseg
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/10/21 12:48, Yongpeng Yang wrote:
> In the __f2fs_init_atgc_curseg->get_atssr_segment calling,
> curseg->segno is NULL_SEGNO, indicating that there is no summary
> block that needs to be written.
> 

Fixes: 093749e296e2 ("f2fs: support age threshold based garbage collection")

> Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454A8C982D0
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SlR8d3QyXjgiZM5hYjY6PZwFyqlASKPI8S/BlMgrecM=; b=YnYcZKKcD3px6aBkeNOx+99Ll2
	Pr7yM7HwZ4dQrgQ+b//tuESGPHI1sr7yyKv2Oaoi621QiPOIRSWvljjTQKs8bsL9oBbQv1J2i74eK
	oJ1Td4cMzi5QS2SoujY5aTRPsSqVDH20lWqy5GOUiexyi8k76nPY+S2kuUBJkMSgpQlM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x77Xh-0007kd-NL;
	Thu, 17 Sep 2026 08:32:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x77Xg-0007kX-Lk
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 08:32:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=05pJoln1a10A1DllC3Ah/Keu8JtQ4zxJ0Ujs73gNB+Q=; b=M1UIO3BbwXSZNfQuk7h8K0vafO
 gESSb5RYA8oQGzIFb7sye4sF0EX736FkADsQC/nzRJyLMcuJm9wd1dhSZDSzoSG/D3KnyRErlsI1T
 6hsPfI/iVw53TqNxbmi7zsrUcfANB7OgdvwhxGjXjlJgUq04qcVVelbak6aYijlE4fI0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=05pJoln1a10A1DllC3Ah/Keu8JtQ4zxJ0Ujs73gNB+Q=; b=ES03opKyQynK/4AWKL9KJD9X1n
 BUyCG0tzgPPDhvdkw0NwpIVsaRDtobgrYt/bF/Qh2zNcalXmdeaGIa/M7c47wv7sRYOJ+FdvFn07o
 eZUyQKu+pZQCJQB3tPJEN424gEKGSd3eLofN/H1omOj+RLyaW3Hntn24PPy4D3Xr6qzY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x77Xf-0006uE-Ab for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 08:32:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EE98F403DF;
 Thu, 17 Sep 2026 08:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EB41F00893;
 Thu, 17 Sep 2026 08:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789633941;
 bh=05pJoln1a10A1DllC3Ah/Keu8JtQ4zxJ0Ujs73gNB+Q=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=J+qT4kPcBENvVcB2efTiKikJh+McCp2rQZ0mT7G0jw5WqbN+k2QS+sy9q9m0EJAnL
 7/UAxqX0CJO/4jZFhayHWAMLv+buTqDztCazoftPbVg0+EhLXHMYe9Oel4d7ohPHT2
 LkzzNsY8DyoHBkoxfSlUFMOObomLHlbhpNykwJ82Jf2mr6lWWrQyjBDzZ+X39J0ExM
 VwlzJFjSYz6RTzUR5R4VZFK2f5lcXXUC37WHk04yX4Np6s7DX0J2PW8/ySoUiclgAW
 X1uLaq9SjVr/wOaT7vqe5zjoCwG6n6LZtRWql4zZZMw6ilHPdsbCBwfG0XkZxfh9Ov
 tXtGCQ6ajSrMQ==
Message-ID: <d189820a-151e-454c-a04a-e9d3217c13d5@kernel.org>
Date: Thu, 17 Sep 2026 16:32:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260915041909.2903887-1-zhaonanzhe@xiaomi.com>
 <20260915041909.2903887-11-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260915041909.2903887-11-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x77Xf-0006uE-Ab
Subject: Re: [f2fs-dev] [PATCH v2 10/14] f2fs: handle partial truncate of
 large folio dirty subpages
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/15/26 12:19, Nanzhe Zhao wrote:
> @@ -3545,6 +3573,14 @@ static int f2fs_write_single_data_folio(struct folio *folio, int *submitted,
>  
>  		fio.old_blkaddr = dn.data_blkaddr;
>  
> +		/* This page is already truncated */
> +		if (fio.old_blkaddr == NULL_ADDR) {
> +			ffs_clear_subrange_uptodate(folio,
> +					i << PAGE_SHIFT, PAGE_SIZE);

(unsigned long long)i << PAGE_SHIFT

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

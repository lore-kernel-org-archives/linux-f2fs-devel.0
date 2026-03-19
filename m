Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32ED9108E1E7
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Mar 2026 10:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c9MQ31++ukN4G4mnF/pxFKIseqAuaVmCsaQLrpoVIO4=; b=ms4UjwgGXk07aHOTzULH+87x13
	cvikV+lUIPz2OhZDuidjakfqmjkdsUFfYQR0H0ygv9wZCIo62wagIxgqr9CQanlHpseioekJc0J8D
	whUnE57c4SEiyFjKJqLVnLDCAeIQMSfD/pf52lJFVYWBngTm35ahdKf5+hbkiz3TnioY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w3B5j-0008Ke-1I;
	Thu, 19 Mar 2026 10:59:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1w3B5h-0008KQ-1U
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Mar 2026 10:59:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iQzFoIN5/ihpAn3ItUQUSnV34aqs4hZHalQFtUYVLQo=; b=ZxAOKih7Ex5TH8yjFFLwzPLn8+
 NB5BJnViwIC+CQTQuAXX4j5HPw3JigMXk2wFOa7RTvRW685m7DBq8vlyt+PPuqW8JDuOOXA5QdjOA
 WXW8fuC99C+omoRKl0X7/gBwX5bPo6XACdbzmsSGAui5QofvmTnQK+t6k/DLcpZr78BM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iQzFoIN5/ihpAn3ItUQUSnV34aqs4hZHalQFtUYVLQo=; b=l5S9aDLcLsMdx4UyqNm3RP1CQY
 SxDX/bx1UWxezMz8H8vxKKqkr/YWdZNNmQNXUdmMwZ7hudTl29MJSXtjDyWVCyu3pAWu8o952SthD
 usZaN1QXfoSYD/qjylCxCNBhxlMhXy44pAa/iv3yelgnLlUwuvIdELbSllaeSoqVoV0Y=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w3B5g-000876-EF for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Mar 2026 10:59:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A64E406A9;
 Thu, 19 Mar 2026 10:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7826C2BC87;
 Thu, 19 Mar 2026 10:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773917935;
 bh=fm3PbN9ipeS2MQ1n3HR9Kf9uKUGrEzxfmWJH7i0clWY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=qv/m8igDt1G9zuB0b2edpafKuWKXu/xnnP0f2hsH0mXT8s7JDmP7/Xd1kuPeruv9W
 uCZSd4n2eAxvQdCdpMe/UkAv+BVVIwS85PLh6FVK6Mj7LaVUH0AvPcild3wqfco3dm
 RcJ8pjBxCEauG9wUgCS4QFBskhHvSIMNLtz95g4GoR3uGs2pkfU4xHMOIVOt9xV6d7
 4Opgny4jPPQoUEC0JhKxsz0+WZLIAAmL5UryrujY6xtDxQIOWHJPMxJNMhNYOe6X/X
 Kxrdr4Ix5j/r8s89jPSQSAYlCrJ92hkQeja4det7KNuzuU9GDoe7XnBzVAnWc29M4x
 hOr6oSMCrESjg==
Message-ID: <afa33531-7d66-4c8d-af62-cb48d3b6ddd0@kernel.org>
Date: Thu, 19 Mar 2026 18:58:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <monty_pavel@sina.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260318084534.373516-2-monty_pavel@sina.com>
Content-Language: en-US
In-Reply-To: <20260318084534.373516-2-monty_pavel@sina.com>
X-Headers-End: 1w3B5g-000876-EF
Subject: Re: [f2fs-dev] [PATCH v5 1/4] f2fs: refactor f2fs_move_node_folio
 function
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026/3/18 16:45, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> This patch refactor the f2fs_move_node_folio() function. No logical
> changes.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

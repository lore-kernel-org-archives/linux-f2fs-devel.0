Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1F9EB363E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Mar 2026 07:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZKn92CgDaA25sqcUvWgErKR8QX+DSznYHk78y40wbEU=; b=HfihuFAwz9IUNJQH5ZpKyaQ7G6
	5a+n02jgPIuYMKIT6bbbGzPn4/HDzUYnMxdrbmF+GvtJMUvurow8fsHEq6pEy4VF7kvNqMFTfYloh
	g++wk5mqeaZgywIUJNMqcegnE8r1t4N1iK5Bni4r5XyaCo7S5tmUDnXerCiFwhpj8csQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vxh6w-0006cc-SV;
	Wed, 04 Mar 2026 07:57:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1vxh6s-0006cS-QM
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Mar 2026 07:57:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hHD2UVfjaGHCqnydyhA74QMDpDGAsQPucVsuqDCzbvI=; b=OHvs6rHN40nwc4u/JZMnfUdhyh
 sMJedpg6rqWj2HG54rNXs/5bwOPaf3Q7oFJiVf8ryEV1txaI0MgYcScAgQ3+TobmZu65gQ09VgPoG
 gl9cN6EmiLDWAvKMNvri8izt6OORT9lZsPTNcdTA32XUiI+yLN3L6HalB6c3KMXRrnHM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hHD2UVfjaGHCqnydyhA74QMDpDGAsQPucVsuqDCzbvI=; b=hkocn8mpLhZKAX+Lxfjq6SeR9d
 M1Ax78lK+Yb2NvWMO3AGnnF01keI3QAxKlke5pTso5S17ce/wxI8xUmhbOGojWEAhpSopq2AH1nGF
 EWgbeBe6djKtHd8KZ4eJLaZkSU9x8R52I4pcmqWir7XjmxsyFN0weG9uZefExfCwljqk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vxh6s-00005s-E4 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Mar 2026 07:57:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CB2EC6111A;
 Wed,  4 Mar 2026 07:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41623C19423;
 Wed,  4 Mar 2026 07:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772611043;
 bh=q4Inc8XTGjDXqmhz7BLshztFYQ91wTXvlqfWo0I6b2U=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=mdR1ehHHlopNhIKecKFhQBMeyLI/23ShGRWScQ8n5tlTHJ5rT90aQJBlq/e2jq3Q/
 WwZmINS78nLY3DNoX5ZjHswa0pIlofxR6vbojizYcH8r4LudZF0YNIpDeJUQY1K/O1
 i4I1Jm34VZyyKqqdj81GJPtpwpwJ6DeBnSsQwMscwOsEr+ZGrC0me09rYerm0bsT5c
 OL1ochH1vANodQk5+m1KFD2dbUGVYSY9eBMiewm199bHvHGWhZCIS1xGcn5x+R1lez
 1fKnFNJdcMXWFiYsuuTPn+o4fy7xF8jSxprNotofHN1QuXHZ6ZgVvGGWQnefQzOC9X
 W3ILOn9mq8aJw==
Message-ID: <d83df928-8ef7-4dc3-aedb-f4e47f92c3f8@kernel.org>
Date: Wed, 4 Mar 2026 15:57:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: liujinbao1 <jinbaoliu365@gmail.com>, jaegeuk@kernel.org
References: <20260213122630.287516-1-jinbaoliu365@gmail.com>
Content-Language: en-US
In-Reply-To: <20260213122630.287516-1-jinbaoliu365@gmail.com>
X-Headers-End: 1vxh6s-00005s-E4
Subject: Re: [f2fs-dev] [PATCH v2] f2fs:Fix incomplete search range in
 f2fs_get_victim when f2fs_need_rand_seg is enabled
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
Cc: liujinbao1 <liujinbao1@xiaomi.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026/2/13 20:26, liujinbao1 wrote:
> From: liujinbao1 <liujinbao1@xiaomi.com>
> 
> During the f2fs_get_victim process, when the f2fs_need_rand_seg is enabled in select_policy,
> p->offset is a random value, and the search range is from p->offset to MAIN_SECS.
> When segno >= last_segment, the loop breaks and exits directly without searching
> the range from 0 to p->offset.This results in an incomplete search when the random
> offset is not zero.
> 
> Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

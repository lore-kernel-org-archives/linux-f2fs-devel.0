Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8784C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 May 2022 01:59:47 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ntgJN-000512-OM; Wed, 25 May 2022 01:59:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1ntgJN-00050w-Dx
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 May 2022 01:59:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c57Kiev2wTq8aQ3/LxLggFAD1JeUSrf7KyE4Azf38c0=; b=Z2yK9XQz+Jx0Tv6Ov/YJ3jstxf
 OH9lgtXSJmmGlqam7jCXoeO0lQg00/6iZjrNI3k/OGoLcfHIK2AD5ujrbuFiCKhYZFZQ7y/mi+33o
 f/kSPHI00I2id1F/kJaVbbAcsv634r6zpDFvVumcJj4DTctefBi9Xw012NLGKLYSOH6E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=c57Kiev2wTq8aQ3/LxLggFAD1JeUSrf7KyE4Azf38c0=; b=GJUF0mv4qreY2wEiGEvWNvK23e
 eg5Gc9vL3EFJNV4zKYWTlM2UFCtvtJBnWlwsi03nxzJSd21tmZOSzlxDrz+ZGGAYngkFvoxRHmMdX
 VQSKSvbzg2UvsYldIjAnPuvVrPcin+pF8Uc8WiRs0mWosoRohKracx4y43l3ThybT9pE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1ntgJN-007b3I-5z
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 May 2022 01:59:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CDB18614F1;
 Wed, 25 May 2022 01:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B2FC34100;
 Wed, 25 May 2022 01:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653443979;
 bh=XjmXm7nrnLES/MEJ9AdsYRA3wQbvOl6+CmiwIjSNZHk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VnvMC35gUOYsOp5u5wfRFSI+qmAczcnTF0zCByyJZhoBE4T3ZI46nIq9ZugWBkyV8
 U1kXZjhohgMGPd0Bf0Vv+1c/qI8xjcx+xjNKP2330rr6QD48ihCTIlu8EiGr0U/Gwh
 atOvkTWNxuzIQ3UHU2JSJTcLN7w772EMX678Z+Z60xvTb1f9JXw4TlIH1Xnbm/Yi5K
 hubre4f3Ud56IgPT6hHDWjh9WkAz6HpdNsyzC7K4EcABJGpXjGaPAf+1BsqbcrdGRa
 Uo+FpGV3e6FITr6g5enOM4riDGoudENe2/7wVGFIniLvxL/JnbOCwFBwC4uNsAkR3e
 DDttGd/S9sxMw==
Message-ID: <699928df-b43a-aa9f-c0b2-48308dfc5d02@kernel.org>
Date: Wed, 25 May 2022 09:59:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To: Sungjong Seo <sj1557.seo@samsung.com>, jaegeuk@kernel.org
References: <CGME20220524022214epcas1p28d7b7de846e44cedf825eb4f5973932d@epcas1p2.samsung.com>
 <20220524012911.725783-1-sj1557.seo@samsung.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220524012911.725783-1-sj1557.seo@samsung.com>
X-Headers-End: 1ntgJN-007b3I-5z
Subject: Re: [f2fs-dev] [PATCH] f2fs: allow compression for mmap files in
 compress_mode=user
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
Cc: daehojeong@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/5/24 9:29, Sungjong Seo wrote:
> Since commit e3c548323d32 ("f2fs: let's allow compression for mmap files"),
> it has been allowed to compress mmap files. However, in compress_mode=user,
> it is not allowed yet. To keep the same concept in both compress_modes,
> f2fs_ioc_(de)compress_file() should also allow it.
> 
> Let's remove checking mmap files in f2fs_ioc_(de)compress_file() so that
> the compression for mmap files is also allowed in compress_mode=user.
> 
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

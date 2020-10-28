Return-Path: <SRS0=q8MD=ED=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4B1C4363A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Oct 2020 06:47:50 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 018882080D;
	Wed, 28 Oct 2020 06:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="f3i/ie65";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="jVTrWLB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018882080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kXfFN-000242-DH; Wed, 28 Oct 2020 06:47:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1kXfFK-00023u-SE
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Oct 2020 06:47:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5N3Lh689PDnZjr5Pz7nETxKQKL/w6uzAoNZqw5LjjpI=; b=f3i/ie65VyZMK55BRt1Ut/1Urp
 Y6jzpn2cu9tNZ6wn1IEmSdHCaEVypOfsp1GyxlrnFXU7AAa0VQpaYlAVCRVB8HoWl52961GbaQlgz
 f3gOEG1q0G8fk2gpZ5uQtPI/Owb/KCUttd4yayyi/aOQwtl+s7M/XFE6w5952SA8R/mk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5N3Lh689PDnZjr5Pz7nETxKQKL/w6uzAoNZqw5LjjpI=; b=jVTrWLB9kVRO7azQQ19ue3TSPy
 779+Fr04eYEp3pMKiv3ZYqhJeOqQWeWOH4YG2RZZSN8EO4TfvH67GSRsjqBthUUJcEPJmy8Lqf8L4
 28SsSMPmd0eDDXFKCY3hS5F7Cnp0UFQALHYTf9CT3YvnsUaSjqtx2CTVmH89ofQbG6Fc=;
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kXfF9-009jzt-Va
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Oct 2020 06:47:46 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CLfJg2fC6zLmcP;
 Wed, 28 Oct 2020 14:47:31 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 28 Oct
 2020 14:47:25 +0800
To: Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20201026192214.4156137-1-jaegeuk@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <a785249c-22a4-7de7-d829-ff83fb0c3971@huawei.com>
Date: Wed, 28 Oct 2020 14:47:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201026192214.4156137-1-jaegeuk@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
X-Headers-End: 1kXfF9-009jzt-Va
Subject: Re: [f2fs-dev] [PATCH] f2fs: call f2fs_get_meta_page_retry for nat
 page
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

On 2020/10/27 3:22, Jaegeuk Kim wrote:
> When running fault injection test, if we don't stop checkpoint, some stale
> NAT entries were flushed which breaks consistency.
> 
> Fixes: 86f33603f8c5 ("f2fs: handle errors of f2fs_get_meta_page_nofail")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

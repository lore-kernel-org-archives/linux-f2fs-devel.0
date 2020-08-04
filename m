Return-Path: <SRS0=w2wC=BO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF06DC433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2020 00:57:22 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC525206DA
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2020 00:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="QY5icZQI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="fWCRftUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC525206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1k2lGb-0005zO-6V; Tue, 04 Aug 2020 00:57:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1k2lGZ-0005zG-Ke
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Aug 2020 00:57:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n4zejEUXrEkBoI8FqV0oFwpgV2rE+o1FnFdE9HswZZc=; b=QY5icZQIOy93aqKldGuDclM3Zz
 uSj8hMGUoSytQVobYKDRP9JVBqbsHaPEmtbkHkPr3BONDrTQczeDvpXmrNV9xcE6gdaV6l0fMOjwT
 +5bHqXEj3GLqG+BRANIX+90akZXW2BrIzzkBq11FKo2CYEwn4V0Ti21XVD7T5oZcRe+0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=n4zejEUXrEkBoI8FqV0oFwpgV2rE+o1FnFdE9HswZZc=; b=fWCRftUhtSHxzKMzvv1YXcmzSI
 eiamNf0DJqwVmxvlxnoSwIJiczDRqK0G6VZcQirpoMYlcnPB3tjikt2a6TArCuYyth858o1gLXz73
 Cp1KBGQFy8qWtm/tYxauBctXUZUN0gGSKBEUqqOUcqBpMrSWyheEPeiduo+DvVfvqGBQ=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1k2lGY-00BBlc-9U
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Aug 2020 00:57:19 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 73459B9F4BC73A91C11D;
 Tue,  4 Aug 2020 08:57:04 +0800 (CST)
Received: from [10.164.122.247] (10.164.122.247) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 4 Aug 2020
 08:56:56 +0800
To: Yufen Yu <yuyufen@huawei.com>, <jaegeuk@kernel.org>, <chao@kernel.org>
References: <20200731061813.3791834-1-yuyufen@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <3070f5af-1899-fc31-e2ba-9f333ce73a2b@huawei.com>
Date: Tue, 4 Aug 2020 08:56:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200731061813.3791834-1-yuyufen@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.164.122.247]
X-CFilter-Loop: Reflected
X-Headers-End: 1k2lGY-00BBlc-9U
Subject: Re: [f2fs-dev] [PATCH] f2fs: replace test_and_set/clear_bit() with
 set/clear_bit()
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/7/31 14:18, Yufen Yu wrote:
> Since set/clear_inode_flag() don't need to return value to show
> if flag is set, we can just call set/clear_bit() here.
> 
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <SRS0=CSNb=KG=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C308C433ED
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 May 2021 03:18:30 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1B961469;
	Tue, 11 May 2021 03:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1B961469
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lgIuh-0004nv-Q0; Tue, 11 May 2021 03:18:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1lgIug-0004nn-Ev
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 11 May 2021 03:18:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k4K15d15QIeoAGQhM1+buAEy8fVKmeqxfmBmNuFn3uI=; b=X3lz9V36XYTqjbUMHJnO+lE7Li
 z9yVW1IT6n88bSZxS/JaJJS4peMij/iR+3+/a6d5bVC7Tw0rwKXiJZcFjtwn/G5gVXrMhvxKF6ZR3
 zeSs5XgbQY4BvToiefglgKJKjG6v0rrisoXyftxHcU2t2b+bMNV/8JU6qlIPEPVBJiao=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=k4K15d15QIeoAGQhM1+buAEy8fVKmeqxfmBmNuFn3uI=; b=QEmSXI1N7xF7KeFHAa/Zd7B0Wp
 qa3h06CCwweDnilSZ11bhhK9quus8CVZ0vfyNHpWF51GCl2llSUsZ3PK8ssaA293jNJ7i1qfr9UnM
 YAP7MUd4Qi6xJAc24umrBmlcaIuC8TYAo2W4uDRiHG9XxfYe2HH08aelnn/VlURHoaig=;
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lgIuY-0006v7-J4
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 11 May 2021 03:18:27 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FfNN02q3Fz1BLB4;
 Tue, 11 May 2021 11:15:28 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 11 May
 2021 11:18:05 +0800
To: Seung-Woo Kim <sw0312.kim@samsung.com>, <jaegeuk@kernel.org>,
 <linux-f2fs-devel@lists.sourceforge.net>
References: <CGME20210510085419epcas1p1e16c3966fc1b7b9f28a797eaa588f3ba@epcas1p1.samsung.com>
 <20210510085726.12663-1-sw0312.kim@samsung.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <9d2ea472-59c8-2a83-a7be-620635d00c4e@huawei.com>
Date: Tue, 11 May 2021 11:18:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210510085726.12663-1-sw0312.kim@samsung.com>
Content-Language: en-US
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
X-Headers-End: 1lgIuY-0006v7-J4
Subject: Re: [f2fs-dev] [PATCH 1/2] fsck.f2fs: fix memory leak caused by
 fsck_chk_orphan_node()
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
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/5/10 16:57, Seung-Woo Kim wrote:
> With invalid node info from fsck_chk_orphan_node(), orphan_blk
> and new_blk are not freed. Fix memory leak in the path.
> 
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

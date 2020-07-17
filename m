Return-Path: <SRS0=CtUu=A4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3618C433E5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Jul 2020 07:37:19 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0EBC2071A;
	Fri, 17 Jul 2020 07:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="B/YEMCud";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ERGDUVqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EBC2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jwKvn-0000t2-6e; Fri, 17 Jul 2020 07:37:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jwKvl-0000su-3j
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jul 2020 07:37:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vBLr7V6KNlt0JF0EVD+QWJABeRUYHtr9XgBveqkDIzk=; b=B/YEMCud0f2e9S5GUwMyadSQmw
 alWJpGAxDgLftTHKSDHlfom9hcVUZhL1N1StWLr+pkYxmI71xA8kT5P7qM8Y0bGcKGIVZSoY5ilfW
 2RowwvN3m8GeHQpL87LaDHmZ5aDrpHkPhJHXz0HnLLjYLxhHaB0psg3MwqbhZ881z3KU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vBLr7V6KNlt0JF0EVD+QWJABeRUYHtr9XgBveqkDIzk=; b=ERGDUVqBOkhh5ZthGvgX24+nvl
 Wf1rn1UQsPSBBWV/bjZGh+osJNGVjFFx+I2j81Z8t/c80YfOoaWpruREUlfMACkX3DcPksF5XiGTJ
 m2klhs+WcSguFYbGJl8VDpPNVrqhuEwWu8in77zctKhzSkTfX4g2qlvYx2Jop1jTKa58=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jwKvj-0074ZT-5r
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jul 2020 07:37:17 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 417AAD16100E7E4D07E4;
 Fri, 17 Jul 2020 15:37:05 +0800 (CST)
Received: from [10.164.122.247] (10.164.122.247) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 17 Jul
 2020 15:37:00 +0800
To: Aravind Ramesh <aravind.ramesh@wdc.com>, <jaegeuk@kernel.org>,
 <linux-f2fs-devel@lists.sourceforge.net>
References: <20200702155427.13372-1-aravind.ramesh@wdc.com>
 <20200702155427.13372-3-aravind.ramesh@wdc.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <5bae3194-9818-8013-9dcd-a95c1497e054@huawei.com>
Date: Fri, 17 Jul 2020 15:37:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200702155427.13372-3-aravind.ramesh@wdc.com>
Content-Language: en-US
X-Originating-IP: [10.164.122.247]
X-CFilter-Loop: Reflected
X-Headers-End: 1jwKvj-0074ZT-5r
Subject: Re: [f2fs-dev] [PATCH 2/2] fsck.f2fs: validate free seg count on
 zns device
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
Cc: matias.bjorling@wdc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/7/2 23:54, Aravind Ramesh wrote:
> NVMe Zoned Namespace devices can have zone-capacity less than zone-size.
> Zone-capacity indicates the number of usable blocks in a zone, if
> zone-capacity is less than zone-size, then the segments which start
> at/after zone-capacity are considered unusable. Only those segments
> which start before the zone-capacity are considered as usable and added
> to the free_segment_count and free_segment_bitmap of the kernel.
> 
> Allow fsck to find the free_segment_count based on the zone-capacity and
> compare with checkpoint values.
> 
> Signed-off-by: Aravind Ramesh <aravind.ramesh@wdc.com>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

It's better to merge these two related patch into one, otherwise, it
looks good to me.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

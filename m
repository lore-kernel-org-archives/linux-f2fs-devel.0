Return-Path: <SRS0=FIoQ=Z7=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DA3C04E30
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  9 Dec 2019 10:50:56 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E8420866;
	Mon,  9 Dec 2019 10:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="cxX1DrLv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="UY6k6KnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E8420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ieGcw-0001rB-Rs; Mon, 09 Dec 2019 10:50:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1ieGcv-0001r0-Hq
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Dec 2019 10:50:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gEovtcZ54cpYWWliTBzcUB+UCGayOpnOEBZofkmdM/A=; b=cxX1DrLvdaMUnsLljZIgcUZAWK
 lvrMXx7xjlhYWPEOqWqRvwK8W7cGob8SBgyd1pZ6DWUgUlXE1xztBYrx8GAV5XSgZ/5tR7UULqPp5
 L+nZ99gHbeogl413DcMXeEU8DPYtDfgzYbowb8YkoxSH9ggn4aOxDqPN1NFmhVbICp74=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gEovtcZ54cpYWWliTBzcUB+UCGayOpnOEBZofkmdM/A=; b=UY6k6KnOH2w+RP2e66Tbalzpf9
 1uyrR/M6iD4H7jix+iE30Lr9xry7+W111hM9ojso7aQ8gy3O6BbWQnN7+8jzB0P+oTKnZbIqRhukI
 nbaH1qblrtJ1P4qITdrSvNr3kOPKdUzkgdjperiIadkfi4F2Y1beV8I1SUKGFlVUcmCU=;
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1ieGcu-00FEss-9B
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 09 Dec 2019 10:50:53 +0000
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 3C415C1C1D49FE4D09A0;
 Mon,  9 Dec 2019 18:50:45 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 9 Dec 2019
 18:50:42 +0800
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Jaegeuk Kim
 <jaegeuk@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
References: <20191209104445.216327-1-shinichiro.kawasaki@wdc.com>
 <20191209104445.216327-3-shinichiro.kawasaki@wdc.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <1f4e3ac6-ab22-ddbe-c811-61145c33b0ee@huawei.com>
Date: Mon, 9 Dec 2019 18:50:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191209104445.216327-3-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1ieGcu-00FEss-9B
Subject: Re: [f2fs-dev] [PATCH v5 2/2] f2fs: Check write pointer consistency
 of non-open zones
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
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2019/12/9 18:44, Shin'ichiro Kawasaki wrote:
> To catch f2fs bugs in write pointer handling code for zoned block
> devices, check write pointers of non-open zones that current segments do
> not point to. Do this check at mount time, after the fsync data recovery
> and current segments' write pointer consistency fix. Or when fsync data
> recovery is disabled by mount option, do the check when there is no fsync
> data.
> 
> Check two items comparing write pointers with valid block maps in SIT.
> The first item is check for zones with no valid blocks. When there is no
> valid blocks in a zone, the write pointer should be at the start of the
> zone. If not, next write operation to the zone will cause unaligned write
> error. If write pointer is not at the zone start, reset the write pointer
> to place at the zone start.
> 
> The second item is check between the write pointer position and the last
> valid block in the zone. It is unexpected that the last valid block
> position is beyond the write pointer. In such a case, report as a bug.
> Fix is not required for such zone, because the zone is not selected for
> next write operation until the zone get discarded.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

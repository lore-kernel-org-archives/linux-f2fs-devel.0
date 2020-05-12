Return-Path: <SRS0=rqbO=62=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CC4C47255
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2020 01:50:52 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E1FE20722
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2020 01:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="KkAmUhxa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="QFilJR+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1FE20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jYK4K-0007OA-3M; Tue, 12 May 2020 01:50:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jYK4J-0007Ny-2J
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 May 2020 01:50:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A0AGnmd8N8aXntr/n2A/KX144ePXL8fSD1lwUxrgle4=; b=KkAmUhxaPa7qHzeyh4EknRNoxj
 i6Act9fk0UWpCOUBaHoIcPZJLSvBt+DdiMUD+51q1oKR2nMBTspc56hxFiLZJ1nPNWjrKz0uGWJ4N
 QAUC8jgluHGOhCDTQ3jDMvGWQtdhlBTn6Cw4QHg/oM5KFRIYFC3gbNDr1Qe4Rz66Zp6M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=A0AGnmd8N8aXntr/n2A/KX144ePXL8fSD1lwUxrgle4=; b=QFilJR+tfYHDi+tEsmmk8Fo8at
 1Waegqq/DDeICXgX6cDeYtbwsAZBqK9/9ehDRDN/RzxSMfIBlv1zIWcQ4kVJyysfHLnDUYSamUxGr
 y9duN1Auj/ga4nK/D+o7byoZqJtOu/eWCyQhbbVkOHpXAwu5e6eqXoT1RKbuLSSxtGJ0=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jYK4G-005KG0-Uw
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 May 2020 01:50:51 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id C2BACC829ABFA8EDCF1B;
 Tue, 12 May 2020 09:50:32 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 12 May
 2020 09:50:29 +0800
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
 <linux-kernel@vger.kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
References: <158917771894.228779.2521743301299120701.stgit@buzz>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <6818c82e-4df6-1dfb-90ef-61dc151e3061@huawei.com>
Date: Tue, 12 May 2020 09:50:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <158917771894.228779.2521743301299120701.stgit@buzz>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jYK4G-005KG0-Uw
Subject: Re: [f2fs-dev] [PATCH] f2fs: report delalloc reserve as non-free in
 statfs for project quota
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/5/11 14:15, Konstantin Khlebnikov wrote:
> This reserved space isn't committed yet but cannot be used for
> allocations. For userspace it has no difference from used space.
> 
> See the same fix in ext4 commit f06925c73942 ("ext4: report delalloc
> reserve as non-free in statfs for project quota").
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Fixes: ddc34e328d06 ("f2fs: introduce f2fs_statfs_project")

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

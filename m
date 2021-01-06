Return-Path: <SRS0=Njst=GJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43B8C433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  6 Jan 2021 01:03:31 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 359B2221E2;
	Wed,  6 Jan 2021 01:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359B2221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kwxEY-0001pB-4f; Wed, 06 Jan 2021 01:03:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1kwxEW-0001p3-9I
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Jan 2021 01:03:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Xw9rKABBLhxipqqh0s5RPLCgWGX6LtUAOv4zKgAriNo=; b=ZDzQUDZ1JMlJICvsyuQc+Oh+97
 4aObwJSics7qxjs0fnOHF/TyXoBDEskqCiPgweX5lSJHvwd51EYJ5L0sVLTy+jOzDPotjZAruKssr
 YSalg2xjskH6AZ8RTtJO+qopA3IfAfuZq7W3DJlX4OIo+CHA6DAgf3niv+r5AFqFMiWs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Xw9rKABBLhxipqqh0s5RPLCgWGX6LtUAOv4zKgAriNo=; b=Osu6LWrYCBcamFm/10wIF+Hz9u
 eKCtvx9dnlMmvSeUwR2zjAYoP+dufXWzEOEQOPMBDXbAMMUpqxugZ+2kJY6duwUN2o7GyKNHQHjnO
 TpX+QohLtWyuR8Wwu8eOah08a//tTO9a1H1s33U0ufjmVUCFOb3eNwWyjQDlqnlg5e7Q=;
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kwxEP-000wlc-4k
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Jan 2021 01:03:28 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D9WKh0WRbzMFxr;
 Wed,  6 Jan 2021 09:02:00 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 6 Jan 2021
 09:03:08 +0800
To: Daeho Jeong <daehojeong@google.com>
References: <20210105041630.1393157-1-daeho43@gmail.com>
 <dba4be04-70dd-d48b-391c-1f2355591097@web.de>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <6c8e6561-8a5d-010f-3d7c-8c051b4027e6@huawei.com>
Date: Wed, 6 Jan 2021 09:03:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <dba4be04-70dd-d48b-391c-1f2355591097@web.de>
Content-Language: en-US
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
X-Headers-End: 1kwxEP-000wlc-4k
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix null page reference in
 redirty_blocks
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Markus Elfring <Markus.Elfring@web.de>,
 Colin Ian King <colin.king@canonical.com>, kernel-team@android.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Daeho,

FYI

https://www.spinics.net/lists/kernel/msg3595944.html

On 2021/1/5 20:04, Markus Elfring wrote:
>> Fixed null page reference when find_lock_page() fails in
>> redirty_blocks().
> 
> I suggest to choose an other imperative wording for this change description.
> 
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=36bbbd0e234d817938bdc52121a0f5473b3e58f5#n89
> 
> 
>> v2: changed error value and break the loop when error occurs
> 
> I propose to use a return statement instead of a break in the second if branch
> for this function implementation.
> 
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=36bbbd0e234d817938bdc52121a0f5473b3e58f5#n481
> 
> Regards,
> Markus
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

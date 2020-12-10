Return-Path: <SRS0=2O7d=FO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF409C4361B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Dec 2020 02:00:44 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 539C123BC7
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Dec 2020 02:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 539C123BC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1knBG7-000429-4w; Thu, 10 Dec 2020 02:00:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <anant.thazhemadam@gmail.com>) id 1knBG5-00041y-QG
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Dec 2020 02:00:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BVUMPlyBbapoY52I2KiTwKYlEKRNfNyqjjB2UXokEPU=; b=ao4J3OUlctpO9PYrmhSJxq6xXL
 zyGFGdlgi6RAQHoDQrtNsB3WQbRb/Jhw5Sfc0fSAmIlRh5drSIenSTetC5OHlfj58n8RqYeNDj1aQ
 FMKfkMzhHU5bQOSd/p+ykjYBrRiWFmGjRCqmbvU0ejtA0ZF6i4iH9YqLIh9Xm/PEonpM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BVUMPlyBbapoY52I2KiTwKYlEKRNfNyqjjB2UXokEPU=; b=aiaeOwLg1adMfEu4MyG+/A9BQ6
 lf8smkisDASPWhBgSu4sJfgYpb9LzSd6MODg9khNvxVGNOzaxPqk5EFNTyDROLo3zW6+LHiTB/6H4
 Sfd7mtZQ8ia/Jp7FdoPiaXEVW0sk/k8oj0baf2kHUMAAMRoyNd2XUkL8VsqfA6IGu3ys=;
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1knBG2-005oNq-OH
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 10 Dec 2020 02:00:41 +0000
Received: by mail-pg1-f194.google.com with SMTP id f17so2720558pge.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 09 Dec 2020 18:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=BVUMPlyBbapoY52I2KiTwKYlEKRNfNyqjjB2UXokEPU=;
 b=XT693OhxvozLtzPsM5QT2Weqy+FZ+Lz6BnDhalNPc+Gmfaa+wSQ3kj8dHT7ppw85Gn
 XXtWwoUHHsRcVTudcoFuNFFiHc493RiA8wLq7rBEugEQniVbRlaJ3GEliOUBDmoM+R2w
 2WHYhpVpM4sguooKe8PUqDcHYuJ4ez4E32bBhMsW5i6I2PTJ6R8xBZKODCk9YzknE4mD
 ydEKYdpdEG6+w9Ndy2IyUqy4K0ASyCkpmzvl4AfyncOWeQmaTRERukQB/D/m/ztHqM4/
 EPHcQ2dayRFGY5iFqxzVhR52wENrwBX9FYp5mIA9HsZ4ss+ZhsZqLvZX7AVLe6oklqZ0
 bVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=BVUMPlyBbapoY52I2KiTwKYlEKRNfNyqjjB2UXokEPU=;
 b=a3yxCcBVEogEC4DI6ZE5+puWeR+StVIOtyefj4K8ApTRFczOIu12a+Wdikc6wanNMk
 kD0hT0BopGlGhDsbZ+bEEQWlMXebKLDwODQUd5zwlvRYKn+bC0K7lPNMlUau2cLOh4Pp
 p+Cw1o9bNmjweYKfG1VkQQ8Hp+AUsdOggXDv3WvTuxwnuVS47tFZYSvhxmwcW+prNCBJ
 P1CnP9S86nDBETE5TEgcxiZ8vIE0kZqjvR1V/VxKv3JR4DcMbIscvW+3ONoeFdJ0SFn8
 EFKCcfKh7aV1sXiudfUhwHj818T/uEdwk+SBl/EWUIfwyzu6lbuwYnN3EoVxw515473X
 mkBA==
X-Gm-Message-State: AOAM5300yN1bA9voKwhJtFnIqJzWktusc7yA5OYq/aK2kE2kGJr9/Gn/
 uYIFzQL2NHLoMhKhRFt06m8OJl2sCkzEAAKBrAY=
X-Google-Smtp-Source: ABdhPJx00f633nK+qysghi0WUdNTia8Xb6q3VMy+pVl2keYUTS6mAJ/RyPNLgJDRFvGtxwYeKiGG4Q==
X-Received: by 2002:a65:4582:: with SMTP id o2mr4525121pgq.97.1607565632732;
 Wed, 09 Dec 2020 18:00:32 -0800 (PST)
Received: from [192.168.0.104] ([49.207.210.144])
 by smtp.gmail.com with ESMTPSA id y69sm4021999pfb.64.2020.12.09.18.00.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Dec 2020 18:00:31 -0800 (PST)
To: Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
References: <20201209181322.27932-1-anant.thazhemadam@gmail.com>
 <9e38608c-9fc3-1f94-d275-742facef3db3@huawei.com>
From: Anant Thazhemadam <anant.thazhemadam@gmail.com>
Message-ID: <8d293b99-4414-1317-7426-79692bbaa715@gmail.com>
Date: Thu, 10 Dec 2020 07:30:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9e38608c-9fc3-1f94-d275-742facef3db3@huawei.com>
Content-Language: en-US
X-Headers-End: 1knBG2-005oNq-OH
Subject: Re: [f2fs-dev] [PATCH] fs: f2fs: fix potential shift-out-of-bounds
 error in sanity_check_raw_super()
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
Cc: linux-f2fs-devel@lists.sourceforge.net,
 syzbot+ca9a785f8ac472085994@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


On 10/12/20 7:16 am, Chao Yu wrote:
> Hi Anant,
>
> I've posted a patch a little earlier. :P
>
> https://lore.kernel.org/linux-f2fs-devel/20201209084936.31711-1-yuchao0@huawei.com/T/#u
>
Ah well, that's alright, especially considering that your patch looks better.
Glad that bug has been fixed nonetheless. :)

Cheers,
Anant


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

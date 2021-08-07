Return-Path: <SRS0=9WZ1=M6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0EBC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  7 Aug 2021 16:44:45 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C717C61058;
	Sat,  7 Aug 2021 16:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C717C61058
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mCPRE-0003nN-F0; Sat, 07 Aug 2021 16:44:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <axboe@kernel.dk>) id 1mCPRD-0003nG-Ie
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 07 Aug 2021 16:44:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sE4J/KNRIhq4Qq1TJTV7nxoeSBjq593vfcTRyIoqZB8=; b=mkWKDJEOu+lMDT+lGRJ3rvpsP5
 SR13np5dcXNOAMNeWP8CYiiOV7t90scxd4PnYXAd4gFkLc5j8AASYkIoR0hn7AM1ZP6D5yLwnc//T
 PT6NLIujr52ebCYKB8FLimBVFdJZGFQVKgw8oizHQHf6TB3jx12QjqEjCLjihD3JU0jc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sE4J/KNRIhq4Qq1TJTV7nxoeSBjq593vfcTRyIoqZB8=; b=kkVnJdO6L/UfpEZoRrH5WlwBfw
 uJBhviD0se/h53qSttVRPTaDyPKxW2SDyGFSlSpffjJRRWqCdvTowIG49JK3E4GN5OffHKmYGwZpN
 mOya/fH9OXtTbsaLGWKWkNITi3AV2tN6gFPHrSTlvWYBn8mG49ilNuV8RERxIzf8cypk=;
Received: from mail-pj1-f41.google.com ([209.85.216.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1mCPRB-0006bU-O4
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 07 Aug 2021 16:44:43 +0000
Received: by mail-pj1-f41.google.com with SMTP id
 u13-20020a17090abb0db0290177e1d9b3f7so27426056pjr.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 07 Aug 2021 09:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=sE4J/KNRIhq4Qq1TJTV7nxoeSBjq593vfcTRyIoqZB8=;
 b=F8bJc5ayOa1NQ/0OLvIq7fauc1tSb4zx9pEU23QZ03TiiHbDjRvGxkf4tZiV/xmwuw
 qXJBY04ip1ae+q8XRoAgpltiT/vwxOfzHD1FSKvNBAAOdC0MgORNTxsnWjF/H1Oo90Ys
 6E0jDg5fXZm/Tyhqi5xSbdJJefUZme4h1sR2G8NoGw5zfX2rEWHwu4moCjzi22X1sGt0
 Qt7/cxoAwgTwUaxfr1M8NIcx1iCOsCaMSUG239oKtOTnqvhJBUzmo7nfgYynFwFe/OqQ
 eV2pkrza5d5MrVkNZ/JJrxRer+hTlanySw3H7TR9VqkpgIRbAYnHI61HYrA+x9AT+NFm
 2NcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sE4J/KNRIhq4Qq1TJTV7nxoeSBjq593vfcTRyIoqZB8=;
 b=mAFfnSGq8umNspteQuryt6c8stcmE34CykRaLHy0EM+qP74TxCHUlAvua5UR4KGHwB
 1890hJ7+n0H/QMqtifbKUQu25vMlkTKy5p3ZnQaXR0oTIxm8QV5/pMCUNsOoSv7/DDGe
 1PH7nXBFC3PllXXuzsXoqal7Lio91qKzlwO8EcemcMDeySn2dUd9Thac1Xcfta3IL43A
 LlK+TycnjrZuqXE+wQcKOxVqhVlVL9zH9KyU7wpXEsL7wV11ZQpFVFScuQHNa+xhbnta
 FEK1qrsf2WWPiKFcgESF1HcDLPzKLnKp98BLOS0rfwMi6gr/rPTFYo7+6387zySEfGef
 VzxQ==
X-Gm-Message-State: AOAM531p73k8Dwtt0QgEDJQz1f2sKFoMsJxpYaBqFPMhq7cMw+uK/riG
 XYbshGYiVt4XmqgslcmTW+rig8bi70Ppxa6H
X-Google-Smtp-Source: ABdhPJzk4/8bmVQ2Nl31owua5k69ZyxSZipU5YOIY/m7LVvU8DIehftrExiEXUCenqHaKirRIpmZYQ==
X-Received: by 2002:a63:cc0e:: with SMTP id x14mr1332919pgf.352.1628353192079; 
 Sat, 07 Aug 2021 09:19:52 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
 by smtp.gmail.com with ESMTPSA id jz24sm12842797pjb.9.2021.08.07.09.19.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Aug 2021 09:19:51 -0700 (PDT)
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org,
 Paolo Valente <paolo.valente@linaro.org>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <yuchao0@huawei.com>
References: <20210806111857.488705-1-damien.lemoal@wdc.com>
 <20210806111857.488705-5-damien.lemoal@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4bfdceb3-36a7-c224-c1cc-ab273ab15589@kernel.dk>
Date: Sat, 7 Aug 2021 10:19:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210806111857.488705-5-damien.lemoal@wdc.com>
Content-Language: en-US
X-Headers-End: 1mCPRB-0006bU-O4
Subject: Re: [f2fs-dev] [PATCH v3 4/4] block: fix default IO priority
 handling
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

On 8/6/21 5:18 AM, Damien Le Moal wrote:
> diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
> index 99d37d4807b8..5b4a39c2f623 100644
> --- a/include/uapi/linux/ioprio.h
> +++ b/include/uapi/linux/ioprio.h
> @@ -42,8 +42,8 @@ enum {
>  };
>  
>  /*
> - * Fallback BE priority
> + * Fallback BE priority level.
>   */
> -#define IOPRIO_NORM	4
> +#define IOPRIO_BE_NORM	4

This again seems like a very poor idea.

-- 
Jens Axboe



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

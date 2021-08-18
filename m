Return-Path: <SRS0=J76h=NJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C35C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 Aug 2021 13:24:25 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D4D61058;
	Wed, 18 Aug 2021 13:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 41D4D61058
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mGLYO-0005Vl-5c; Wed, 18 Aug 2021 13:24:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <axboe@kernel.dk>) id 1mGLYM-0005Vf-S0
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 Aug 2021 13:24:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wG0Jsk1J07jpKpJSfxE2x1g+CeG4Hcc15pP5LaOetew=; b=F0P83kSCprtA0zpQdGeXLOP2mR
 9T7Rf1SKaVjv2YLDdSKEgrFFDrFSeacxU1SHsSP/+/pneKw75mxR/dF8x8Aq5ufzYn+sSSs3r30AT
 +T+Ja1jRY6LRbg1sCFXIvLbEfOAsqkD9mMgIliFaNTCfQCzr9R8UCCwhprQGd8qSiZ/A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wG0Jsk1J07jpKpJSfxE2x1g+CeG4Hcc15pP5LaOetew=; b=I1tWIAXpzZmlAKdb0Obn+4/hen
 ANmGZ4BdEzAZop/Q4uUxVwnoLp8apcLsY76yYHLL6Yk0IL76gjxnjfcnzjOsbJpCmbuOzaXGKbm40
 Suc/YVBQ1khwTc96sk97P43QktpzcYFLcM9c7vK8m8gJxLTqK+a/is5YH4+AaY14da0k=;
Received: from mail-pj1-f48.google.com ([209.85.216.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1mGLYH-0004vl-DV
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 Aug 2021 13:24:22 +0000
Received: by mail-pj1-f48.google.com with SMTP id
 om1-20020a17090b3a8100b0017941c44ce4so8862717pjb.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 18 Aug 2021 06:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=wG0Jsk1J07jpKpJSfxE2x1g+CeG4Hcc15pP5LaOetew=;
 b=iQwolJeKqd+VyevgcX3xE+f9wOK/AsPbqlKCg565RYfUuC95BhVQ1FR2TxcDdqWCJI
 gT1UoTFE8YrKBGnD7uzXD7LSFgg5vs3TueA3apeGEKi1UJi8EZKbOLP78mtTeKd938e/
 E5iJ0epPcPFA9ggyVj7aZL8zibzRrw3XcrQhKI65RJNbK8iPTWAptbEesJ5QdsNjwogc
 s7DtdNHStzH7YEEKey8CV5rHCI608ehPIwK+Qftqc4iqJkDlXvZQ6M8TyrmctMB3bWtk
 iLwrE6maxveUXwhc/8Edrca/YhrNveH92cI/W0DgGnsKwu0shZpIWBvwUSSlTT47LKsI
 yJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wG0Jsk1J07jpKpJSfxE2x1g+CeG4Hcc15pP5LaOetew=;
 b=erhKy27JQ2uDJz/fZg/wfSow3a7M7KKdjefCudpEAOJ9pAlcZ413xPmOv/KaF3vfn2
 eommN5MlGOoFTcjk1DMwZ5fahBsSBndHB+YPC0L8vOdMu9iEwvJO8ZJOPs8a7cdnRerF
 xP481eZR5a+CUXqtGTngZ8MGNRfAqLoo8JajUGK1w2VMuW4H9qCYnIW30x2k6Wj5AwPR
 QCYM2Wf0/lxLwqpSYVhM/iHaIf8RoTpPaQDRuMYFrCceDr+ewF8PdZFQwg9Ck7abCtLf
 P7leO160Z5jnciCOR8Q7C/H9zEf7OvdXWb6MCM9iA+VvLVLehF1vWReffRtTTTIZwJoI
 IgkQ==
X-Gm-Message-State: AOAM530YXcDFxWY0+CG9JS7LEHtaWs72BAJ0PxHCCsbt5GfKJD59zc1b
 iadRaaLhvLyfsZ/ecodoONxcGg==
X-Google-Smtp-Source: ABdhPJx6mkK1HEgeioEM+efuhhVDx/bR4NWxut/EUJTWBN8nm2olTPV1U1LosI3J3LSaVcNoI2m7lg==
X-Received: by 2002:a17:902:7c87:b029:12c:8f2d:4238 with SMTP id
 y7-20020a1709027c87b029012c8f2d4238mr7389520pll.50.1629293051791; 
 Wed, 18 Aug 2021 06:24:11 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id ne3sm5428108pjb.51.2021.08.18.06.24.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Aug 2021 06:24:11 -0700 (PDT)
To: Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org,
 Paolo Valente <paolo.valente@linaro.org>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <yuchao0@huawei.com>
References: <20210811033702.368488-1-damien.lemoal@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e998936b-5452-1048-80f2-4161bb77b3de@kernel.dk>
Date: Wed, 18 Aug 2021 07:24:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210811033702.368488-1-damien.lemoal@wdc.com>
Content-Language: en-US
X-Headers-End: 1mGLYH-0004vl-DV
Subject: Re: [f2fs-dev] [PATCH v4 0/6] IO priority fixes and improvements
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

On 8/10/21 9:36 PM, Damien Le Moal wrote:
> This series fixes problems with IO priority values handling and cleans
> up several macro names and code for clarity.

Applied for 5.15 - note that I dropped the lightnvm change from 6/6,
as it isn't strictly needed and lightnvm is deleted from the 5.15
drivers branch anyway.

-- 
Jens Axboe



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

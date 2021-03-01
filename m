Return-Path: <SRS0=5oWo=H7=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31459C433E6
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  1 Mar 2021 14:17:20 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E104B64DF5;
	Mon,  1 Mar 2021 14:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E104B64DF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lGjMN-0000RP-JS; Mon, 01 Mar 2021 14:17:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1lGjLb-0000PC-KU
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Mar 2021 14:16:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E04k4E5RYfSl8gKJ7I9Vzvg34SKuGc7vYQrJk0/qDKw=; b=fm5PLMzNrQ3buAuGodcBGNMwi9
 Q9BizgTuJDoY8+4XTOJ98lhWTWsBI24Ka8VGAhyd+qis4a1lyxubKneNLf3gy++r1pBXV9lmyE5JZ
 6bZEYa9JPfCKz7craNqjy19WEwTPJ2bPprfef7ZZwQ3Wcg5rFPjo4HFXGYemFNWPNiek=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=E04k4E5RYfSl8gKJ7I9Vzvg34SKuGc7vYQrJk0/qDKw=; b=UTGNs6kj1oyWMbSp4Alm3oR2Yr
 J4ZxwWAb5JV4zWGpl1Y5LkUsots/3XyodBpI0ZRzA3/j0PEP0f5cQgvhyZfYDNys8gahFM2an76l9
 hGJXVwGXeLCe5bmlD6tUClLMQHsjznPFK1YVU+RNwQMoSsoSYxTim28Agf7OXkgjlMPE=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lGjLQ-009xXL-JZ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Mar 2021 14:16:31 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 975ED64DFB;
 Mon,  1 Mar 2021 14:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614608167;
 bh=3Rhut/BhHs+UNJ1y8XYOOu+7cTQI+a+CansNeF7J0Fw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=awBNsXMyC45D5DQr5/foB+lSLWtBeyBqIf+5spcD+lIcyhJzRIQ37NBsec/sRtJ4G
 jD7cMbejGSj8CjyTQ7XrXopPmAr6eKSsExgKXRgOdmz5G6on9h9j7wEwC0xCxJY6GL
 bIBJUTXng7LO3tWiQSpjJSdNK+Q8ONJlGQWd/tA8ciymUyVYV8egTyX4++85gLVzQm
 VAMz6zuthpvKIUgTGUS94t0s77zXFDqNG9rCdW9kE/GzddJGmACzGe61IhKCxFoA53
 Q1QA2Lc/9IlNKqDNZl82rwFl5VRUPN4R3VfjIzah+SH2A7ukDX8zmO5Lu8ENQUyZvO
 eMyZzRuh9lgOw==
To: Huang Jianan <huangjianan@oppo.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20210301045844.154809-1-huangjianan@oppo.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <57c26fef-5566-cf91-3768-206ed7f09c7e@kernel.org>
Date: Mon, 1 Mar 2021 22:15:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210301045844.154809-1-huangjianan@oppo.com>
Content-Language: en-US
X-Headers-End: 1lGjLQ-009xXL-JZ
Subject: Re: [f2fs-dev] [PATCH v2 3/3] f2fs: check if swapfile is
 section-alligned
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
Cc: zhangshiming@oppo.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/3/1 12:58, Huang Jianan via Linux-f2fs-devel wrote:
> If the swapfile isn't created by pin and fallocate, it can't be
> guaranteed section-aligned, so it may be selected by f2fs gc. When
> gc_pin_file_threshold is reached, the address of swapfile may change,
> but won't be synchronized to swap_extent, so swap will write to wrong
> address, which will cause data corruption.
> 
> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> Signed-off-by: Guo Weichao <guoweichao@oppo.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1C9C6FD1C
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 26 Mar 2023 03:53:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pgHRV-0000Fz-Pi;
	Sun, 26 Mar 2023 03:53:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pgHRU-0000Fq-UN
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 26 Mar 2023 03:53:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j3pBx/SOqHmhXjQ4LckLCWEWt9EX75JZFkhp4y7gPxM=; b=f/wpSRuVv62EzW3x8uCwUjCfO7
 ugh1udFdkqw0jnpis2owRlRvyGzg5mdByMTJbrQfz6F3zgbkcbI2L/QsGpZ0Aue0SWGXLGxmJnn5Y
 jK/57zzlAFMCeoEUk5r7G14kxNP3GTTIUszydBK30IenpzuONiVyYmKTMRRVw88Cj+cU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=j3pBx/SOqHmhXjQ4LckLCWEWt9EX75JZFkhp4y7gPxM=; b=RBTN6ruHAihYS1T0XT4zfOMlJu
 7mT/L5VqxubVVN0BA87KMh6A4sGJ4u01y8x17wJlQqWD2/IGmVeI9J+920LGrzRBdg2UvgS+7erfy
 PtJ5M5irzppSMF9NYnhaqr2GXPswA5A+0BTONUZUDC0HfG/mFUsgoyM1qowQu2NaHgnc=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pgHRT-003pg7-EB for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 26 Mar 2023 03:53:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 5D972CE0B93
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 26 Mar 2023 03:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31B6C433D2;
 Sun, 26 Mar 2023 03:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1679802783;
 bh=RF6N9FVB3DivyoIx0C73mEw6zoogCODNFdFMIq0xZuw=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=naIuWWlPpbSfMczMPHstX2SNjWeBSwif2zJ7NElVzl/1us2RRpROsT8kia5Plsxxa
 /nbjvIs0l68FkbpHxzhaSnNMwYVegOlLC7lUwIppFbULi/daAJ04Dghx0Kh42KWBk8
 z02CJZBwpYQgP5JpNC4HM67IBcBTG7uWtbCes6fLjjPo+JMCoti01cyTz3bI/K9dYS
 THAJTu1TsFAqt2dTz9tqWD4rb7kbrCmI+gfVG8UX3vXTekX29lFPRus6OpDjED5Ifv
 K+uCtG8fKb+s7CJ6pFiXvp/wOwktEymu3hmiHSrh/53F/kLoMXNAyhBA+loAqdCZdD
 6/6WpP3GBgo5Q==
Message-ID: <3b2c0df6-fedf-8941-9242-6f6571ad7372@kernel.org>
Date: Sun, 26 Mar 2023 11:53:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20230321231157.963598-1-jaegeuk@kernel.org>
 <ZBo/QcTFUiqRafLC@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZBo/QcTFUiqRafLC@google.com>
X-Headers-End: 1pgHRT-003pg7-EB
Subject: Re: [f2fs-dev] [PATCH] f2fs: apply zone capacity to all zone type
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/3/22 7:35, Jaegeuk Kim wrote:
> On 03/21, Jaegeuk Kim wrote:
>> If we manage the zone capacity per zone type, it'll break the GC assumption.
>> And, the current logic complains valid block count mismatch.
>> Let's apply zone capacity to all zone type, if specified.
>>
> 
> Added:
> 
> Fixes: de881df97768 ("f2fs: support zone capacity less than zone size")
> 
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

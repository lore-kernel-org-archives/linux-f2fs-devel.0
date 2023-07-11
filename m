Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2E7EB64D9
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Jul 2023 02:01:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qJ2gc-0004QB-Ai;
	Tue, 11 Jul 2023 02:01:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1qJ2ga-0004Q5-SV
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Jul 2023 02:01:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XhkWvTRJka6IdcGCK9Cuk8fjndV4LF5AA1pEha3Mkak=; b=gOFy7IXliZ7NK3kTtGQDb1V9nG
 v3pmBpICtzlN8kq+Y4Ga7LdHRcgbxLaDC33gFDDK5+JXIQzNgGj3GMTA6CG56hqBCsilvjq0uxy0p
 QgKJR9f8lh8LGW180AmBr8AusFamKqC0Xb4WN6N7cy6IYLb9NLyYsbAEO/Z33mLLbIHU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XhkWvTRJka6IdcGCK9Cuk8fjndV4LF5AA1pEha3Mkak=; b=I5iMpk0ukdYUnkNXrbrSmxTh/G
 wX6WiQBweqyrZliHu8/cpXFbi/eW4Id38eMYamiOATo5uazkYud900flLgpew6dZ1OxpTRGPj0kc1
 kptUxcv6gHYKOy5stBcoblhixF5jwKQcGUCbeVXm7AKEhJ7sjBYFIrCNK8wTB12jZMMw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qJ2ga-003pyQ-JN for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Jul 2023 02:01:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 635A561217;
 Tue, 11 Jul 2023 02:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCCDC433C8;
 Tue, 11 Jul 2023 02:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689040857;
 bh=l2hscFblUVpAyfjjjjsEelyTSWlKonNRiDD3zw9mTXM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=j5B2L1FsInz2G3qVqNJOuLdDhXP7cSq1TMd6eZM/w5RkSa/FaUWN/jSLGksLRqk08
 8VgfqM083jGGo0T4GtpwAimzeOFCAYrXNWb+eeBNEhE56Kt1zT8XwdjYwaWdBTeesq
 sJNioeRZEuzj2o1mYECloZBKS5w/sumJf3WRG/pBznlJZELRD9HO7Snp2X/+PSLQFv
 lTAxc2L9wxlcGVTUehlk7+L5gcUvPr+z0K4mdTQCdFyg5Xf35RHLdfIuysnpIjxFbt
 wAOorU2Sz6icw//YGHEK8WO+hnbW9FT6eiPQUG6qp6E0X0+gbGBe1iioBNc8zDcKm1
 asOUlkgq/9VZQ==
Message-ID: <4d484518-5822-bd4b-4261-08a3aec6b5d2@kernel.org>
Date: Tue, 11 Jul 2023 11:00:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230707094028.107898-1-hch@lst.de> <ZKx2jVONy35B0/S1@google.com>
 <c0883104-8472-91b1-b9ad-ec3114bd166c@kernel.org>
 <ZKy15tpRQjja6s/5@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZKy15tpRQjja6s/5@google.com>
X-Headers-End: 1qJ2ga-003pyQ-JN
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't reopen the main block device in
 f2fs_scan_devices
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
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/11/23 10:52, Jaegeuk Kim wrote:
>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>> index ca31163da00a55..8d11d4a5ec331d 100644
>>>> --- a/fs/f2fs/super.c
>>>> +++ b/fs/f2fs/super.c
>>>> @@ -1560,7 +1560,8 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
>>>>  {
>>>>  	int i;
>>>>  
>>>> -	for (i = 0; i < sbi->s_ndevs; i++) {
>>>
>>> #ifdef CONFIG_BLK_DEV_ZONED
>>>
>>>> +	kvfree(FDEV(0).blkz_seq);
>>>
>>> #endif
>>
>> This should not be needed since for the !CONFIG_BLK_DEV_ZONED case,
>> FDEV(0).blkz_seq should always be NULL. However, what I think may be missing is
>> "FDEV(0).blkz_seq = NULL;" after the kvfree() call. No ?
> 
> I was looking at a glance of this:
> https://lore.kernel.org/linux-f2fs-devel/202307110542.NBAMyZxE-lkp@intel.com/T/#u

OK. Got it.
I still think that it may be safer to add the NULL affectation though.


-- 
Damien Le Moal
Western Digital Research



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <SRS0=dspS=M5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8091C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 Aug 2021 08:43:19 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4C060EE8;
	Fri,  6 Aug 2021 08:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B4C060EE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mBvRm-0000Ii-U5; Fri, 06 Aug 2021 08:43:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1mBvRl-0000Ia-2e
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Aug 2021 08:43:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FUHdTUUzrmI0vgc1WQN8MpQsVRx5jXVV2tdess0jzmM=; b=gydYAiegut5+xEm9zcsGJ+zBoc
 yQtFRX62hoOj61pbDfRgXeuHspf63knZtkq8/oa9iTkkazAtU4NqmAzOaA6SDd82t/1g+XiLSGDLf
 Bl2NOhlEVdUbVXNWI0n3p1MN2lPBEo2n1dGCfiJqNfF7hlETNJmJKHZg9KvBvghiC56c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FUHdTUUzrmI0vgc1WQN8MpQsVRx5jXVV2tdess0jzmM=; b=X1hP81JLuudo+rP9VgSfpMCiVn
 mUJRwo9mssctkgnwyEpLk/70o+XDqXzYFqT4KWa5ak9iX1DCBoXkf1307lHbXU1IbD2smKqoRLCu8
 zytqfQdZOJU0kn/ynWLeDnPMiq4vlPRga6kFXsE17bFAH0HbiW1Tun8dD11E6SdGvfaQ=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mBvRf-00ESM1-QH
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Aug 2021 08:43:17 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3552A60EE8;
 Fri,  6 Aug 2021 08:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628239379;
 bh=VHH72HDrDpFee5N9FD46qxD4yGnv/WZS5HbrpLN3B1I=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=dr4YGQldr2YTaE3J6b2q1vgtHEBmCq3x2ZdHljDfI09mYGmIUMi6pOsLBsADt97MK
 tDbydsJfuPgwa0X0MEv82O4BWKgT5kv/+W5tf6s9bqOGcBMqKY5d1i1tPrZqYQJiOi
 gResA1R8iSl+EKDVg2extDq6ytyrINFV18EEfG8TUtUW6wYY/HRYKoxFoRUo2EpcRS
 HQHwlfDTw/5QoY+JDXM0JxeVe0E0v7/ubCcqCZwLV2JOB13ATucr1/iDaF+qoH+/Jy
 JUpsnGD2fCRaprEoXQ7PVIUjVvy85CybmmV1Wo3rwuD5R1O/wWiachnxwJKyMIGxpL
 WG4j/D/fWvqgA==
To: Fengnan Chang <changfengnan@vivo.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20210723023131.131137-1-changfengnan@vivo.com>
 <a906c95e-3b7f-fe0e-d016-ae6e76564dc8@vivo.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <b83932b4-a727-b085-692b-49c50f7caa4f@kernel.org>
Date: Fri, 6 Aug 2021 16:42:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <a906c95e-3b7f-fe0e-d016-ae6e76564dc8@vivo.com>
Content-Language: en-US
X-Headers-End: 1mBvRf-00ESM1-QH
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: compress: allow write compress
 released file after truncate to zero
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

On 2021/8/6 16:35, Fengnan Chang wrote:
> Um.. I think this version should be ok.

Well, actually, I mean adding description of this behavior into compression
section of f2fs.rst.

https://elixir.bootlin.com/linux/latest/source/Documentation/filesystems/f2fs.rst#L829

Thanks,

> 
> Thanks.
> 
> On 2021/7/23 10:31, Fengnan Chang wrote:
>> For compressed file, after release compress blocks, don't allow write
>> direct, but we should allow write direct after truncate to zero.
>>
>> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
>> ---
>>    fs/f2fs/file.c | 8 ++++++++
>>    1 file changed, 8 insertions(+)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 6afd4562335f..094f6546fd00 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -740,6 +740,14 @@ int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock)
>>    		return err;
>>    
>>    #ifdef CONFIG_F2FS_FS_COMPRESSION
>> +	/*
>> +	 * For compressed file, after release compress blocks, don't allow write
>> +	 * direct, but we should allow write direct after truncate to zero.
>> +	 */
>> +	if (f2fs_compressed_file(inode) && !free_from
>> +			&& is_inode_flag_set(inode, FI_COMPRESS_RELEASED))
>> +		clear_inode_flag(inode, FI_COMPRESS_RELEASED);
>> +
>>    	if (from != free_from) {
>>    		err = f2fs_truncate_partial_cluster(inode, from, lock);
>>    		if (err)
>>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

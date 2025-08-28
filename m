Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D91CA0EED
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 28 Aug 2025 23:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F/1cbJIdf1cNXvuP4dI1vL3sBrlGGtA1h97eBQW37y4=; b=MqZUqLgZX4GHIM4X7vsyPTlhUc
	nh0hnGgVw+2+lqpHjiOIKAED2pguRKoxG5lqNIgKCpd6gZkCk3h/m4yA63J9j+SovVFQiVu9S3hid
	pgmY3teTdjcT60CkIugpiEAeM2YtmTUnpbFFn3H055bT32jlWKzpyRAW3k8Rbliw3WeU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1urlrr-0002IF-70;
	Thu, 28 Aug 2025 23:17:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1urlro-0002Hx-6G
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 Aug 2025 23:17:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A3uQmaTs2hJWk0dIcoILbNh7aVt7WO/9SpsLvGN7oDo=; b=W1/g7LEevrc5e0SgM6FpL3n3bE
 6l6+F+zXp7MAqF4sjQROoAgTT05d5LNG6ciYVKPmXXu8OJXYBu84dW4ggJ1tQQq94hdNH4oDei3RN
 G6NKtLEfXxpah1IN2tUcxcXXsQ781i7Py+4KcDqMbauoLerLPZf4inYhwFLcOXUE/jPI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=A3uQmaTs2hJWk0dIcoILbNh7aVt7WO/9SpsLvGN7oDo=; b=A2eenpJyHiTdZBkoW41xkzUIKb
 ROoZ4fDcZ+O5VO8xPvGn8ZeNO+3I8zeks3DwPeSsaJzekE0B9T5TjnTreel5lYif1/U/YWYFw8ptX
 oUtotTPElTqycR4XfufFDBAqWWhbkbuq0hFwqm6YUOApHqd59D1pxMNw1I1GAZqywRNo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1urlro-0000q2-IV for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 Aug 2025 23:17:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B7EF56013C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 28 Aug 2025 23:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DB2C4CEF4;
 Thu, 28 Aug 2025 23:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1756423025;
 bh=vyNzlhZ4CJ+EPkkki2G+silw4Yi9AWcfRQxB9K3f7Y8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=pb8GujEFEf+1a+YHXO2bg1bKKqcxZGi84a5Ia4StEMwb1a5/wFa7z1xMValewbA2M
 +5qYl4f1rLe331VqnkLcATHJCfA2muBSxIHd09wfVofMCGZEhkowo6uHj2DiHHoema
 Fm6PDRIsKwNzQNYobZBSpSiy6CiiSBFWCEXTk2e68TG/tMY/E6MLt9r+jgye6mtbi8
 HMho+7izKtGUpFVjScTB9ZluOM/tHq18pChaofK5hCZ3vLvkgZZfJRWqCpeDULQdpw
 +7ErT3EpOXUAEmeGe+qiW9nkumsA8VEabt4P8fiTgaGHJx1NZoT7GFTpmV5zRD/Nwx
 dzZSRlw5ucLZA==
Message-ID: <c7a0afdc-3f33-4de7-b36d-b0d5f55216e2@kernel.org>
Date: Fri, 29 Aug 2025 07:17:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250827215222.1615844-1-jaegeuk@kernel.org>
 <bfbd5db4-c103-4a08-8568-1d27c8eba676@kernel.org>
 <aLB0XeQh_tm2tXIA@google.com>
Content-Language: en-US
In-Reply-To: <aLB0XeQh_tm2tXIA@google.com>
X-Headers-End: 1urlro-0000q2-IV
Subject: Re: [f2fs-dev] [PATCH] f2fs: allocate HOT_DATA for IPU writes
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/28/2025 11:23 PM, Jaegeuk Kim wrote:
> On 08/28, Chao Yu wrote:
>> On 8/28/25 05:52, Jaegeuk Kim via Linux-f2fs-devel wrote:
>>> Let's split IPU writes in hot data area to improve the GC efficiency.
>>
>> I didn't get it, IPU may be not friendly for migrating data along w/ write in
>> hot area?
> 
> This deals with IPU in the LFS mode.

Okay, so, we missed to add f2fs_lfs_mode() condition, right?

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>   fs/f2fs/segment.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>> index e0f6589c6a1c..bb79dad55ac9 100644
>>> --- a/fs/f2fs/segment.c
>>> +++ b/fs/f2fs/segment.c
>>> @@ -3688,7 +3688,8 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
>>>   
>>>   		if (file_is_hot(inode) ||
>>>   				is_inode_flag_set(inode, FI_HOT_DATA) ||
>>> -				f2fs_is_cow_file(inode))
>>> +				f2fs_is_cow_file(inode) ||
>>> +				is_inode_flag_set(inode, FI_NEED_IPU))
>>>   			return CURSEG_HOT_DATA;
>>>   		return f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
>>>   						inode->i_write_hint);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

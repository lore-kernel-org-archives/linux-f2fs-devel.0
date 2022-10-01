Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2893FC433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  1 Oct 2022 00:26:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oeQKW-0007sb-Jk;
	Sat, 01 Oct 2022 00:26:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oeQKV-0007sV-Ed
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 01 Oct 2022 00:26:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MCA/1XiA7nNMzGmreXyf7DyVJXqLqRMtcIlKLnmiXgo=; b=GX1bV/tkYruwXz7gr6sAXy4sT+
 /mjzF4Q3u7AHi9h5FtuqnUKhVqrVLyfj/tPOakyVdJIXLFaY69PY4Vpv94DxlQ4UsOxLe/4mRZhIW
 EwLSpFrzmON8SubTMNEsxA5kcriNvTXvO6/ZwuCTU/jxH97hONI6veR94/ZB8lNS2BUI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MCA/1XiA7nNMzGmreXyf7DyVJXqLqRMtcIlKLnmiXgo=; b=eO36eG1QxGSaRYeaomKp4QYkxl
 cQK6GtNeJClE33d7MuC+GVjULPZXgAEygjaeBYre2dAr2pUIeb2nkV0jw3KpRt6/1t7Q6z/vfm3dU
 HAVtX12CJkmebnIWQy7tJOcoYocsIMQRvUgFgRRCy1zbZHRDp8hTxXIUMv8uSN8QXM+Y=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oeQKg-00061T-VW for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 01 Oct 2022 00:26:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 69D44CE2637
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat,  1 Oct 2022 00:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEB9C433D6;
 Sat,  1 Oct 2022 00:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1664583970;
 bh=PEKuQAer9EDZoDtDyN2Q6vurH8igjCFtgiY+Yky6uvo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TiY3/wfDAsJVxG8S1E1FWAiUGpnp0R4y+BheLG9rI1NSMRVeLI06Vzi0S9boZtmz8
 ivdYwh+uJWtNN1X15JaOuJkhMJ2MQoCNhd8t1cEb88Zu2zuC0b+un5ys1rE8uVQ1hw
 li8xk7WsT8vk7X053YDUqBdjlfVfDZezuWZLHqypgBD3iIJ1JyXkd11S5fa0TwUXpj
 RE7ZT4WpUq1BUpyGvKuP0e67rDG80+fC6mHhTpXNMJfs0x6SgcNHNYh5YQBLpk+Yp5
 dL/KFJsonZPHLORUGlR79mxKB22kaA3y0de4QLimJABUKg+3UC7HQGgu266rNiqKUu
 PHHstmCCMw/Bw==
Message-ID: <d42b88ab-39b6-71ba-a891-5d3a82b486d9@kernel.org>
Date: Sat, 1 Oct 2022 08:26:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220925055802.11955-1-chao@kernel.org>
 <YzMnm4vx7dxb+vAA@google.com>
 <f8be286d-a3d9-2426-ab79-34d5c6e80a9c@kernel.org>
 <YzO8P7/XM4OckVSp@google.com>
 <7387ba71-46bd-aed9-d435-f234f486a7a0@kernel.org>
 <YzXjrn7oZzVmUz/n@google.com>
 <45e56fa9-de7a-7858-f032-4433adb2b021@kernel.org>
 <YzduzKQN3xTg1cqh@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <YzduzKQN3xTg1cqh@google.com>
X-Headers-End: 1oeQKg-00061T-VW
Subject: Re: [f2fs-dev] [PATCH] mkfs.f2fs: update allocation policy for ro
 feature
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/10/1 6:33, Jaegeuk Kim wrote:
> On 09/30, Chao Yu wrote:
>> On 2022/9/30 2:27, Jaegeuk Kim wrote:
>>> On 09/28, Chao Yu wrote:
>>>> On 2022/9/28 11:15, Jaegeuk Kim wrote:
>>>>> On 09/28, Chao Yu wrote:
>>>>>> On 2022/9/28 0:40, Jaegeuk Kim wrote:
>>>>>>> On 09/25, Chao Yu wrote:
>>>>>>>> Update allocation policy for ro feature:
>>>>>>>> - hot_data: allocating blocks by LBA ascending order
>>>>>>>> - hot_node: allocating blocks by LBA descending order
>>>>>>>
>>>>>>> This will increase the RO image size.
>>>>>>
>>>>>> Shouldn't RO image has fixed-size during mkfs?
>>>>>
>>>>> First run gives the reduced size information, and second round makes the image
>>>>> with the required size.
>>>>
>>>> I didn't get it, in which step it may increase the RO image size?
>>>>
>>>> IIUC, after we apply this patch, reduced size information won't change due
>>>> to that after sload in first run, total used block count should be fixed?
>>>
>>> First run fills the data and leaves the maximum LBA touched in the image. Then,
>>
>> How about caclulating required size w/ total used blocks rather than maximum LBA?
> 
> Do you think that can give the smallest size for the image?

I guess so, but let me do some tests to check that.

Segments for data block and node block should be calculated separately:
required_blks = roundup(data_blks, blks_per_seg) + roundup(node_blks, blks_per_seg)

Am I missing something?

Thanks,

> 
>>
>> Thanks,
>>
>>> it'll resize the image file and run again with the smallest image.
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>>>>>> ---
>>>>>>>>      mkfs/f2fs_format.c | 4 ++--
>>>>>>>>      1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
>>>>>>>> index 40ac589..8d0f410 100644
>>>>>>>> --- a/mkfs/f2fs_format.c
>>>>>>>> +++ b/mkfs/f2fs_format.c
>>>>>>>> @@ -544,10 +544,10 @@ static int f2fs_prepare_super_block(void)
>>>>>>>>      	}
>>>>>>>>      	if (c.feature & cpu_to_le32(F2FS_FEATURE_RO)) {
>>>>>>>> -		c.cur_seg[CURSEG_HOT_NODE] = 0;
>>>>>>>> +		c.cur_seg[CURSEG_HOT_NODE] = last_section(last_zone(total_zones));
>>>>>>>>      		c.cur_seg[CURSEG_WARM_NODE] = 0;
>>>>>>>>      		c.cur_seg[CURSEG_COLD_NODE] = 0;
>>>>>>>> -		c.cur_seg[CURSEG_HOT_DATA] = 1;
>>>>>>>> +		c.cur_seg[CURSEG_HOT_DATA] = 0;
>>>>>>>>      		c.cur_seg[CURSEG_COLD_DATA] = 0;
>>>>>>>>      		c.cur_seg[CURSEG_WARM_DATA] = 0;
>>>>>>>>      	} else if (c.heap) {
>>>>>>>> -- 
>>>>>>>> 2.36.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <SRS0=HfhR=OB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73F1C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 11 Sep 2021 10:42:15 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66C2961074;
	Sat, 11 Sep 2021 10:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 66C2961074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mP0Sa-0006C0-81; Sat, 11 Sep 2021 10:42:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1mP0SZ-0006Bt-2f
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 11 Sep 2021 10:42:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t/F7M5qIgsEO+l5YgxHem6Bk4tXbh5bOJijI633gHUA=; b=Ntjjda0+KpqFEcg1FoTnhsmLpV
 cUgzSHO/rd831Hfd06SS31D7qQy0QI0oZMH+cRlOAKXQOaYw01SqBCdPpr89d9h/6xLBVLksfBNiS
 gaxtOXmT+SFtB+rQE/wdmXpRj5Fmv7gAwiT9G/v9mf0zEWda1FFUiCHOEZmXuzrAcvP0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=t/F7M5qIgsEO+l5YgxHem6Bk4tXbh5bOJijI633gHUA=; b=X1qZGBy980Eaur4ZMYEWu5Bk1V
 mgz409wMfIomXftsD2F4UR2SZuNC7D92POGDqrMOvdB57FdhpWZu7I6M9GSyjjqk3uhxeEh26kHYj
 MzuyVAkHg4expg8kgT1Ld4tO7Y2KAdU9cKw1ao6TFy06rqSkoDh0q2k/3MXylq3T2/Tk=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mP0SY-0003qZ-FM
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 11 Sep 2021 10:42:11 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A40360FDC;
 Sat, 11 Sep 2021 10:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631356925;
 bh=N0wtIK96dx3XM0eOaHSs5E3Sn4Ns8OuBLM3E1H39muY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=onyAAi7dUBGSiTnnPh8mufeQY8AAEFVpCA0jOYCXoMm7kumxMcywMfH7IaFy7q2UJ
 qPEI2Op+nqQ4/GG2zzIrR53BSu+hr8hem37s1baTQZpD/0OE7NHlt6/m2gUaAq00Cp
 oH9nRVaGC547VNNR93Ww1zWREdNsj7BCWyZMtS4AVAKTOADUHZxg1XRB2R0U1LRhcO
 xceqB6GzfRD5olyYpJAgj5vJR5Vkz1rULOSXrTNa7JTZvzcR+sMn2bwEEHhCTslFqu
 D00fslv/1muHou+eA/OGGS9m5sYcinfFSABIFTU0zuLhpf1Nk6HUk461rQdA2WVAdl
 Z73E+63cowxTQ==
To: Daeho Jeong <daeho43@gmail.com>
References: <20210902172404.3517626-1-daeho43@gmail.com>
 <9ab17089-accc-c3a3-a5dc-007fc4eeaa20@kernel.org>
 <CACOAw_yovM592K3-2fQzA6M29XqWu8s_2f+zXawKo-QpNSXq0w@mail.gmail.com>
 <8f8e4695-4062-60c4-0f91-2a1f6a5b0a11@kernel.org>
 <CACOAw_yBYZzUVGV-A7K57zqrcAaZv7nFSk9mSj9AC6jTTeU7Vw@mail.gmail.com>
 <f64cb941-2bb7-eed2-732d-c9537f46f67c@kernel.org>
 <CACOAw_zxq=SX0OdXV77HyFytJc6aCMbYuS6KZAR_JoQeGZ26Sw@mail.gmail.com>
 <a59d23b9-961f-4129-7491-59f88923366a@kernel.org>
 <CACOAw_z+yfNN3p3U3Ji0vLe7xDP4vkVy11RdzwwcRwwnSTjsFg@mail.gmail.com>
 <CACOAw_y24AdH2Mpx4uhYbhmHnVRtUU2_4USUmi0Q61HGtE95RA@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <3108fdfa-34c4-7e57-1674-c71ab08b4a1e@kernel.org>
Date: Sat, 11 Sep 2021 18:42:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACOAw_y24AdH2Mpx4uhYbhmHnVRtUU2_4USUmi0Q61HGtE95RA@mail.gmail.com>
Content-Language: en-US
X-Headers-End: 1mP0SY-0003qZ-FM
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: introduce fragment allocation mode
 mount option
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/9/10 23:24, Daeho Jeong wrote:
> On Fri, Sep 10, 2021 at 7:34 AM Daeho Jeong <daeho43@gmail.com> wrote:
>>
>> On Thu, Sep 9, 2021 at 4:50 PM Chao Yu <chao@kernel.org> wrote:
>>>
>>> On 2021/9/8 2:12, Daeho Jeong wrote:
>>>> On Fri, Sep 3, 2021 at 11:45 PM Chao Yu <chao@kernel.org> wrote:
>>>>>
>>>>> On 2021/9/4 12:40, Daeho Jeong wrote:
>>>>>>> As a per curseg field.
>>>>>>>
>>>>>>>> Maybe, we run into the same race condition issue you told before for
>>>>>>>> fragment_remained_chunk.
>>>>>>>> Could you clarify this more?
>>>>>>>
>>>>>>> e.g.
>>>>>>>
>>>>>>> F2FS_OPTION(sbi).fs_mode = FS_MODE_FRAGMENT_FIXED_BLK
>>>>>>> fragment_chunk_size = 384
>>>>>>> fragment_hole_size = 384
>>>>>>>
>>>>>>> When creating hole:
>>>>>>>
>>>>>>> - f2fs_allocate_data_block
>>>>>>>      - __refresh_next_blkoff
>>>>>>>        chunk locates in [0, 383] of current segment
>>>>>>>        seg->next_blkoff = 384
>>>>>>>        sbi->fragment_remained_chunk = 0
>>>>>>>        then we will reset sbi->fragment_remained_chunk to 384
>>>>>>>        and move seg->next_blkoff forward to 768 (384 + 384)
>>>>>>>      - __has_curseg_space() returns false
>>>>>>>      - allocate_segment() allocates new current segment
>>>>>>>
>>>>>>> So, for such case that hole may cross two segments, hole size may be truncated
>>>>>>> to left size of previous segment.
>>>>>>
>>>>>> First, sbi->fragment_remained_chunk should be seg->fragment_remained_chunk.
>>>>>
>>>>> Oh, correct.
>>>>>
>>>>>> I understand what you mean, so you mean we need to take the leftover
>>>>>> "hole" size over to the next segment?
>>>>>> In the example, the leftover hole size will be (384 - (512-384)). Do
>>>>>> you want to take this over to the next segment?
>>>>>
>>>>> Yes, the left 256 block-sized hole should be created before next chunk
>>>>> in next opened segment.
>>>>>
>>>>
>>>> Chao,
>>>>
>>>> Do you have any decent idea to pass the left hole size to the next
>>>> segment which will be allocated?
>>>
>>> Daeho,
>>>
>>> I guess we can record left hole size in seg->fragment_remained_hole.
>>>
>>
>> I understand we need a new fragment_remained_hole variable in segment structure.
>> But, I mean.. How can we pass over the left hole size from the
>> previous segment to the next segment?
>>
> 
> I mean we don't know which segment will be the next segment, do we?

Yeah, that's why I prefer to let __get_next_segno() return zero in fixed_block
fragment mode, then log header may have chance to allocate hole in contiguous
segments.

Thanks,

> 
>> Thanks,
>>
>>> Thanks,
>>>
>>>>
>>>> Thanks,
>>>>
>>>>> Thanks,
>>>>>
>>>>>>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

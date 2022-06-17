Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D202C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Jun 2022 02:11:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o21SB-000297-JU; Fri, 17 Jun 2022 02:11:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1o21S9-000291-Bo
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jun 2022 02:11:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IEZho9hsrcQ7ln30Hy5jedhhsWrzMsAvEDOSkWfxQqc=; b=DepPAj2W5KgoiW3QodgUPkAE3t
 JaTdYw+7zLojzRZzmPOeHlEi3F5H4cKaWv7BnFCtI90wZ0mYQyhGWQdpwUYP2DhtyvlNjraOxQ7AA
 ujrAkn496Z+vC0Wl6gxvb7JJe+lv1+7IbcT0uyZu6lVYNrqJjhj5F7SE1VjD0x9wSrPI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IEZho9hsrcQ7ln30Hy5jedhhsWrzMsAvEDOSkWfxQqc=; b=DHRO8cInlUfnpTJU9COAmNGv4T
 d0iOFC77iCfUJDXbSLJwW7bl2xT6lb1enxkWiqcRtXSS8B35FWXQ2KYiO6p1u0S5mcDdbwkHRSKkV
 pSf6DQkh6s6krwQ6i8wLA7sZJvXznuq+m33o8iHdsjnhOjCH5RRFwKSVbLMO5Barv23w=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o21S4-0000K5-79
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jun 2022 02:11:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 41801B82678;
 Fri, 17 Jun 2022 02:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D301EC34114;
 Fri, 17 Jun 2022 02:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655431863;
 bh=QPY07DOiwrobk1sDd+UEyWaHkeFieT3YC5LHtZ4kUbE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=S9DNiY9/QhI5BEmGQ9SswVFDRpIBvAy8/RMBTiKv1ZZoqCYDQu9QROyxa78sUVUS9
 NINtZkClxvgS3KkZVx/6o9Wt0KNR7PmLLWyX9KsYFDr6xLdxMzYCDhGTczeM7WRc2O
 n901/KrAuYKVzHMvGsdRGsD4IW0+Z1EVC9NKbdpQoI0Pbp2J+pbCW1NdeFnbBb+EJD
 u5RxrXy+dPgxwVsz+B4kuO8B8wSzciXUQIGbElFJtuU8hKRKtcJvWpBJm6JNA021Tv
 5IXX/MYxPXoNwBMjzxdKsm0KmMa3p6HDd/KTmWmdvGZDK1ex1g7M3BxWG31Zz649fS
 DOwne7b0D2DoQ==
Message-ID: <0f45566a-1bca-431a-fa6d-fdaa927415c6@kernel.org>
Date: Fri, 17 Jun 2022 10:10:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, Dylan Chang <y.w.zhang14@gmail.com>
References: <20220616035806.1663-1-dylan.chang@oneplus.com>
 <YqtllO83cEw1jb+Q@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <YqtllO83cEw1jb+Q@google.com>
X-Headers-End: 1o21S4-0000K5-79
Subject: Re: [f2fs-dev] [PATCH] Fix file too large causing overflow
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
Cc: Dylan Chang <dylan.chang@oneplus.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/6/17 1:17, Jaegeuk Kim wrote:
> On 06/16, Dylan Chang wrote:
>> fibmap: Fix file too large causing file_pos overflow
>>
>> fibmap show file_pos with incorrectly value when passing a large file.
>>
>> Before:
>>
>> ----------------file info-------------------
>> /data/media/0/data1 :
>> --------------------------------------------
>> dev       [254:18]
>> ino       [0x    4db1 : 19889]
>> mode      [0x    81b0 : 33200]
>> nlink     [0x       1 : 1]
>> uid       [0x    280e : 10254]
>> gid       [0x     3ff : 1023]
>> size      [0x1b3dca314 : 7312548628]
>> blksize   [0x    1000 : 4096]
>> blocks    [0x  da2530 : 14296368]
>> --------------------------------------------
>>
>> file_pos   start_blk     end_blk        blks
>>         0     3197602     3198463         862
>>   3530752     3197509     3197509           1
>>   3534848     3197557     3197578          22
>>   3624960     3198464     3396701      198238
>> 815607808     3396703     3632480      235778
>> 1781354496     3632482     3652095       19614
>> 1861693440     3396702     3396702           1
>> 1861697536     3632481     3632481           1
>> 1861701632     1514948     1514948           1
>> 1861705728     1518774     1518774           1
>> 1861709824     2543104     2543125          22
>> ...
>> 1862111232     2457813     2457813           1
>> 1862115328     3652096     3878168      226073
>> -1506856960     3878170     4133725      255556
>> -460099584     1510048     1510052           5
>>
>> Patched:
>> ----------------file info-------------------
>> /data/media/0/data1 :
>> --------------------------------------------
>> dev       [254:18]
>> ino       [0x    4db1 : 19889]
>> mode      [0x    81b0 : 33200]
>> nlink     [0x       1 : 1]
>> uid       [0x    280e : 10254]
>> gid       [0x     3ff : 1023]
>> size      [0x1b3dca314 : 7312548628]
>> blksize   [0x    1000 : 4096]
>> blocks    [0x  da2530 : 14296368]
>> --------------------------------------------
>>
>> file_pos   start_blk     end_blk        blks
>>         0     3197602     3198463         862
>>   3530752     3197509     3197509           1
>>   3534848     3197557     3197578          22
>>   3624960     3198464     3396701      198238
>> 815607808     3396703     3632480      235778
>> 1781354496     3632482     3652095       19614
>> 1861693440     3396702     3396702           1
>> 1861697536     3632481     3632481           1
>> 1861701632     1514948     1514948           1
>> 1861705728     1518774     1518774           1
>> 1861709824     2543104     2543125          22
>> ...
>> 1862111232     2457813     2457813           1
>> 1862115328     3652096     3878168      226073
>> 2788110336     3878170     4133725      255556
>> 3834867712     1510048     1510052           5
>>
>> Change-Id: Ic2486e25ea03114d4dbf3651650c6a2399db0714
>> Signed-off-by: Dylan Chang <dylan.chang@oneplus.com>
>> ---
>>   tools/fibmap.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/fibmap.c b/tools/fibmap.c
>> index 3238f29..3217600 100644
>> --- a/tools/fibmap.c
>> +++ b/tools/fibmap.c
>> @@ -47,7 +47,7 @@
>>   #endif
>>   
>>   struct file_ext {
>> -	__u32 f_pos;
>> +	__u64 f_pos;
>>   	__u32 start_blk;
>>   	__u32 end_blk;
>>   	__u32 blk_count;
>> @@ -56,9 +56,9 @@ struct file_ext {
>>   void print_ext(struct file_ext *ext)
>>   {
>>   	if (ext->end_blk == 0)
>> -		printf("%8d    %8d    %8d    %8d\n", ext->f_pos, 0, 0, ext->blk_count);
>> +		printf("%8llu    %8lu    %8lu    %8lu\n", ext->f_pos, 0, 0, ext->blk_count);
> 
> I had to fix unrelated changes from %8d to %8lu. Please check it
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/commit/?h=dev-test&id=74f81f441ce24dd47cfe68e6fb336e0142bf4217

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> 
> 
>>   	else
>> -		printf("%8d    %8d    %8d    %8d\n", ext->f_pos, ext->start_blk,
>> +		printf("%8llu    %8lu    %8lu    %8lu\n", ext->f_pos, ext->start_blk,
>>   					ext->end_blk, ext->blk_count);
>>   }
>>   
>> @@ -209,7 +209,7 @@ int main(int argc, char *argv[])
>>   			ext.blk_count++;
>>   		} else {
>>   			print_ext(&ext);
>> -			ext.f_pos = i * st.st_blksize;
>> +			ext.f_pos = (__u64)i * st.st_blksize;
>>   			ext.start_blk = blknum;
>>   			ext.end_blk = blknum;
>>   			ext.blk_count = 1;
>> -- 
>> 2.17.1
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

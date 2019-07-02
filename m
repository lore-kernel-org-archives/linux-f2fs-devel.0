Return-Path: <SRS0=nB2U=U7=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464EBC06510
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  2 Jul 2019 13:33:07 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12D20206E0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  2 Jul 2019 13:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="jfPo78mX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Ee+es/KM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="JKCAKrDv";
	dkim=neutral (0-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="eyvE5kwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12D20206E0
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:MIME-Version:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9AxoCR3vaPKwiuX9qITTcPkPLGWPF/EVZrwmN4Zqh4A=; b=jfPo78mXR6wZBjZZ9/hR0j6bN
	Q10EBfJtfAL/K/Mk3bzinHpwYrnGvVE+aSGKXwdJ6kE5tcOaClCuvc6r/oRnhrZOKh/awsHMtTxjo
	MDSv0oAUD5L2UEbQibYVzsKBgKgqXdW/5pWs0sBVEUK94oX2r8o02gCJjxa4HS4ArsBaU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hiIu1-0005py-GP; Tue, 02 Jul 2019 13:32:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <fishland@aliyun.com>) id 1hiIu0-0005pn-36
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Jul 2019 13:32:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:MIME-Version:Subject:Message-ID:Reply-To:Cc:To:From:Date:Sender:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RPDFdyKp8ZK5GUdmXV9I38qKv1OCQq69njcj49fcm3k=; b=Ee+es/KMakemaxO8xURLY494Il
 9GmledzM80af49NBnOvfbSnINT2IByXAqpciiVvDE5CK9eBNkrJc6TOYeRnu6oxdlNo38PxUiZeNb
 DAf4X2HAm01ZI3RsirPCMM1pUg5PXg55WW+kvddjiQmcu5kSSyz+jBRrx8owjicFAc9E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
 MIME-Version:Subject:Message-ID:Reply-To:Cc:To:From:Date:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RPDFdyKp8ZK5GUdmXV9I38qKv1OCQq69njcj49fcm3k=; b=JKCAKrDvwBmqyBb+h9oOFx47xr
 ByMBDr2YMpwoyjTXxxY1dY+fi+ABiMiLxoUy+KpE62MIZrr1gRM9y5ZEj7NxUHDgPSif5wRLRmn5i
 Iej8RZ7w4NcI+aiVcoHaHZ++m3rhWXCJU/luqPtnC+yeX/JCDbEBYuCGAbqZzVBZWvyc=;
Received: from out30-41.freemail.mail.aliyun.com ([115.124.30.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hiIu5-002eoE-IU
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 02 Jul 2019 13:33:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliyun.com; s=s1024;
 t=1562074374; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
 bh=RPDFdyKp8ZK5GUdmXV9I38qKv1OCQq69njcj49fcm3k=;
 b=eyvE5kwEbLBG0CIHrvdlO6Na9Qk5xSejdBORKewXxEX2IfXebqSnJrP/CGcJteck4cGi4OkY19DfO5GzdI/IMZTvIgE7da5JbFz4fTLHjXAfHlU1PTXUBMfsBZzglA8h+FDno42SxgRQwn1wKvYeNe76IvDOT+/yQxE7pV8KC1E=
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1089059|-1; CH=green; DM=||false|;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01e07417; MF=fishland@aliyun.com; NM=1; PH=DW; RN=6;
 RT=6; SR=0; TI=W4_5591869_v5_0AC264CD_1562074107716_o7001c166g; 
Received: from WS-web
 (fishland@aliyun.com[W4_5591869_v5_0AC264CD_1562074107716_o7001c166g]) by
 e01e04407.eu6 at Tue, 02 Jul 2019 21:32:53 +0800
Date: Tue, 02 Jul 2019 21:32:53 +0800
To: "Chao Yu" <chao@kernel.org>, "jaegeuk" <jaegeuk@kernel.org>,
 "yuchao0" <yuchao0@huawei.com>
Message-ID: <e5dfd648-63c1-4fbc-9598-78f768ba66d3.fishland@aliyun.com>
X-Mailer: [Alimail-Mailagent revision 29][W4_5591869][v5][Firefox]
MIME-Version: 1.0
References: <20190701133841.3201-1-fishland@aliyun.com>,
 <c02efb8b-0ee0-665f-4b33-08ee694cc659@kernel.org>
x-aliyun-mail-creator: W4_5591869_v5_IHJTW96aWxsYS81LjAgKFgxMTsgRmVkb3JhOyBMaW51eCB4ODZfNjQ7IHJ2OjY2LjApIEdlY2tvLzIwMTAwMTAxIEZpcmVmb3gvNjYuMA==jQ
In-Reply-To: <c02efb8b-0ee0-665f-4b33-08ee694cc659@kernel.org>
X-Headers-End: 1hiIu5-002eoE-IU
Subject: Re: [f2fs-dev] 
 =?utf-8?q?=5BPATCH=5D_f2fs=3A_use_multiplication_inst?=
 =?utf-8?q?ead_of_division_in_sanity=5Fcheck=5Fraw=5Fsuper?=
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
From: fishland via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: fishland <fishland@aliyun.com>
Cc: linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>,
 "liu.song11" <liu.song11@zte.com.cn>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

Thanks for your reply, I understand why there can't use multiplication, thanks a lot :D

Best regards
Liu Song

>Hi Song,
>
>On 2019-7-1 21:38, Liu Song via Linux-f2fs-devel wrote:
>> From: Liu Song <liu.song11@zte.com.cn>
>> 
>> Use multiplication instead of division and be more
>> consistent with f2fs_msg output information.
>> 
>> Signed-off-by: Liu Song <liu.song11@zte.com.cn>
>> ---
>>  fs/f2fs/super.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index af58b2cc21b8..eba4c0f9c347 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -2489,7 +2489,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>>    return 1;
>>   }
>>  
>> - if ((segment_count / segs_per_sec) < total_sections) {
>
>I think we use division intentionally to avoid potential overflow when doing
>multiplication.
>
>You can see the detailed commit message in below fixing patch:
>
>0cfe75c5b011 ("f2fs: enhance sanity_check_raw_super() to avoid potential overflows")
>
>Thanks,
>
>> + if (segment_count < (segs_per_sec * total_sections)) {
>>    f2fs_msg(sb, KERN_INFO,
>>     "Small segment_count (%u < %u * %u)",
>>     segment_count, segs_per_sec, total_sections);
>> 

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
